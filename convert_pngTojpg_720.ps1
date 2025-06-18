# Convert all .png files in the current folder to 720p .jpg with yuv420p pixel format
Get-ChildItem -Filter *.png | ForEach-Object {
    $input = $_.FullName
    $output = "$($_.BaseName)_720p.jpg"
    ffmpeg -y -i "$input" -vf "scale=1280:720,format=yuv420p" -frames:v 1 -q:v 2 "$output"
    Write-Host "Converted: $input -> $output (yuv420p)"
}
