$stagingRootFolder = "D:\Battle.net\Diablo II Resurrected - shortcuts\Mods\mods"
if (Get-ChildItem $stagingRootFolder -ErrorAction SilentlyContinue) {
    "$stagingRootFolder has files, Ctrl + C to cancel or to delete them:"
    Pause
    Get-ChildItem -Path $stagingRootFolder -Force | Remove-Item -Recurse -Force
}

Expand-Archive -Path "D:\Battle.net\Diablo II Resurrected - shortcuts\Mods\LowHDmain*.zip" -DestinationPath $stagingRootFolder
Expand-Archive -Path "D:\Battle.net\Diablo II Resurrected - shortcuts\Mods\LowHDpartial*.zip" -DestinationPath $stagingRootFolder

$modinfoPaths = @(
    "D:\Battle.net\Diablo II Resurrected - shortcuts\Mods\mods\lowHDmain\lowHDmain.mpq\modinfo.json",
    "D:\Battle.net\Diablo II Resurrected - shortcuts\Mods\mods\lowHDpartial\lowHDpartial.mpq\modinfo.json"
)

$modinfoPaths | ForEach-Object { (Get-Content -Raw -LiteralPath $_) -replace '\.\./', './lowHD' | Set-Content -LiteralPath $_ -NoNewline }

$source = "D:\Battle.net\Diablo II Resurrected - 1"
Move-Item -Path $stagingRootFolder -Destination $source -Force

$sourceMods = "D:\Battle.net\Diablo II Resurrected - 1\mods"
$destinations = @(
    "D:\Battle.net\Diablo II Resurrected - 2\mods",
    "D:\Battle.net\Diablo II Resurrected - 3\mods",
    "D:\Battle.net\Diablo II Resurrected - 4\mods",
    "D:\Battle.net\Diablo II Resurrected - 5\mods",
    "D:\Battle.net\Diablo II Resurrected - 6\mods",
    "D:\Battle.net\Diablo II Resurrected - 7\mods",
    "D:\Battle.net\Diablo II Resurrected - 8\mods"
)

$destinations | ForEach-Object { New-Item -ItemType SymbolicLink -Path $_ -Target $sourceMods }
