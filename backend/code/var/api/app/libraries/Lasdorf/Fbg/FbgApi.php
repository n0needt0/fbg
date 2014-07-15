<?php namespace Lasdorf\Fbg;

use Lasdorf\Fbg\FbgBase;
use Illuminate\Support\Facades\Config as Config;  //to get configs
use Illuminate\Log; //to log screw ups

Class FbgApi extends FbgBase{

    public function __construct(){
         \Log::info($this->sig . " api call start:" . time());
         $this->elastic = new \Elasticsearch\Client(array('hosts'=> Config::get('fbg.eshosts')));
    }

    public function me()
    {
        echo "working fbg api";
        die;
    }

    public function get_all_docs_in_index($index)
    {

    }

}