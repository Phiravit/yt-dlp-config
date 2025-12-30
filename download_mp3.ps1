# Check if links.txt exists
if (-not (Test-Path "links.txt")) {
    Write-Host "Error: links.txt not found!" -ForegroundColor Red
    exit 1
}

# Run yt-dlp
Write-Host "Starting download from links.txt..." -ForegroundColor Cyan
.\yt-dlp.exe -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --ignore-errors --no-playlist -a links.txt -o "%(title)s.%(ext)s"
Write-Host "Download complete!" -ForegroundColor Green
