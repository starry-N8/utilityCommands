# Convert all .mov files in the current folder to 720p .mp4 for Unity (mobile-optimized)
Get-ChildItem -Filter *.mov | ForEach-Object {
    $input = $_.FullName
    $output = "$($_.BaseName)_720p.mp4"
    
    ffmpeg -y -i "$input" `
        -vf "scale=1280:720" `
        -r 24 `
        -c:v libx264 `
        -preset slow `
        -crf 23 `
        -pix_fmt yuv420p `
        -c:a aac `
        -b:a 128k `
        "$output"

    Write-Host "Converted: $input -> $output"
}
