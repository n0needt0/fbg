<?php namespace Lasdorf\FbgApi;

use Illuminate\Support\Facades\Config as Config;  //to get configs
use Illuminate\Log; //to log screw ups
use Elasticsearch;

Class CronratApi extends CronratBase{

    public function __construct(){
         \Log::info($this->sig . " api call start:" . time());
    }

}