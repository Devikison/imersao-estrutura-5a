# Gera as versoes JPEG otimizadas das capas do hero a partir dos PNG originais.
# A pagina carrega os JPEG; os PNG ficam no repositorio apenas como arquivo-fonte.
# Uso (PowerShell, na raiz do projeto), depois de trocar assets\hero-creative.png
# e/ou assets\hero-creative-mobile.png:
#   powershell -ExecutionPolicy Bypass -File tools\make-hero-jpg.ps1
# Tamanhos esperados dos PNG: desktop 1920x1080, mobile 1080x1620 (proporcao 2:3).
Add-Type -AssemblyName System.Drawing
$assets = Join-Path (Split-Path -Parent $PSScriptRoot) "assets"
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
function Save-Jpg($src, $dst, $w, $q) {
  $img = [System.Drawing.Image]::FromFile($src)
  $w = [math]::Min($w, $img.Width)
  $h = [int][math]::Round($img.Height * $w / $img.Width)
  $bmp = New-Object System.Drawing.Bitmap $w, $h
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
  $g.DrawImage($img, 0, 0, $w, $h)
  $ep = New-Object System.Drawing.Imaging.EncoderParameters 1
  $ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), ([long]$q)
  $bmp.Save($dst, $codec, $ep)
  $g.Dispose(); $bmp.Dispose(); $img.Dispose()
  "$([IO.Path]::GetFileName($dst)) ${w}x${h} q$q : $([math]::Round((Get-Item $dst).Length/1KB)) KB"
}
$d = Join-Path $assets "hero-creative.png"
$m = Join-Path $assets "hero-creative-mobile.png"
Save-Jpg $d (Join-Path $assets "hero-creative-1920.jpg") 1920 92
Save-Jpg $d (Join-Path $assets "hero-creative-1366.jpg") 1366 90
Save-Jpg $m (Join-Path $assets "hero-creative-mobile-1080.jpg") 1080 92
Save-Jpg $m (Join-Path $assets "hero-creative-mobile-828.jpg") 828 90
