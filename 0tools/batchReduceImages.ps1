# Proposito: Achicar (o agrandar) todas las imagenes (recursivamente) a un maximo
#           de 512x512 preservando AspectRatio, osea que el lado mas 
#           grande sera 512 ya sea de alto o de ancho

# $raizDir = "E:\assets3D\main\"
# $raizDir = "E:\assets3D\main\props_vegetation\"
$raizDir =  "E:\assets3D\main\aaa\Content\"

$jpgFiles = Get-ChildItem -Path $raizDir -Filter *.jpg -Recurse
# $jpgFiles = Get-ChildItem -Path $raizDir -Filter *.png -Recurse

foreach ($file in $jpgFiles) {
    Write-Output "convirtiendo: $file"

    # $command = "magick convert `"$($file)`" -resize 400x400 `"$file`""
    $command = "magick convert `"$($file)`" -resize 1024x1024 `"$file`""

    Invoke-Expression $command
}