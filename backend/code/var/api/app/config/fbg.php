<?php
return array(
    'eshosts'=>array('localhost:9200'), // one or several
    'pdfs'=>'/gfs', //thats where actual fles leave
    'admin'=>array('email'=>'andrewy@lasdorf.com'),

    'import_export_settings' => array(
        'es_url' => 'http://search.helppain.net:9200/',
        'import_dir' => '/fbg/gfs/data/',
        'export_dir' => '/fbg/export/',
        'index_name' => 'tests',
        'search_blocks' => 5
    ),

    //this is where the file room is defined

    'fileroom' => array(
        'folder' => array(
            'example' => 'SHMOE_JOE_1234',
            'autogenerated' => false,
            'required' => true,
            'description'=> 'Last, First 4 last digits of SSN'
        ),
        'doc_uri' => array(
            'example' => 'https://fbg.com/data/SHMOE_JOE_12ad34/398196',
            'autogenerated' => true,
            'required' => true
        ),
        'doc_type' => array(
            'example' => 'letter',
            'autogenerated' => false,
            'required' => false
        ),
        'doc_group' => array(
            'example' => 'Psychological Therapy Folder',
            'autogenerated' => false,
            'required' => false
        ),
        'doc_date' => array(
            'example' => '10/16/12',
            'autogenerated' => false,
            'required' => false
        ),
        'cc' => array(
            'example' => array("Joe Bro", "Sam Low"),
            'autogenerated' => false,
            'required' => false
        ),
        'doc_location' => array(
            'example' => 'San Mateo',
            'autogenerated' => false,
            'required' => false
        ),
        'text' => array(
            'example' => 'this is some example OCR which doesn\'t mean anything',
            'autogenerated' => true,
            'required' => false
        )
    )
);

