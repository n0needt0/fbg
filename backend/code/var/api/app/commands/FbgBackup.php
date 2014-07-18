<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use \Lasdorf\Fbg\FbgApi;
use \Lasdorf\Fbg\FbgUtils;
use Illuminate\Support\Facades\Config;

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
    protected $description = 'Get data from es and put it into a predefined location';

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

            $api = new FbgApi();
            $succeeded = $api->get_docs_from_es(Config::get('fbg.import_export_settings.es_url'),
                                                Config::get('fbg.import_export_settings.index_name'),
                                                Config::get('fbg.import_export_settings.export_dir'),
                                                Config::get('fbg.import_export_settings.search_blocks'));

            if($succeeded)
            {
                FbgUtils::notify($data, "Backup Completed!");
            }
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