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
            if(isset($_POST['categoria'])){
                $eleccion = $_POST['categoria'];
                echo "<h2>..." . htmlspecialchars($eleccion) . ":</h2>";
            }else{
                echo "no color selected";
            }
        }

        $dazAssetsLocation = '../main';
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

        $fotosDeseadas= [];
        foreach ($todasLasFotos as $unafoto){
            if (strpos($unafoto, $eleccion) !== false){
                $fotosDeseadas[] = $unafoto;
            }
        }
        // echo nl2br(print_r($fotosDeseadas, true));

        //***********************mostrar las fotos***************************/
        function mostrarFotos($listaDeFotos){
            foreach ($listaDeFotos as $unafoto){
                $leyenda = explode("_", $unafoto)[3];
                $leyenda = explode(".", $leyenda)[0];
                //-----------------metadata--------------------
                $size = getimagesize($unafoto, $info);
                $iptc = isset($info["APP13"]) ? iptcparse($info["APP13"]) : false;
                $mensaje = isset($iptc["2#120"]) ? $iptc["2#120"][0] : '~~~';
                // if(isset($info['APP13'])){
                //     $iptc = iptcparse($info['APP13']);
                //     // var_dump($iptc);
                //     $mensaje = $iptc["2#120"][0];
                // }
                echo '<ruby><img src="' . $unafoto . '" title="' . $mensaje . '"><rt>' . $leyenda . '</rt></ruby>';
               
            }
        }

        echo "<hr>";
        mostrarFotos($fotosDeseadas);
    ?>
</body>
</html>