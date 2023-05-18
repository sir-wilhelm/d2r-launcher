# D2R Repository
This repository holds scripts that I have written for Diablo II: Resurrected

D2RLaunchScript.ps1 is the powershell script I use to launch D2R without using the Battle.net Launcher.

Before you launch the script, you will need to edit the following values and set them to whatever you will be using.

$loginEmail = "username@example.com" # Email used to login to your Battle.net Account.  
$d2rPath = "C:\Blizzard\Diablo II Resurrected" # Path to your Diablo 2 Resurrected folder  
$d2rPasswordPath = "C:\Blizzard\$loginEmail.txt" # Path where you want to save your encrypted password  

This script will prompt you for your password and store it on your local computer in an encrypted format.  
More information on this process can be found here:  
https://social.technet.microsoft.com/wiki/contents/articles/4546.working-with-passwords-secure-strings-and-credentials-in-windows-powershell.aspx

If you want to launch multiple copies of D2R, you will need to kill the Multiple Instance handle after each launch.

More infomation can be found here:  
https://us.forums.blizzard.com/en/d2r/t/how-to-multiple-d2r-instances-requires-two-accounts/60546