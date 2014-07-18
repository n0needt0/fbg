<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use \Lasdorf\Fbg\FbgApi;
use \Lasdorf\Fbg\FbgUtils;
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
    protected $description = 'Put data from a predefined location onto es';

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

            $api = new FbgApi();
            $succeeded = $api->put_docs_into_es(Config::get('fbg.import_export_settings.es_url'),
                                                Config::get('fbg.import_export_settings.index_name'),
                                                Config::get('fbg.import_export_settings.import_dir'));

            if($succeeded)
            {
                FbgUtils::notify($data, "Restore Completed!");
            }
        }
        catch(Exception $e)
        {
            //notify and log
            $this->error($e->getMessage());
            $data['error'] = $e->getMessage();
            FbgUtils::notify($data, "Restore Failed!");
        }
    }
}