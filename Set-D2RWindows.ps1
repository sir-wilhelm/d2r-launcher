param([switch]$Verbose, [switch]$PassThru)

Function Split-AcrossMultiMonitors {
    $d2rProcesses = Get-Process D2r | Sort-Object -Property Path

    # 2x 2560x1440 w/ d2r at 1280x800 - use both monitors
    foreach ($d2rProcess in $d2rProcesses) {
        if ($d2rProcess.Path -match "(?<clientNum>\d+)") {
            $clientNum = $matches["clientNum"]
            $title = "$clientNum - Diablo II: Resurrected"
            switch ($clientNum) {
                1 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 1270 -Y 557 -Title $title -Verbose:$Verbose -PassThru:$PassThru } # main (bottom right)
                2 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2551 -Y 606 -Title $title -Verbose:$Verbose -PassThru:$PassThru } #bottom left
                3 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2551 -Y   0 -Title $title -Verbose:$Verbose -PassThru:$PassThru } #top left
                4 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3830 -Y   0 -Title $title -Verbose:$Verbose -PassThru:$PassThru } #top right
                5 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3830 -Y 606 -Title $title -Verbose:$Verbose -PassThru:$PassThru } #bottom right
                6 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 1270 -Y   0 -Title $title -Verbose:$Verbose -PassThru:$PassThru } # main (top right)
                7 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X   -9 -Y   0 -Title $title -Verbose:$Verbose -PassThru:$PassThru } # main (top left)
                8 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X   -9 -Y 557 -Title $title -Verbose:$Verbose -PassThru:$PassThru } # main (bottom left)
                9 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3190 -Y 275 -Title $title -Verbose:$Verbose -PassThru:$PassThru } #center
                0 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  630 -Y 299 -Title $title -Verbose:$Verbose -PassThru:$PassThru } # main (center)
            }
        }
    }

    exit
}

Start-Sleep 3
Split-AcrossMultiMonitors

return

$d2rProcesses = Get-Process D2r | Sort-Object -Property Path

# 2x 2560x1440 w/ d2r at 1280x800 - use right monitor mostly
foreach ($d2rProcess in $d2rProcesses) {
    if ($d2rProcess.Path -match "(?<clientNum>\d+)") {
        switch ($matches["clientNum"]) {
            1 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2551 -Y   0 -Verbose:$Verbose -PassThru:$PassThru } #top left
            2 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 1270 -Y 557 -Verbose:$Verbose -PassThru:$PassThru } # main (bottom right)
            3 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2551 -Y 606 -Verbose:$Verbose -PassThru:$PassThru } #bottom left
            4 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3830 -Y   0 -Verbose:$Verbose -PassThru:$PassThru } #top right
            5 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2551 -Y   0 -Verbose:$Verbose -PassThru:$PassThru } #top left
            6 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2551 -Y 606 -Verbose:$Verbose -PassThru:$PassThru } #bottom left
            7 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3830 -Y   0 -Verbose:$Verbose -PassThru:$PassThru } #top right
            8 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3830 -Y 606 -Verbose:$Verbose -PassThru:$PassThru } #bottom right
            9 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3830 -Y 606 -Verbose:$Verbose -PassThru:$PassThru } #bottom right
        }
    }
}

# 2x 2560x1440 w/ d2r at 1920x1080
foreach ($d2rProcess in $d2rProcesses) {
    if ($d2rProcess.Path -match "(?<clientNum>\d+)") {
        switch ($matches["clientNum"]) {
            1 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3180 -Y  10 -Verbose:$Verbose -PassThru:$PassThru }
            2 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 3020 -Y 110 -Verbose:$Verbose -PassThru:$PassThru }
            3 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 123 -Verbose:$Verbose -PassThru:$PassThru }
            4 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2860 -Y 210 -Verbose:$Verbose -PassThru:$PassThru }
            5 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2700 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
            #6 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
            #7 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
            #8 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
        }
    }
}

# ultrawide - 3400x1440 w/ d2r at 1280x800
foreach ($d2rProcess in $d2rProcesses) {
    if ($d2rProcess.Path -match "(?<clientNum>\d+)") {
        switch ($matches["clientNum"]) {
            1 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  -10 -Y   0 -Verbose:$Verbose -PassThru:$PassThru }
            2 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 1070 -Y   0 -Verbose:$Verbose -PassThru:$PassThru }
            3 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 1070 -Y 558 -Verbose:$Verbose -PassThru:$PassThru }
            4 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X 2150 -Y   0 -Verbose:$Verbose -PassThru:$PassThru }
            5 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
            #6 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
            #7 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
            #8 { & "$PSScriptRoot\Set-Window.ps1" -Id $d2rProcess.Id -X  310 -Y 310 -Verbose:$Verbose -PassThru:$PassThru }
        }
    }
}
