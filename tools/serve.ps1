# Servidor estatico local para pre-visualizar a landing page sem Python ou Node.
# Uso (PowerShell, na raiz do projeto):
#   powershell -ExecutionPolicy Bypass -File tools\serve.ps1
# Depois abra http://localhost:8787/ no navegador. Ctrl+C encerra.
param([int]$Port = 8787)
$Root = Split-Path -Parent $PSScriptRoot
$mime = @{ ".html"="text/html; charset=utf-8"; ".js"="application/javascript"; ".css"="text/css"; ".png"="image/png"; ".jpg"="image/jpeg"; ".jpeg"="image/jpeg"; ".svg"="image/svg+xml"; ".ico"="image/x-icon"; ".json"="application/json"; ".woff2"="font/woff2"; ".webp"="image/webp" }
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Servindo $Root em http://localhost:$Port/  (Ctrl+C para parar)"
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  try {
    $path = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath)
    if ($path -eq "/") { $path = "/index.html" }
    $file = Join-Path $Root ($path -replace "/", "\")
    if (Test-Path $file -PathType Leaf) {
      $bytes = [IO.File]::ReadAllBytes($file)
      $ext = [IO.Path]::GetExtension($file).ToLower()
      $ctx.Response.ContentType = if ($mime.ContainsKey($ext)) { $mime[$ext] } else { "application/octet-stream" }
      $ctx.Response.Headers.Add("Cache-Control", "no-store")
      $ctx.Response.ContentLength64 = $bytes.Length
      $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
      $ctx.Response.StatusCode = 404
    }
  } catch { $ctx.Response.StatusCode = 500 }
  $ctx.Response.OutputStream.Close()
}
