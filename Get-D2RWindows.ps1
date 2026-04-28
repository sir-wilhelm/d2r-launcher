$d2rProcesses = Get-Process D2r | Sort-Object -Property Path
foreach ($d2rProcess in $d2rProcesses) {
    if ($d2rProcess.Path -match "(?<clientNum>\d+)") {
        & "$PSScriptRoot\Get-Window.ps1" -Id $d2rProcess.Id -Verbose:$true
    }
}
