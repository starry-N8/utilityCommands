$SourceRoot = ""
# ← where you want all your converted PNGs to go
$DestRoot   = Join-Path $SourceRoot "Processed"

Get-ChildItem -Path $SourceRoot -Recurse -Filter *.png | ForEach-Object {
    $input = $_.FullName

    # Recreate the same subfolder under $DestRoot
    $relativeDir = $_.DirectoryName.Substring($SourceRoot.Length).TrimStart('\')
    $outputDir   = Join-Path $DestRoot $relativeDir
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir | Out-Null
    }

    # keep original filename
    $outputName = $_.Name
    $outputPath = Join-Path $outputDir $outputName

    # convert to 1280×720, preserving alpha
    ffmpeg -y -i "$input" `
        -vf "scale=1280:720,format=rgba" `
        -frames:v 1 -q:v 2 `
        "$outputPath"

    Write-Host "Converted: $input → $outputPath"
}
