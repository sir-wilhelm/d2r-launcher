param([switch]$Verbose, [switch]$PassThru)

Function Split-AcrossMultiMonitors {
    $d2rProcesses = Get-Process D2r | Sort-Object -Property Path

    # 2x 2560x1440 w/ d2r at 1280x800 - use both monitors
    foreach ($d2rProcess in $d2rProcesses) {
        if ($d2rProcess.Path -match "(?<clientNum>\d+)") {
            switch ($matches["clientNum"]) {
                1 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2551 -Y   0 -Verbose:$Verbose -PassThru:$PassThru } #top left
                # ^v swapped for hammer on p1 chaos
                2 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 1270 -Y 557 -Verbose:$Verbose -PassThru:$PassThru } # main (bottom right)
                3 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2551 -Y 606 -Verbose:$Verbose -PassThru:$PassThru } #bottom left
                4 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3830 -Y   0 -Verbose:$Verbose -PassThru:$PassThru } #top right
                5 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3830 -Y 606 -Verbose:$Verbose -PassThru:$PassThru } #bottom right
                6 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 1270 -Y   0 -Verbose:$Verbose -PassThru:$PassThru } # main (top right)
                7 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X   -9 -Y   0 -Verbose:$Verbose -PassThru:$PassThru } # main (top left)
                8 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X   -9 -Y 557 -Verbose:$Verbose -PassThru:$PassThru } # main (bottom left)
                9 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3190 -Y 275 -Verbose:$Verbose -PassThru:$PassThru } #center
                0 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  630 -Y 299 -Verbose:$Verbose -PassThru:$PassThru } # main (center)
            }
        }
    }

    exit
}

Start-Sleep 3
Split-AcrossMultiMonitors
