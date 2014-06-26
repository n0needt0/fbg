<?php

return array(
'driver' => 'smtp',
'host' => 'smtp.gmail.com',
'port' => 587,
'from' => array('address' => 'ops@fbg.com', 'name' => 'Ops Fbgt'),
'encryption' => 'tls',
'username' => 'ops@fbg.com',
'password' => 'password',
'sendmail' => '/usr/sbin/sendmail -bs',
'pretend' => false,
);