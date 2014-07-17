<?php namespace Lasdorf\Fbg;

use Lasdorf\Fbg\FbgBase;
use Illuminate\Support\Facades\Config as Config;  //to get configs
use Illuminate\Log; //to log screw ups
use \Elasticsearch\Client;

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

    public function create_client($es_url)
    {
        $clientParams = array();
        $clientParams['hosts'] = array($es_url);
        return new Client($clientParams);
    }

    public function flush_index($client, $index_name)
    {
        $indexParams = array();
        $indexParams['index'] = $index_name;
        $client->indices()->delete($indexParams);
        $client->indices()->create($indexParams);
    }

    public function dir_sub_array($dir_name)
    {
        return array_diff(scandir($dir_name), array('..', '.', '.DS_Store', '.idea'));
    }

    public function put_docs_into_es($es_url, $index_name, $import_dir)
    {
        try
        {
            $client = $this->create_client($es_url);
            $this->flush_index($client, $index_name);

            $userDirs = $this->dir_sub_array($import_dir);
            foreach($userDirs as $userDir)
            {
                $userDir = $import_dir . $userDir . '/';
                $docDirs = $this->dir_sub_array($userDir);
                foreach($docDirs as $docDir)
                {
                    $docDir = $userDir . $docDir . '/';
                    $facets = json_decode(file_get_contents($docDir . 'facets.json'), true);
                    $facets['text'] = file_get_contents($docDir . 'text.txt');

                    $docParams = array();
                    $docParams['body'] = $facets;

                    $id = '';
                    if(array_key_exists('doc_uri', $docParams['body']))
                    {
                        $id = $docParams['body']['doc_uri'];
                        $id = substr($id, 0, strlen($id) - 4);
                    }
                    else
                    {
                        $id = md5(json_encode($docParams['body']) . time());
                    }
                    $docParams['body']['doc_uri'] = $id . '.pdf';
                    $docParams['index'] = $index_name;
                    $docParams['type'] = $docParams['body']['doc_type'];
                    $docParams['id'] = $id;
                    $client->index($docParams);
                }
            }

            return true;
        }
        catch(Exception $e)
        {
            return false;
        }
    }

    public function get_docs_from_es($es_url, $index_name, $export_dir, $search_blocks)
    {
        try
        {
            $client = $this->create_client($es_url);
            $dir_name = $export_dir . time() . '/';

            $from = 0;
            $numDocs = -1;
            do
            {
                $searchParams = array();
                $searchParams['index'] = $index_name;
                $searchParams['size'] = $search_blocks;
                $searchParams['from'] = $from;

                $results = $client->search($searchParams)['hits'];
                if($numDocs == -1)
                {
                    $numDocs = $results['total'];
                }

                $documents = $results['hits'];
                foreach($documents as $document)
                {
                    $data = $document['_source'];
                    $folder = $data['doc_folder'];
                    $sub_folder = $data['doc_uri'];
                    $sub_folder = substr($sub_folder, 0, strlen($sub_folder) - 4);

                    $doc_folder = $dir_name . $folder . '/' . $sub_folder . '/';
                    if(!file_exists($doc_folder))
                    {
                        mkdir($doc_folder, 0777, true);
                        file_put_contents($doc_folder . 'facets.json', json_encode($data));
                        file_put_contents($doc_folder . 'text.txt', $data['text']);
                    }
                }
                $from += $search_blocks;
            } while ($from < $numDocs);

            return true;
        }
        catch(Exception $e)
        {
            return false;
        }
    }
}