# Servidor HTTP Simple para pruebas OAuth
Write-Host "Iniciando servidor web en puerto 3000..." -ForegroundColor Green

# Cambiar al directorio de la aplicación construida
Set-Location "c:\Proyectos_Flutter\ipi_deli_tour\build\web"

# Crear y iniciar servidor HTTP
Add-Type -AssemblyName System.Web
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:3000/')
$listener.Start()

Write-Host "Servidor activo en http://localhost:3000" -ForegroundColor Green
Write-Host "Listo para probar autenticacion Google OAuth" -ForegroundColor Yellow

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    
    $localPath = $request.Url.LocalPath
    if ($localPath -eq '/') { 
        $localPath = '/index.html' 
    }
    
    $filename = Join-Path (Get-Location) ($localPath.TrimStart('/'))
    
    if (Test-Path $filename) {
        $content = [System.IO.File]::ReadAllBytes($filename)
        $response.ContentLength64 = $content.Length
        $response.OutputStream.Write($content, 0, $content.Length)
    } else {
        $response.StatusCode = 404
    }
    
    $response.Close()
    Write-Host "Servido: $localPath"
}