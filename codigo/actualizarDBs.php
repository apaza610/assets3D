<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../codigo/estilo.css">
    <title>Assets</title>
</head>
<body>
    <?php
        if($_SERVER["REQUEST_METHOD"] == "POST"){
            echo "<h2>...Se ha actualizando DataBases</h2>";
        }
        else{
            echo "no post";
            header("Location: ../");            // retornar a main page
        }

        $dazAssetsLocation = '../main';
        $todasLasFotos = [];
        //******************escanear folder recursivamente************************/
        function listarJPGsConSPL($ubicacion){
            $fotos = [];
            $iterador = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($ubicacion));

            foreach ($iterador as $fileInfo){
                if ($fileInfo->isFile()){
                    if (preg_match('/^(character_|creature_|clothes_|hair_|poses_|skydome_|props_|environments_|vehicles_|materials_|tools_).+\.jpg$/i', $fileInfo->getFilename())) {
                        $fotos[] = $fileInfo->getPathname();
                    }
                }
            }
            return $fotos;
        }
        $todasLasFotos = listarJPGsConSPL($dazAssetsLocation);  // contiene la totalidad de fotos de todas las categorias
        // echo nl2br(print_r($todasLasFotos, true));

        creaOactualizaDB("character", $todasLasFotos);
        creaOactualizaDB("creature", $todasLasFotos);
        creaOactualizaDB("clothes", $todasLasFotos);
        creaOactualizaDB("hair", $todasLasFotos);
        creaOactualizaDB("poses", $todasLasFotos);
        creaOactualizaDB("skydome", $todasLasFotos);
        creaOactualizaDB("props", $todasLasFotos);
        creaOactualizaDB("environments", $todasLasFotos);
        creaOactualizaDB("vehicles", $todasLasFotos);
        creaOactualizaDB("materials", $todasLasFotos);
        creaOactualizaDB("tools", $todasLasFotos);

        function creaOactualizaDB($tipo, array $todasLasFotos){
            $fotos = [];
            foreach ($todasLasFotos as $unafoto){
                if (strpos($unafoto, $tipo."_") !== false){
                    $fotos[] = $unafoto;
                }
            }
            $textoPlano = implode(PHP_EOL, $fotos);
            file_put_contents("DB".$tipo.".txt", $textoPlano);
        }


        //***********************mostrar las fotos***************************/
        // function mostrarFotos(){
        //     $lineas = file("DB".$_POST['categoria'].".txt", FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        //     foreach ($lineas as $unafoto){
        //         $leyenda = explode("_", $unafoto)[3];
        //         $leyenda = explode(".", $leyenda)[0];
        //         //-----------------metadata--------------------
        //         $size = getimagesize($unafoto, $info);
        //         $iptc = isset($info["APP13"]) ? iptcparse($info["APP13"]) : false;
        //         $mensaje = isset($iptc["2#120"]) ? $iptc["2#120"][0] : '~~~';
        //         // if(isset($info['APP13'])){
        //         //     $iptc = iptcparse($info['APP13']);
        //         //     // var_dump($iptc);
        //         //     $mensaje = $iptc["2#120"][0];
        //         // }
        //         echo '<ruby><img src="' . $unafoto . '" title="' . $mensaje . '"><rt>' . $leyenda . '</rt></ruby>';
               
        //     }
        // }

        // echo "<hr>";
        // mostrarFotos();
    ?>
    ------------------------------------

    
</body>
</html>