param (
    [parameter(Mandatory = $True, ValueFromPipeline = $False, ParameterSetName = 'Id')]
    [int]$Id,
    [int]$X,
    [int]$Y,
    [int]$Width,
    [int]$Height,
    [switch]$PassThru
)
Begin {
    try { 
        [void][Window]
    }
    catch {
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
    $process = Get-Process -Id $Id -ErrorAction SilentlyContinue
    if ($null -eq $process) {
        Write-Warning "Cannot find a process with the process identifier $Id"
        return
    }
    $handle = $process.MainWindowHandle
    Write-Verbose "$($process.ProcessName) `(Id=$($process.Id), Handle=$handle`, Path=$($process.Path))"
    if ($handle -eq [System.IntPtr]::Zero) {
        return
    }
    $rectangle = New-Object RECT
    $gotWindow = [Window]::GetWindowRect($handle, [ref]$rectangle)
    Write-Verbose "Initial Position$($rectangle | Out-String)"
    if (-NOT $PSBoundParameters.ContainsKey('X')) {
        $X = $rectangle.Left            
    }
    if (-NOT $PSBoundParameters.ContainsKey('Y')) {
        $Y = $rectangle.Top
    }
    if (-NOT $PSBoundParameters.ContainsKey('Width')) {
        $Width = $rectangle.Right - $rectangle.Left
    }
    if (-NOT $PSBoundParameters.ContainsKey('Height')) {
        $Height = $rectangle.Bottom - $rectangle.Top
    }
    if ($gotWindow) {
        [Window]::MoveWindow($handle, $x, $y, $Width, $Height, $True) | Out-Null
    }
    if ($PSBoundParameters['Passthru']) {
        $rectangle = New-Object RECT
        if ([Window]::GetWindowRect($handle, [ref]$rectangle)) {
            $Height = $rectangle.Bottom - $rectangle.Top
            $Width = $rectangle.Right - $rectangle.Left
            $Size = New-Object System.Management.Automation.Host.Size -ArgumentList $Width, $Height
            $TopLeft = New-Object System.Management.Automation.Host.Coordinates -ArgumentList $rectangle.Left , $rectangle.Top
            $BottomRight = New-Object System.Management.Automation.Host.Coordinates -ArgumentList $rectangle.Right, $rectangle.Bottom
            if ($rectangle.Top -lt 0 -and
                $rectangle.Bottom -lt 0 -and
                $rectangle.Left -lt 0 -and
                $rectangle.Right -lt 0) {
                Write-Warning "$($process.ProcessName) `($($process.Id)`) is minimized. Coordinates will not be accurate."
            }
            $Object = [PSCustomObject]@{
                Id          = $process.Id
                ProcessName = $process.ProcessName
                Path        = $process.Path
                Size        = $Size
                TopLeft     = $TopLeft
                BottomRight = $BottomRight
            }
            $Object
        }
    }
}
