<?php

use Phalcon\Cli\Console as ConsoleApp;
use Phalcon\DI\FactoryDefault;
use Phalcon\Di\FactoryDefault\Cli as CliDI;
use Phalcon\Loader;
use Vokuro\Models\Projects;
use Carbon\Carbon;


// Using the CLI factory default services container
$di = new CliDI();

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/app');
defined('APPLICATION_PATH') || define('APPLICATION_PATH', realpath(dirname(__FILE__)));
// include APP_PATH . "/config/services.php";

// include APP_PATH . '/config/loader.php';



/**
 * Register the autoloader and tell it to register the tasks directory
 */
$loader = new Loader();

$loader->registerNamespaces([
    'Vokuro\Models'      => APPLICATION_PATH . "/models/",
    'Models'      => APPLICATION_PATH . "/models/",
    'Vokuro'             => APPLICATION_PATH . "/library/",
    "Vokuro\\Offers\\Models" => APPLICATION_PATH ."/modules/offers/models/",
]);

$loader->registerDirs(
    [
        __DIR__ . "/tasks",
        'Vokuro\Models'      => APPLICATION_PATH . "/models/",
        APPLICATION_PATH . "/models/"
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

$di->setShared('db', function() {
    Phalcon\Mvc\Model::setup(['exceptionOnFailedSave' => false]);
    $config = $this->getConfig();
    $db = new Phalcon\Db\Adapter\Pdo\Mysql(array(
        'host' => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname' => $config->database->dbname,
        "options" => array(
            PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'
        )
    ));
    return $db;
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