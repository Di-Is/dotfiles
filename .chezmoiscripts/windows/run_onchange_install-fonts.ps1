$FontUrl = "https://github.com/mjun0812/RobotoMonoJP/releases/download/v5.0.0/RobotoMonoJP-Mono-Regular.ttf"
$FontName = "RobotoMonoJP-Mono-Regular.ttf"
$DownloadPath = "$env:TEMP\$FontName"

# Download the font
Invoke-WebRequest -Uri $FontUrl -OutFile $DownloadPath

# Register the font
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
$fonts.CopyHere($DownloadPath)

Write-Output "Font installed successfully."
