<?php
include '../../../config.php';
$uploaddir = DIR_IMAGE.'data/'.$_POST['directory'].'/';
$filename = basename($_FILES['image']['name']);

//$filename = str_ireplace('\\', '/', $filename);

$file = $uploaddir.$filename;
$size=$_FILES['image']['size'];
if($size>1048576)
{
	echo "error file size > 1 MB";
	unlink($_FILES['image']['tmp_name']);
	exit;
}
if (move_uploaded_file($_FILES['image']['tmp_name'], $file)) { 
  echo "success"; 
} else {
	echo "error ".$_FILES['image']['error']." --- ".$_FILES['image']['tmp_name']." %%% ".$file."($size)";
}
?>