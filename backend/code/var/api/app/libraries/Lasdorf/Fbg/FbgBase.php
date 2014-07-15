<?php namespace Lasdorf\Fbg;

Class FbgBase{
    public $sig;

    public function __construct(){
        $this->sig = md5(time());
    }
}
