<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use \Lasdorf\FbgApi\FbgApi as Fbg;

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

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
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

        $data =array();

        try{
                //DO STUFF HERE
                $this->notify($data, "Backup Completed!");
        }
        catch(Exception $e)
        {
            //notify and log
            $this->error($e->getMessage());
            $data['error'] = $e->getMessage();
            $this->notify($data, "Backup Failed!");
        }
    }

    private function notify($data, $status_msg)
    {
        $data['random'] = $this->get_random_text(); //add random text to fool junk mail filters

        Mail::send('emails.fbg.notify', $data, function($message) use ($data)
        {
            $message->to($data['email'])->subject($status_msg);
        });
    }

    function get_random_text()
    {
        $file = __DIR__ . '/misc/random.txt';
        $returnlines = 20;
        $i=0;
        $buffer="\n";
        $rand = rand(1, filesize($file));

        $handle = @fopen($file, "r");
        fseek($handle, $rand);

        if ($handle)
        {
            while (!feof($handle) && $i<=$returnlines)
            {
                $buffer .= fgets($handle, 4096);
                $i++;
            }

            fclose($handle);
        }

        return "\n</br>\n</br>\n</br>*************RANDOM TEXT TO ESCAPE SPAM FILTER****************************\n</br>\n</br>\n</br>" . $buffer;
    }

}