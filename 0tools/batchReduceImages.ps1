# Proposito: Achicar (o agrandar) todas las imagenes (recursivamente) a un maximo
#           de 512x512 preservando AspectRatio, osea que el lado mas 
#           grande sera 512 ya sea de alto o de ancho
# 
$raizDir = "E:\assets3D\main\Animal_DazHorse3\Content\"
# $raizDir =  "E:\assets3D\main\aaa\"
# $dimenMax = "400x400>"
$dimenMax = "1024x1024>"

$jpgFiles = Get-ChildItem -Path $raizDir -Filter *.jpg -Recurse
$pngFiles = Get-ChildItem -Path $raizDir -Filter *.png -Recurse

foreach ($file in $jpgFiles) {
    Write-Output "convirtiendo: $file"
    $command = "magick convert `"$($file)`" -resize $dimenMax `"$file`""
    Invoke-Expression $command
}
foreach ($file in $pngFiles) {
    Write-Output "convirtiendo: $file"
    $command = "magick convert `"$($file)`" -resize $dimenMax `"$file`""
    Invoke-Expression $command
}