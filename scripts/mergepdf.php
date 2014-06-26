//Requires GhostScript
$fileArray= scandir("./test");

$datadir = "./";
$outputName = $datadir."merged.pdf";

$cmd = "gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$outputName ";
//Add each pdf file to the end of the command
foreach($fileArray as $file) {
    $cmd .= "./test".$file." ";
}
$result = shell_exec($cmd);