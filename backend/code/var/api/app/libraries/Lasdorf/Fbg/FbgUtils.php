<?php namespace Lasdorf\Fbg;

use Lasdorf\Fbg\FbgBase;
use Illuminate\Support\Facades\Mail as Mail;  //to get configs
use Illuminate\Support\Facades\Config as Config;  //to get configs
use Illuminate\Log; //to log screw ups

Class FbgUtils extends FbgBase{

    private static $sendNotifications = true;
    private static $dataDir = '';

    public function __construct()
    {

    }

    public static function enableNotifications($flag)
    {
        self::$sendNotifications = $flag;
    }

    public static function setDataDir($fName)
    {
        self::$dataDir = $fName;
    }

    public static function getDataDir()
    {
        return self::$dataDir;
    }

    public static function notify($data, $status_msg="")
    {
        $data['random'] = self::get_random_text(); //add random text to fool junk mail filters
        if(empty($data['status_message']))
        {
            $data['status_message'] = $status_msg;
        }

        Mail::send('emails.fbg.notify', $data, function($message) use ($data)
        {
            $message->to($data['email'])->subject($data['status_message']);
        });
    }

    private static function get_random_text()
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