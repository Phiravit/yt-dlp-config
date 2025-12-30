# YouTube MP3 Downloader

A simple set of PowerShell scripts to batch download YouTube videos as high-quality MP3s using `yt-dlp`.

## Prerequisites

1.  **PowerShell** (Pre-installed on Windows)
2.  **yt-dlp.exe** (Required in this folder)
3.  **FFmpeg** (Required for MP3 conversion and embedding thumbnails)

## Setup

### 1. Download yt-dlp
Open PowerShell in this folder and run the following command to download the latest `yt-dlp.exe`:

```powershell
Invoke-WebRequest -Uri "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe" -OutFile "yt-dlp.exe"
```

### 2. Install FFmpeg
`yt-dlp` needs FFmpeg to convert video to audio.
- Download it from [ffmpeg.org](https://ffmpeg.org/download.html).
- **Easier method**: If you have `winget` installed, run:
  ```powershell
  winget install Gyan.FFmpeg
  ```
- Alternatively, download the FFmpeg executables (`ffmpeg.exe`, `ffprobe.exe`) and place them in this **same folder** or add them to your system PATH.

## How to Use (Short Term)

1.  **Add Links**: Open `links.txt` and paste the YouTube URLs you want to download (one per line).
2.  **Run Downloader**:
    Right-click `download_mp3.ps1` and select **Run with PowerShell**.
    *(Or run `.\download_mp3.ps1` in your terminal)*

The script will download the videos, convert them to MP3, and attempt to embed metadata and thumbnails.

## Troubleshooting

### Thumbnails not embedding?
If you end up with separate image files (e.g., .webp or .jpg) alongside your MP3s, run the cleanup script:

```powershell
.\cleanup_mp3.ps1
```
This will merge the detached thumbnails into the MP3 files and delete the duplicates.
