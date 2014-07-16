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