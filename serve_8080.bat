@echo off
echo 🚀 Iniciando servidor local en puerto 8080...
echo 📁 Sirviendo archivos desde build/web
echo 🌐 URL: http://localhost:8080
echo.

cd build\web

echo ✅ Abriendo navegador...
start http://localhost:8080

echo 📡 Iniciando servidor HTTP...
echo ❌ Presiona Ctrl+C para detener el servidor
echo.

powershell -Command "& {$l=New-Object Net.HttpListener;$l.Prefixes.Add('http://localhost:8080/');$l.Start();Write-Host 'Servidor iniciado en http://localhost:8080' -ForegroundColor Green;try{while($l.IsListening){$c=$l.GetContext();$r=$c.Request;$res=$c.Response;$path=$r.Url.LocalPath.TrimStart('/');if(!$path -or $path -eq ''){$path='index.html'};$file=Join-Path (Get-Location) $path;if(Test-Path $file){$content=[IO.File]::ReadAllBytes($file);$res.ContentLength64=$content.Length;$res.OutputStream.Write($content,0,$content.Length)}else{$index=Join-Path (Get-Location) 'index.html';if(Test-Path $index){$content=[IO.File]::ReadAllBytes($index);$res.ContentLength64=$content.Length;$res.OutputStream.Write($content,0,$content.Length)}};$res.Close();Write-Host $(Get-Date -Format 'HH:mm:ss') $r.HttpMethod $r.Url.LocalPath -ForegroundColor Gray}}finally{$l.Stop();$l.Dispose();Write-Host 'Servidor detenido' -ForegroundColor Yellow}}"