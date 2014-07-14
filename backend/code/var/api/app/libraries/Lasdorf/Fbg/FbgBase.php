<?php namespace Lasdorf\FbgApi;

Class FbgBase{
    public $sig;

    public function __construct(){
        $this->sig = md5(time());
    }
}
