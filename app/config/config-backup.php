<?php

use Phalcon\Config;
use Phalcon\Logger;
defined('BASE_PATH') || define('BASE_PATH', getenv('BASE_PATH') ?: realpath(dirname(__FILE__) . '/../..'));
defined('APP_PATH') || define('APP_PATH', BASE_PATH . '/app');
return new Config([
'twilio' => [
        'app_id' => 'ACfdf096a79f3d9df8f3664346e81ebb13',
        'token'  => '73e9653f8f11584c78c0c59986eb17ba',
        'from'   => '+18304944371'
    ],
    'database' => [
        'adapter' => 'Mysql',
        'host' => 'localhost',
        'username' => 'alarabia_islam87',
        'password' => 'yT9A.t4#)SO}',
        'dbname' => 'alarabia_tanks'
    ],
    'application' => [
        'controllersDir' => APP_PATH . '/controllers/',
        'modelsDir'      => APP_PATH . '/models/',
        'formsDir'       => APP_PATH . '/forms/',
        'viewsDir'       => APP_PATH . '/views/',
        'libraryDir'     => APP_PATH . '/library/',
        'pluginsDir'     => APP_PATH . '/plugins/',
        'cacheDir'       => BASE_PATH . '/cache/',
        'baseUri'        => 'http://penta-test.com/tanks_project/',
        'publicUrl'      => 'http://penta-test.com/tanks_project/',
        'cryptSalt'      => 'eEAfR|_&G&f,+vU]:jFr!!A&+71w1Ms9~8_4L!<@[N@DyaIP_2My|:+.u>/6m,$D',
	'roboUrl'     => 'http://penta-test.com/matgar_mainaa/uploads/'
    ],
    'mail' => [
        'fromName' => 'Arabian Tanks',
        'fromEmail' => 'info@arabia-tanks.com',
        'smtp' => [
            'server' => 'server2.robo-apps.com',
            'port' => 465,
            'security' => 'SSL',
            'username' => 'info@penta-test.com',
            'password' => 'B%~QDx5k7RCW',
	    'streamOptions' => ['ssl'=>['allow_self_signed'=>true, 'verify_peer'=>false]]
        ]
    ],
    'amazon' => [
        'AWSAccessKeyId' => '',
        'AWSSecretKey' => ''
    ],
    'logger' => [
        'path'     => BASE_PATH . '/logs/',
        'format'   => '%date% [%type%] %message%',
        'date'     => 'D j H:i:s',
        'logLevel' => Logger::DEBUG,
        'filename' => 'application.log',
    ],
    'Penta_Settings' => [
    	'Module_ID' => '12380',
        'Application_ID' => '535',
        'Content_View' => 'Grid',
        'Lang' => 'en',
        'Lang_ID' => '1'
    ],
    // Set to false to disable sending emails (for use in test environment)
    'useMail' => true
]);
