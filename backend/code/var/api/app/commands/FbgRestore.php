<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use \Lasdorf\Fbg\FbgApi;
use \Lasdorf\Fbg\FbgUtils;
use \Elasticsearch\Client;
use Illuminate\Support\Facades\Config;

class FbgRestore extends Command {

    /**
     * The console command name.
     *
     * @var string
     */
    protected $name = 'command:fbgrestore';


    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This Command Backs up FBG installation to configured location in YYMMDD.ZIP file';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
        $this->fbg = new FbgApi();
    }

    private function debug($msg)
    {
        if(Config::get('app.debug'))
        {
            $this->info("DEBUG: $msg" );
        }
    }

    /**
     * Execute the console command.
     *
     * @return void
     */
    public function fire()
    {
        $env = $this->option('env');

        if(empty($env))
        {
            $this->error('--env option required! local|production');
            die;
        }

        $data =array('email'=>Config::get('fbg.admin.email'));

        try
        {
            //Disable Andrew's email
            FBGUtils::enableNotifications(false);

            //Initializes test client
            $testParams = array();
            $testParams['hosts'] = array(
                Config::get('fbg.import_export_settings.es_url')
            );
            $client = new Client($testParams);

            //Creates blank test index
            $indexParams = array();
            $indexParams['index'] = Config::get('fbg.import_export_settings.index_name');
            $client->indices()->delete($indexParams);
            $client->indices()->create($indexParams);

            $mainDir = Config::get('fbg.import_export_settings.import_dir');
            $this->info($mainDir);
            $userDirs = array_diff(scandir($mainDir), array('..', '.', '.DS_Store', '.idea'));
            foreach($userDirs as $userDir)
            {
                $userDir = $mainDir . $userDir . '/';
                $this->info("\t" . $userDir);
                $docDirs = array_diff(scandir($userDir), array('..', '.', '.DS_Store', '.idea'));
                foreach($docDirs as $docDir)
                {

                    $docDir = $userDir . $docDir . '/';
                    $this->info("\t\t" . $docDir);
                    $facets = json_decode(file_get_contents($docDir . 'facets.json'), true);
                    $facets['text'] = file_get_contents($docDir . 'text.txt');

                    $docParams = array();
                    $docParams['body'] = $facets;
                    $id = md5(json_encode($docParams['body']) . time());

                    $docParams['body']['doc_uri'] = $id . '.pdf';
                    $docParams['index'] = 'tests';
                    $docParams['type'] = 'test';
                    $docParams['id'] = $id;
                    $client->index($docParams);
                }
            }

            FbgUtils::notify($data, "Backup Completed!");
        }
        catch(Exception $e)
        {
            //notify and log
            $this->error($e->getMessage());
            $data['error'] = $e->getMessage();
            FbgUtils::notify($data, "Backup Failed!");
        }
    }
}