$FontUrl = "https://github.com/mjun0812/RobotoMonoJP/releases/download/v5.0.0/RobotoMonoJP-Mono-Regular.ttf"
$FontName = "RobotoMonoJP-Mono-Regular.ttf"
$DownloadPath = "$env:TEMP\$FontName"
$FontDestPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\$FontName"

# Download the font
Invoke-WebRequest -Uri $FontUrl -OutFile $DownloadPath

# Copy the font to the user's Fonts folder
Copy-Item -Path $DownloadPath -Destination $FontDestPath -Force

# Register the font in the registry
$RegistryPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
$RegistryName = "Roboto Mono JP (TrueType)"
Set-ItemProperty -Path $RegistryPath -Name $RegistryName -Value $FontName

# Restart Explorer to refresh font cache
taskkill /IM explorer.exe /F
Start-Process explorer.exe

Write-Output "Font installed successfully."