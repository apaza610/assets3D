# funcion: toma un .zip que no contiene folder "Content" y se lo pone pues 
#           asi lo requiere mi programa para enviar zip a libreria de Daz

# $pathZIP = "D:\borrador2\prueba.zip"
$pathZIP = $args[0]

$folder = Split-Path $pathZIP
$folder = $folder + "\Content"                                  # crear el folder Content
Expand-Archive -Path $pathZIP -DestinationPath $folder          # extraer el contenido a Content
Compress-Archive -Path $folder -DestinationPath $pathZIP -Force # comprimir el nuevo folder
Remove-Item $folder -Recurse                                    # eliminar el folder sobrante
