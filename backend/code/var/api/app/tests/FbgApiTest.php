<?php

use Illuminate\Support\Facades\Config;
use Lasdorf\Fbg\FbgApi;

class FbgApiTest extends TestCase
{

    public function test_dir_sub_array()
    {
        $MIN_NUM_FOLDERS = 20;
        $MAX_NUM_FOLDERS = 100;
        $MIN_NUM_DUPES = 5;
        $MAX_NUM_DUPES = 10;

        $mainFolder = Config::get('fbg.api_test_settings.test_dir') . 'test_dir_sub_array_' . time() . '/';
        shell_exec('mkdir ' . $mainFolder);
        $numFolders = rand($MIN_NUM_FOLDERS, $MAX_NUM_FOLDERS);
        $numDupes = rand($MIN_NUM_DUPES, $MAX_NUM_DUPES);

        foreach(range(1, $numFolders) as $i)
        {
            shell_exec('mkdir ' . $mainFolder . $i);
        }

        foreach(range(1, $numDupes) as $i)
        {
            shell_exec('mkdir ' . $mainFolder . '.' . $i);
        }

        $api = new FbgApi();
        $arr = $api->dir_sub_array($mainFolder);
        $this->assertEquals($numFolders, count($arr));
        shell_exec('rm -r ' . $mainFolder);
    }

    public function test_import_export_completion()
    {
//        shell_exec('rm -rf ' . Config::get('fbg.import_export_settings.import_dir'));
//        shell_exec('python ' . Config::get('fbg.import_export_settings.import_dir') . '../generate.py');
    }

    public function countFolders($levels, $path)
    {

    }
}