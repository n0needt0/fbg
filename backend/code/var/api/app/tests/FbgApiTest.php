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
        shell_exec(
            'cd ' . Config::get('fbg.api_test_settings.test_dir') . Config::get('fbg.api_test_settings.import_sub_dir') . '..;' .
            'rm -rf data;' .
            'python generate.py'
        );
        echo `ls /fbg/test/datagen`;

        $api = new FbgApi();
        $initDocList = $this->generate_user_doc_array(Config::get('fbg.api_test_settings.test_dir') . Config::get('fbg.api_test_settings.import_sub_dir'), $api);
        $api->put_docs_into_es(Config::get('fbg.api_test_settings.es_url'),
                               Config::get('fbg.api_test_settings.index_name'),
                               Config::get('fbg.api_test_settings.test_dir') . Config::get('fbg.api_test_settings.import_sub_dir'));
        $api->get_docs_from_es(Config::get('fbg.api_test_settings.es_url'),
                               Config::get('fbg.api_test_settings.index_name'),
                               Config::get('fbg.api_test_settings.test_dir') . Config::get('fbg.api_test_settings.export_sub_dir'),
                               Config::get('fbg.api_test_settings.search_blocks'));

        $recreatedDocList = $this->generate_user_doc_array(Config::get('fbg.api_test_settings.test_dir') . Config::get('fbg.api_test_settings.export_sub_dir'), $api);

        echo implode("\n", $initDocList);
        $this->assertTrue($initDocList == $recreatedDocList);
    }

    public function generate_user_doc_array($docPath, FbgApi $api)
    {
        $userList = $api->dir_sub_array($docPath);
        $docList = array();

        foreach($userList as $user)
        {
            $docList[$user] = count($api->dir_sub_array($docPath . $user));
        }

        return $docList;
    }
}