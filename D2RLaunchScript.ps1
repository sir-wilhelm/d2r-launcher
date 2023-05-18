### Script to encrypt your login password and launch Diablo 2 Resurrected
### You can also choose to launch the launcher instead of directly launching the game.
### This script will NOT work if you have 2 Factor Authentication enabled - you will need to use the Launcher in that case.
### Please note, you will need to use handle64.exe to kill the multiple instance handle if you want to run multiple copies of D2R

$loginEmail = "username@example.com" # Email used to login to your Battle.net Account.
$d2rPath = "C:\Blizzard\Diablo II Resurrected" # Path to your Diablo 2 Resurrected folder
$d2rPasswordPath = "C:\Blizzard\$loginEmail.txt" # Path where you want to save your encrypted password
# If the credential file does not exist. Prompt the user to create it.
if (-not (Test-Path $d2rPasswordPath -PathType Leaf))
{
    Write-Host Creating Encrypted Credentials File. Max Password Length is *20* Characters
    Write-Host Please enter your password in the password line of the credentials pop up.
    Write-Host  This uses Windows 
    $credential = Get-Credential -Username "notused" -Message "Please enter a your password in the password field."
    $credential.Password | ConvertFrom-SecureString | Set-Content $d2rPasswordPath
 }

$encryptedPassword = Get-Content $d2rPasswordPath | ConvertTo-SecureString # Get the encrypted password from the file.
$credentials = New-Object System.Management.Automation.PsCredential($loginEmail, $encryptedPassword) # stuff the password into a PsCredentials object so we can use it later.

$direct = Read-Host "Select launch mode (Direct - 1, Launcher - 2)"

if($direct -eq "1")
{
    $region = Read-Host "Specify region: eu/us/kr"
        if ($region -eq "eu" -or $region -eq "us" -or $region -eq "kr"){
            Write-Host Launching on $region'.actual.battle.net'
            Sleep -seconds 2
            }
        else{
            do {
                $region = Read-Host "Invalid Region. Specify region: eu/us/kr"
            }
            until ($region -eq "eu" -or $region -eq "us" -or $region -eq "kr")
        }
        
	& "$d2rPath\D2R.exe" -username $loginEmail -password $credentials.GetNetworkCredential().Password -address $region'.actual.battle.net' # Decrypt the password and pass it to D2R.exe.
}elseif ($direct -eq "2") {
	& "$d2rPath\Diablo II Resurrected Launcher.exe" # Launch the launcher if the user desires
}
else{
    Write-Host "Invalid Input Detected"
}
