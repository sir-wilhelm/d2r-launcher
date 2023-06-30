$d2rProcesses = Get-Process D2r
foreach ($d2rProcess in $d2rProcesses) {
    $d2rProcess.Path
    $d2rProcess.Path -match "(?<clientNum>\d+)"
    switch ($matches["clientNum"]) {
        1 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3180 -Y  10 }
        2 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 123 }
        3 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3020 -Y 110 }
        4 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2860 -Y 210 }
        5 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2700 -Y 310 }
    }
}
