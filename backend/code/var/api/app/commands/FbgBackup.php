<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use \Lasdorf\Fbg\FbgApi;
use \Lasdorf\Fbg\FbgUtils;
use \Elasticsearch\Client;

class FbgBackup extends Command {

    /**
     * The console command name.
     *
     * @var string
     */
    protected $name = 'command:fbgbackup';


    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This Command Backs up FBG installation to configured location in YYMMDD.ZIP file';

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

        $data = array('email'=>Config::get('fbg.admin.email'));

        try
        {
            //TODO: Need to somehow get from GFS

            //Disable Andrew's email
            FBGUtils::enableNotifications(false);

            //Initializes test client
            $clientParams = array();
            $clientParams['hosts'] = array(
                Config::get('fbg.import_export_settings.es_url')
            );
            $client = new Client($clientParams);

            $from = 0;
            $numDocs = -1;
            do
            {
                $searchParams = array();
                $searchParams['index'] = Config::get('fbg.import_export_settings.index_name');
                $searchParams['size'] = Config::get('fbg.import_export_settings.search_blocks');
                $searchParams['from'] = $from;

                $results = $client->search($searchParams)['hits'];
                if($numDocs == -1)
                {
                    $numDocs = $results['total'];
                }

                $documents = $results['hits'];
                foreach($documents as $document)
                {

                }
            } while ($from < $numDocs);

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