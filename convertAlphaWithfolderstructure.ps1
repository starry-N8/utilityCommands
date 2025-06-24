# ← set this to your root of PNG-folders
$SourceRoot = "C:\Users\Deepa\Downloads\All Animals"
# ← where you want all your converted PNGs to go
$DestRoot   = Join-Path $SourceRoot "Processed"

Get-ChildItem -Path $SourceRoot -Recurse -Filter *.png | ForEach-Object {
    $input = $_.FullName

    # build the same relative folder under $DestRoot
    $relativeDir = $_.DirectoryName.Substring($SourceRoot.Length).TrimStart('\')
    $outputDir   = Join-Path $DestRoot $relativeDir
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir | Out-Null
    }

    # grab the immediate parent folder name, sanitize spaces for filename
    $parent     = Split-Path $_.DirectoryName -Leaf
    $safeParent = $parent -replace '\s+','_'

    # construct output filename
    $outputName = "{0}_{1}_720p.png" -f $safeParent, $_.BaseName
    $outputPath = Join-Path $outputDir $outputName

    # run ffmpeg, keep alpha with pix_fmt=rgba
    ffmpeg -y -i "$input" `
        -vf "scale=1280:720,format=rgba" `
        -frames:v 1 -q:v 2 `
        "$outputPath"

    Write-Host "Converted: $input → $outputPath"
}
