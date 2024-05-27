$d2rProcesses = Get-Process D2r | Sort-Object -Property Path
foreach ($d2rProcess in $d2rProcesses) {
    if ($d2rProcess.Path -match "(?<clientNum>\d+)") {
        switch ($matches["clientNum"]) {
            1 { & "$PSScriptRoot\Get-Window.ps1" -Id $d2rProcess.Id -Verbose:$true }
            3 { & "$PSScriptRoot\Get-Window.ps1" -Id $d2rProcess.Id -Verbose:$true }
            2 { & "$PSScriptRoot\Get-Window.ps1" -Id $d2rProcess.Id -Verbose:$true }
            4 { & "$PSScriptRoot\Get-Window.ps1" -Id $d2rProcess.Id -Verbose:$true }
            5 { & "$PSScriptRoot\Get-Window.ps1" -Id $d2rProcess.Id -Verbose:$true }
        }
    }
}
