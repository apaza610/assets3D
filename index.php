<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="codigo/estilo.css">
    <title>Assets</title>
</head>
<body>
    <?php 
        // echo "Los 📂 con assets **** son:<br>";

        // $lFolders = array_diff(scandir('./main/'), array('.', '..'));
        // foreach($lFolders as $folder){
        //     echo "📁-<a href='main/$folder/'>" . $folder . "</a><br>";
        // }

        $dazAssetsLocation = 'main';

        //******************escanear folder recursivamente************************/
        function listarJPGsConSPL($ubicacion){
            $fotos = [];
            $iterador = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($ubicacion));

            foreach ($iterador as $fileInfo){
                if ($fileInfo->isFile()){
                    if (preg_match('/\.jpg$/i', $fileInfo->getPathname())){
                        $fotos[] = $fileInfo->getPathname();
                    }
                }
            }
            return $fotos;
        }
        
        $todasLasFotos = listarJPGsConSPL($dazAssetsLocation);
        // echo nl2br(print_r($todasLasFotos, true));
        
        /********************* ordenar las fotos por categorias****************/
        $fotosCharacter = [];
        $fotosCreature  = [];
        $fotosClothes   = [];
        $fotosHair      = [];
        $fotosPoses     = [];
        $fotosProps     = [];
        $fotosEnvironments = [];
        $fotosVehicles  = [];
        $fotosMaterials = [];
        $fotosTools     = [];

        foreach ($todasLasFotos as $unafoto){
            if (strpos($unafoto, "character_") !== false){
                $fotosCharacter[] = $unafoto;
            }elseif(strpos($unafoto, "creature_") !== false){
                $fotosCreature[] = $unafoto;
            }elseif(strpos($unafoto, "clothes_") !== false){
                $fotosClothes[] = $unafoto;
            }elseif(strpos($unafoto, "hair_") !== false){
                $fotosHair[] = $unafoto;
            }elseif(strpos($unafoto, "poses_") !== false){
                $fotosPoses[] = $unafoto;
            }elseif(strpos($unafoto, "props_") !== false){
                $fotosProps[] = $unafoto;
            }elseif(strpos($unafoto, "environments_") !== false){
                $fotosEnvironments[] = $unafoto;
            }elseif(strpos($unafoto, "vehicles_") !== false){
                $fotosVehicles[] = $unafoto;
            }elseif(strpos($unafoto, "materials_") !== false){
                $fotosMaterials[] = $unafoto;
            }elseif(strpos($unafoto, "tools_") !== false){
                $fotosTools[] = $unafoto;
            }
        }

        //***********************escribir a database***************************/
        $nombreDB = 'database.txt';
        $database = fopen($nombreDB, 'w');

        $contenido = implode(PHP_EOL ,$todasLasFotos);
        file_put_contents($nombreDB, $contenido);

        //***********************mostrar las fotos***************************/
        function mostrarFotos($listaDeFotos){
            foreach ($listaDeFotos as $unafoto){
                $leyenda = explode("_", $unafoto)[3];
                $leyenda = explode(".", $leyenda)[0];
                echo '<ruby><img src="' . $unafoto . '"><rt>' . $leyenda . '</rt></ruby>';
            }
        }

        mostrarFotos($fotosCharacter);
        echo "<hr>";
        mostrarFotos($fotosCreature);
        echo "<hr>";
        mostrarFotos($fotosHair);
        echo "<hr>";
        mostrarFotos($fotosClothes);
        echo "<hr>";
        mostrarFotos($fotosPoses);
        echo "<hr>";
        mostrarFotos($fotosProps);
        echo "<hr>";
        mostrarFotos($fotosEnvironments);
        echo "<hr>";
        mostrarFotos($fotosVehicles);
        echo "<hr>";
        mostrarFotos($fotosMaterials);
        echo "<hr>";
        mostrarFotos($fotosTools);
        
    ?>
</body>
</html>