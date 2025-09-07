<?php
// $folder = '../main/propAsset_romano'; // Change to your folder name
$folder = $_GET['img'];
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
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../codigo/estilo.css">
    <title>Image Gallery</title>
</head>
<body>
  <h2>Images in "<?= htmlspecialchars($folder) ?>"</h2>
  <div>
    <?php foreach ($images as $img): ?>
      <img src="<?= htmlspecialchars($img) ?>" alt="">
    <?php endforeach; ?>
  </div>
</body>
</html>