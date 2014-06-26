<?php>
//Requires GhostScript	
$fileArray= scandir("./test");
print_r($fileArray);
$datadir = "./";
$outputName = $datadir."merged.pdf";

$cmd = "gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$outputName ";
//Add each pdf file to the end of the command
foreach($fileArray as $file) if($file != "." && $file != "..") {
    $cmd .= "./test/".$file." ";
}
print $cmd;
$result = shell_exec($cmd);