param (
    [parameter(Mandatory = $True)]
    [int]$Id,
    [switch]$PassThru
)

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
[Window]::GetWindowRect($handle, [ref]$rectangle) | Out-Null
Write-Verbose "Initial Position: X=$($rectangle.Left)"
Write-Verbose "Initial Position: Y=$($rectangle.Top)`n"
