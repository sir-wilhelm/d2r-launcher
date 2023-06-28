#Requires -Modules CredentialManager

param(
    [Parameter(Mandatory = $true)]
    [string]$Account,

    [ValidateSet("direct", "launcher")]
    [string]$LaunchMode = "direct",

    [ValidateSet("eu", "us", "kr")]
    [string]$Region = "us",

    [ValidateSet("1", "2", "3", "4", "5")]
    [string]$ClientNumber = "2"
)

Import-Module CredentialManager

$credential = Get-StoredCredential -Target "b.net/$Account"
if (!$credential) {
    "Account not found, make sure it was saved with "
    exit 1
}

$d2rPath = "D:\Battle.net\Diablo II Resurrected - $ClientNumber"

if ($LaunchMode -eq "direct") {
    & "$d2rPath\D2R.exe" -address "$Region.actual.battle.net" -username $credential.UserName -password $credential.GetNetworkCredential().Password
}
else {
    & "$d2rPath\Diablo II Resurrected Launcher.exe"
}

Start-Sleep 3

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
