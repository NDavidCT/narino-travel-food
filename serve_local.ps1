# Servidor HTTP simple para servir aplicación Flutter Web en puerto 8080
$port = 8080
$webPath = "build/web"

# Verificar que el directorio build/web existe
if (-not (Test-Path $webPath)) {
    Write-Host "Error: No se encontró el directorio build/web" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Iniciando servidor HTTP en puerto $port" -ForegroundColor Green
Write-Host "📁 Sirviendo archivos desde: $webPath" -ForegroundColor Yellow
Write-Host "🌐 URL: http://localhost:$port" -ForegroundColor Cyan
Write-Host "❌ Presiona Ctrl+C para detener el servidor" -ForegroundColor White

# Cambiar al directorio build/web
Set-Location $webPath

# Crear y iniciar el servidor HTTP
$httpListener = New-Object System.Net.HttpListener
$httpListener.Prefixes.Add("http://localhost:$port/")

try {
    $httpListener.Start()
    Write-Host "✅ Servidor iniciado exitosamente" -ForegroundColor Green
    
    # Abrir navegador automáticamente
    Start-Process "http://localhost:$port"
    
    while ($httpListener.IsListening) {
        $context = $httpListener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        # Obtener la ruta del archivo solicitado
        $requestedPath = $request.Url.LocalPath.TrimStart('/')
        if ([string]::IsNullOrEmpty($requestedPath) -or $requestedPath -eq "/") {
            $requestedPath = "index.html"
        }
        
        # Ruta completa del archivo
        $filePath = Join-Path (Get-Location) $requestedPath
        
        if (Test-Path $filePath) {
            # Determinar el tipo de contenido
            $contentType = switch ([System.IO.Path]::GetExtension($filePath)) {
                ".html" { "text/html" }
                ".css" { "text/css" }
                ".js" { "application/javascript" }
                ".json" { "application/json" }
                ".png" { "image/png" }
                ".jpg" { "image/jpeg" }
                ".jpeg" { "image/jpeg" }
                ".ico" { "image/x-icon" }
                default { "application/octet-stream" }
            }
            
            # Leer y servir el archivo
            $content = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentType = $contentType
            $response.ContentLength64 = $content.Length
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            # Archivo no encontrado - servir index.html para SPAs
            $indexPath = Join-Path (Get-Location) "index.html"
            if (Test-Path $indexPath) {
                $content = [System.IO.File]::ReadAllBytes($indexPath)
                $response.ContentType = "text/html"
                $response.ContentLength64 = $content.Length
                $response.OutputStream.Write($content, 0, $content.Length)
            } else {
                $response.StatusCode = 404
                $errorContent = [System.Text.Encoding]::UTF8.GetBytes("404 - Archivo no encontrado")
                $response.OutputStream.Write($errorContent, 0, $errorContent.Length)
            }
        }
        
        $response.Close()
        
        # Mostrar log de la petición
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Write-Host "[$timestamp] $($request.HttpMethod) $($request.Url.LocalPath) - $($response.StatusCode)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    if ($httpListener.IsListening) {
        $httpListener.Stop()
    }
    $httpListener.Dispose()
    Write-Host "🛑 Servidor detenido" -ForegroundColor Yellow
}