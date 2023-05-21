#Requires -Modules CredentialManager

param(
    [Parameter(Mandatory=$true)]
    [string]$Account,

    [ValidateSet("direct", "launcher")]
    [string]$LaunchMode = "direct",

    [ValidateSet("eu","us","kr")]
    [string]$Region = "us",

    [ValidateSet("1", "2", "3", "4", "5")]
    [string]$ClientNumber = "2"
)

Import-Module CredentialManager

$credential = Get-StoredCredential -Target "b.net/$Account"
if(!$credential) {
    "Account not found, make sure it was saved with "
    exit 1
}

$d2rPath = "D:\Battle.net\Diablo II Resurrected - $ClientNumber"

if($LaunchMode -eq "direct")
{
	& "$d2rPath\D2R.exe" -username $credential.UserName -password $credential.GetNetworkCredential().Password -address "$Region.actual.battle.net"
}
else{
    & "$d2rPath\Diablo II Resurrected Launcher.exe"
}