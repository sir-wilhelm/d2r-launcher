# D2r launcher

[SaveB.netAccount.ps1][SaveB.netAccount.ps1] saves accounts used by LaunchD2R.ps1 into the Windows Credential Manager.

[LaunchD2R.ps1][LaunchD2R.ps1] launches D2R passing in credentials skipping the Battle.net Launcher. 

If you want to launch multiple copies of D2R, you will need to kill the Multiple Instance handle after each launch. More infomation can be found here: https://github.com/sir-wilhelm/d2r-handle-closer

## How to run

Download the two PowerShell scripts and then run [SaveB.netAccount.ps1][SaveB.netAccount.ps1] for each b.net account you have.

Then use [LaunchD2R.ps1][LaunchD2R.ps1] passing in the same Account name you used while saving credentials.

Notes:
* You'll likely have to update the base `$d2rPath` with your install location(s)
  * and optionally drop the "ClientNumber" or change the default value.
* This won't work if your account has 2FA (Two-factor authentication) enabled.
* It won't work if you password is longer than 20 characters.

# License

[MIT License](/LICENSE)

[LaunchD2R.ps1]: /LaunchD2R.ps1?raw=1
[SaveB.netAccount.ps1]: /SaveB.netAccount.ps1?raw=1
