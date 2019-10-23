<?php

use Carbon\Carbon;
use Phalcon\Cli\Console as ConsoleApp;
use Phalcon\DI\FactoryDefault;
use Phalcon\Di\FactoryDefault\Cli as CliDI;
use Phalcon\Loader;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Vokuro\Mail\Mail;
use Vokuro\Models\Projects;


// Using the CLI factory default services container
$di = new CliDI();

define('BASE_PATH', dirname(dirname(dirname(__DIR__))));
define('APP_PATH', BASE_PATH . '/app');
defined('APPLICATION_PATH') || define('APPLICATION_PATH', realpath(dirname(__FILE__)));
// include APP_PATH . "/config/services.php";

// include APP_PATH . '/config/loader.php';

// var_dump(BASE_PATH);
// var_dump(APP_PATH);
// var_dump(APPLICATION_PATH);
// var_dump(__DIR__);
// die();
/**
 * Register the autoloader and tell it to register the tasks directory
 */
$loader = new Loader();

$loader->registerNamespaces([
    'Vokuro\Notifications\Models'      => APPLICATION_PATH . "/models/",
    'Vokuro\Notifications\Services'      => APPLICATION_PATH . "/services/",
    'Models'      => BASE_PATH . "/app/models/",
    'Vokuro\Models'      => BASE_PATH . "/app/models/",
    'Vokuro'             => BASE_PATH . "/app/library/"
]);

$loader->registerDirs(
    [
        __DIR__ . "/tasks",
        'Vokuro\Notifications\Models'      => APPLICATION_PATH . "/models/",
        'Vokuro\Notifications\Services'      => APPLICATION_PATH . "/services/",
        BASE_PATH . "/app/models/"
    ]
);

$loader->register();

require_once BASE_PATH . '/vendor/autoload.php';

// Load the configuration file (if any)

$configFile = __DIR__ . "/config/config.php";

if (is_readable($configFile)) {
    $config = include $configFile;

    $di->set("config", $config);
}



// Create a console application
$console = new ConsoleApp();

$console->setDI($di);

$di->setShared('config', function () {
    $config = include APP_PATH . '/config/config.php';
    
    if (is_readable(APP_PATH . '/config/config.dev.php')) {
        $override = include APP_PATH . '/config/config.dev.php';
        $config->merge($override);
    }
    
    return $config;
});

$di->setShared('db', function() {
    Phalcon\Mvc\Model::setup(['exceptionOnFailedSave' => false]);
    $config = $this->getConfig();

    $db = new Phalcon\Db\Adapter\Pdo\Mysql(array(
        'host'     => 'localhost',
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname'   => $config->database->dbname,
        "options" => array(
            PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'
        )
    ));
    return $db;
});
$di->set(
    "view",
    function () {
        $view = new View();

        $view->setViewsDir(BASE_PATH . "/app/modules/notifications/views/");

        $view->registerEngines([
            '.volt' => function ($view) {

                $volt = new VoltEngine($view, $this);


                return $volt;
            }
        ]);

        return $view;
    }
);

$di->set('mail', function () {
    return new Mail();
});

/**
 * Process the console arguments
 */
$arguments = [];

foreach ($argv as $k => $arg) {
    if ($k === 1) {
        $arguments["task"] = $arg;
    } elseif ($k === 2) {
        $arguments["action"] = $arg;
    } elseif ($k >= 3) {
        $arguments["params"][] = $arg;
    }
}

try {
    // Handle incoming arguments
    $console->handle($arguments);
} catch (\Phalcon\Exception $e) {
    echo $e->getMessage();

    exit(255);
}