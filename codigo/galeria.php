<?php
$folder = rtrim($_GET['img'], "/\\"); // clean trailing slashes
$allowed_extensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];

$images = [];

// Function to collect images from a directory
function collectImages($dir, $allowed_extensions) {
    $imgs = [];
    if (!is_dir($dir)) return $imgs;

    $files = scandir($dir);
    foreach ($files as $file) {
        if ($file === '.' || $file === '..') continue;
        $path = "$dir/$file";
        $ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));
        if (is_file($path) && in_array($ext, $allowed_extensions)) {
            $imgs[] = $path;
        }
    }
    return $imgs;
}

// Normalize separators to "/"
$normalized = str_replace("\\", "/", $folder);
// Count depth (number of parts)
$parts = explode("/", trim($normalized, "/"));
$depth = count($parts);

if ($depth == 4) {
    // Case 1: deeper folder → show parent + siblings
    $parent = dirname($folder);

    // 1. Images in parent
    $images = array_merge($images, collectImages($parent, $allowed_extensions));

    // 2. Images in siblings
    $subfolders = scandir($parent);
    foreach ($subfolders as $sub) {
        if ($sub === '.' || $sub === '..') continue;
        $subPath = "$parent/$sub";
        if (is_dir($subPath)) {
            $images = array_merge($images, collectImages($subPath, $allowed_extensions));
        }
    }
} else {
    // Case 2: shallow folder → only images in that folder
    // $images = collectImages($_GET['img'], $allowed_extensions);
    // $folder = '../main/propAsset_romano'; // Change to your folder name
    $folder = $_GET['img'];
    // $folder = dirname($folder);
    $allowed_extensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];

    $files = scandir($folder);
    $images = [];

    foreach ($files as $file) {
        $path = "$folder/$file";
        $ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));
        if (in_array($ext, $allowed_extensions) && is_file($path)) {
            $images[] = $path;
        }
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../codigo/estilo.css">
    <title>Image Gallery</title>
</head>
<body>
  <h2>Imagenes en 📂 "<?= htmlspecialchars($folder) ?>"</h2>
  <div>
    <?php foreach ($images as $img): ?>
      <ruby>
        <img src="<?= htmlspecialchars($img) ?>" title="<?php
            //-----------------metadata--------------------
            $size = getimagesize($img, $info);
            $iptc = isset($info["APP13"]) ? iptcparse($info["APP13"]) : false;
            $mensaje = isset($iptc["2#120"]) ? $iptc["2#120"][0] : '~~~';
            echo $mensaje;
        ?>"><rt><?= 
            // preg_match('/[^_]*_[^_]*$/',basename($img), $matches);
            // echo $matches[0];
            str_replace('_','|',str_replace(".jpg","",basename($img)));
            ?></rt>
      </ruby>
    <?php endforeach; ?>
  </div>
</body>
</html>
