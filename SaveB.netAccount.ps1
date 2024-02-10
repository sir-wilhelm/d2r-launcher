#Requires -Modules TUN.CredentialManager

param(
    [Parameter(Mandatory = $true)][string]$Account,
    [Parameter(Mandatory = $true)][string]$EmailAddress
)

$credential = Get-Credential -Credential $EmailAddress
New-StoredCredential -Target "b.net/$Account" -Username $EmailAddress -Password $credential.GetNetworkCredential().Password -Persist LocalMachine
