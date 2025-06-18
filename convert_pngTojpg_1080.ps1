# Convert all .png files in the current folder to 1080p .jpg with yuv420p pixel format
Get-ChildItem -Filter *.png | ForEach-Object {
    $input = $_.FullName
    $output = "$($_.BaseName)_1080p.jpg"
    ffmpeg -y -i "$input" -vf "scale=1920:1080,format=yuv420p" -frames:v 1 -q:v 2 "$output"
    Write-Host "Converted: $input -> $output (yuv420p)"
}
