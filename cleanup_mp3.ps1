$mp3Files = Get-ChildItem -Filter *.mp3

Write-Host "Scanning for MP3s with detached thumbnails..." -ForegroundColor Cyan

foreach ($file in $mp3Files) {
    $baseName = $file.BaseName
    
    $imageFile = $null
    $extensions = @(".webp", ".jpg", ".png", ".jpeg")
    
    foreach ($ext in $extensions) {
        $checkPath = Join-Path -Path "." -ChildPath "$baseName$ext"
        if (Test-Path $checkPath) {
            $imageFile = Get-Item $checkPath
            break
        }
    }

    if ($imageFile) {
        Write-Host "Found detached thumbnail for: " -NoNewline
        Write-Host $baseName -ForegroundColor Yellow
        $outputFile = "$baseName.merged.mp3"
        $argumentList = "-i `"$($file.Name)`" -i `"$($imageFile.Name)`" -map 0:0 -map 1:0 -c:a copy -c:v mjpeg -id3v2_version 3 -metadata:s:v title=`"Album cover`" -metadata:s:v comment=`"Cover (front)`" -y `"$outputFile`""
        
        try {
            $process = Start-Process -FilePath "ffmpeg" -ArgumentList $argumentList -Wait -NoNewWindow -PassThru
            if ($process.ExitCode -eq 0 -and (Test-Path $outputFile)) {
                Remove-Item $file.FullName -Force
                Remove-Item $imageFile.FullName -Force
                Rename-Item $outputFile $file.Name
                Write-Host "  [OK] Merged and cleaned up." -ForegroundColor Green
            } else {
                Write-Host "  [ERROR] FFmpeg failed or output missing." -ForegroundColor Red
            }
        } catch {
            Write-Host "  [ERROR] Could not run ffmpeg. Is it installed?" -ForegroundColor Red
        }
    }
}

Write-Host "Cleanup scan complete." -ForegroundColor Cyan
Read-Host "Press Enter to exit..."
