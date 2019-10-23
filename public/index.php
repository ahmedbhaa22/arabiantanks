<?php

use Phalcon\DI\FactoryDefault;
use Phalcon\Mvc\Application;

use Phalcon\Mvc\User\Plugin;

error_reporting(E_ALL);
(new Phalcon\Debug)->listen();

/**
 * Define some useful constants
 */
define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/app');

// including constants files
foreach(glob(APP_PATH.'/modules/users/constants/*.php') as $file)
{
    include_once $file;
}

foreach(glob(APP_PATH.'/modules/users/helpers/*.php') as $helper)
{
    include_once $helper;
}



    /**
     * The FactoryDefault Dependency Injector automatically register the right services providing a full stack framework
     */
    $di = new FactoryDefault();


    /**
     * Read services
     */
    include APP_PATH . "/config/services.php";

    /**
     * Get config service for use in inline setup below
     */
    $config = $di->getConfig();

    /**
     * Include Autoloader
     */
    include APP_PATH . '/config/loader.php';

    /**
    * Handle the request
    */
    $application = new Application($di);

    // Register the installed modules
    $application->registerModules(
        [
            "cms" => [
                "className" => "Vokuro\\Cms\\Module",
                "path"      => "../app/modules/cms/Module.php",
            ],
            "control" => [
                "className" => "Vokuro\\Control\\Module",
                "path"      => "../app/modules/control/Module.php",
            ],
            "geo" => [
                "className" => "Vokuro\\Geo\\Module",
                "path"      => "../app/modules/geo/Module.php",
            ],
            "offers" => [
                "className" => "Vokuro\\Offers\\Module",
                "path"      => APP_PATH . '/modules/offers/Module.php'
            ],
            "discounts" => [
                "className" => "Vokuro\\Discounts\\Module",
                "path"      => APP_PATH . '/modules/discounts/Module.php'
            ],
            'cart' => [
                'className' => "Vokuro\\Cart\\Module",
                'path'      => APP_PATH . '/modules/cart/Module.php'
            ],
            'users' => [
                'className' => "Vokuro\\UsersModule\\Module",
                'path'      => APP_PATH . '/modules/users/Module.php'
            ],
            "polls" => [
                "className" => "Vokuro\\Polls\\Module",
                "path"      => "../app/modules/polls/Module.php",
            ],
            "messages" => [
                "className" => "Vokuro\\Messages\\Module",
                "path"      => "../app/modules/messages/Module.php",
            ],
            "ads" => [
                "className" => "Vokuro\\Ads\\Module",
                "path"      => "../app/modules/ads/Module.php",
            ],
            "notifications" => [
                "className" => "Vokuro\\Notifications\\Module",
                "path"      => "../app/modules/notifications/Module.php",
            ],
            "maintenance" => [
                "className" => "Vokuro\\Maintenance\\Module",
                "path"      => "../app/modules/maintenance/Module.php",
            ],
            "sales_visits" => [
                "className" => "Vokuro\\SalesVisits\\Module",
                "path"      => "../app/modules/sales_visits/Module.php",
            ],
        ]
    );
echo $application->handle()
    ->getContent();
//try
//{
//
//
//}
//catch(\Exception $e)
//{
//    die($e->getMessage());
//}

