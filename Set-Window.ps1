Param (
    [parameter(Mandatory = $True, ValueFromPipeline = $False, ParameterSetName = 'Id')]
    [int]$Id,
    [int]$X,
    [int]$Y,
    [int]$Width,
    [int]$Height,
    [switch]$Passthru
)
Begin {
    Try { 
        [void][Window]
    }
    Catch {
        Add-Type @"
            using System;
            using System.Runtime.InteropServices;
            public class Window {
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool GetWindowRect(
                IntPtr hWnd, out RECT lpRect);
    
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public extern static bool MoveWindow( 
                IntPtr handle, int x, int y, int width, int height, bool redraw);
    
            [DllImport("user32.dll")] 
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool ShowWindow(
                IntPtr handle, int state);
            }
            public struct RECT
            {
            public int Left;        // x position of upper-left corner
            public int Top;         // y position of upper-left corner
            public int Right;       // x position of lower-right corner
            public int Bottom;      // y position of lower-right corner
            }
"@
    }
}
Process {
    $Rectangle = New-Object RECT
    If ( $PSBoundParameters.ContainsKey('Id') ) {
        $Processes = Get-Process -Id $Id -ErrorAction SilentlyContinue
    }
    if ( $null -eq $Processes ) {
        If ( $PSBoundParameters['Passthru'] ) {
            Write-Warning 'No process match criteria specified'
        }
    }
    else {
        $Handle = $Processes.MainWindowHandle
        Write-Verbose "$($Processes.ProcessName) `(Id=$($Processes.Id), Handle=$Handle`, Path=$($Processes.Path))"
        if ( $Handle -eq [System.IntPtr]::Zero ) { return }
        $Return = [Window]::GetWindowRect($Handle, [ref]$Rectangle)
        If (-NOT $PSBoundParameters.ContainsKey('X')) {
            $X = $Rectangle.Left            
        }
        If (-NOT $PSBoundParameters.ContainsKey('Y')) {
            $Y = $Rectangle.Top
        }
        If (-NOT $PSBoundParameters.ContainsKey('Width')) {
            $Width = $Rectangle.Right - $Rectangle.Left
        }
        If (-NOT $PSBoundParameters.ContainsKey('Height')) {
            $Height = $Rectangle.Bottom - $Rectangle.Top
        }
        If ( $Return ) {
            $Return = [Window]::MoveWindow($Handle, $x, $y, $Width, $Height, $True)
        }
        If ( $PSBoundParameters['Passthru'] ) {
            $Rectangle = New-Object RECT
            $Return = [Window]::GetWindowRect($Handle, [ref]$Rectangle)
            If ( $Return ) {
                $Height = $Rectangle.Bottom - $Rectangle.Top
                $Width = $Rectangle.Right - $Rectangle.Left
                $Size = New-Object System.Management.Automation.Host.Size -ArgumentList $Width, $Height
                $TopLeft = New-Object System.Management.Automation.Host.Coordinates -ArgumentList $Rectangle.Left , $Rectangle.Top
                $BottomRight = New-Object System.Management.Automation.Host.Coordinates -ArgumentList $Rectangle.Right, $Rectangle.Bottom
                If ($Rectangle.Top -lt 0 -AND 
                    $Rectangle.Bottom -lt 0 -AND
                    $Rectangle.Left -lt 0 -AND
                    $Rectangle.Right -lt 0) {
                    Write-Warning "$($Processes.ProcessName) `($($Processes.Id)`) is minimized! Coordinates will not be accurate."
                }
                $Object = [PSCustomObject]@{
                    Id          = $Processes.Id
                    ProcessName = $Processes.ProcessName
                    Size        = $Size
                    TopLeft     = $TopLeft
                    BottomRight = $BottomRight
                }
                $Object
            }
        }
        
    }
}
