#Requires -Modules TUN.CredentialManager

param(
    [Parameter(Mandatory = $true)]
    [string]$Account,
    [ValidateSet("direct", "launcher")]
    [string]$LaunchMode = "direct",
    [ValidateSet("eu", "us", "kr")]
    [string]$Region = "us",
    [ValidateSet("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")]
    [string]$ClientNumber = "2"
)

$credential = Get-StoredCredential -Target "b.net/$Account"
if (!$credential) {
    "Account not found, make sure it was saved with SaveB.netAccount.ps1."
    exit 1
}

$d2rPath = "D:\Battle.net\Diablo II Resurrected - $ClientNumber"

if ($LaunchMode -eq "direct") {
    & "$d2rPath\D2R.exe" -address "$Region.actual.battle.net" -username $credential.UserName -password $credential.GetNetworkCredential().Password
}
else {
    & "$d2rPath\Diablo II Resurrected Launcher.exe"
}

Start-Sleep 4

& "$PSScriptRoot\Set-D2RWindows.ps1"
