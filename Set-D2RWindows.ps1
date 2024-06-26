param([switch]$Verbose, [switch]$PassThru)

$d2rProcesses = Get-Process D2r | Sort-Object -Property Path
foreach ($d2rProcess in $d2rProcesses) {
    if ($d2rProcess.Path -match "(?<clientNum>\d+)") {
        switch ($matches["clientNum"]) {
            1 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3180 -Y  10 -Verbose:$Verbose -PassThru:$PassThru }
            2 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 123 -Verbose:$Verbose -PassThru:$PassThru }
            3 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3020 -Y 110 -Verbose:$Verbose -PassThru:$PassThru }
            4 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2860 -Y 210 -Verbose:$Verbose -PassThru:$PassThru }
            5 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2700 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
        }
    }
}
