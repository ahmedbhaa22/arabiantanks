<?php

require_once BASE_PATH . '/vendor/autoload.php';

use Phalcon\Mvc\View;
use Phalcon\Crypt;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Files as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Flash\Direct as Flash;
use Phalcon\Logger\Adapter\File as FileLogger;
use Phalcon\Logger\Formatter\Line as FormatterLine;
use Vokuro\Auth\Auth;
use Vokuro\Acl\Acl;
use Vokuro\Mail\Mail;
use Vokuro\Menus;
use Phalcon\Mvc\Model\Manager as ModelsManager;
use Phalcon\Flash\Session as FlashSession;
use Vokuro\Pentavalue\CmsSearch;
use Phalcon\Events\Manager as EventsManager;

use Phalcon\DI\FactoryDefault;
use Vokuro\SharedFunctions;


/**
 * Register the global configuration as config
 */
$di->setShared('config', function () {
    $config = include APP_PATH . '/config/config.php';
    
    if (is_readable(APP_PATH . '/config/config.dev.php')) {
        $override = include APP_PATH . '/config/config.dev.php';
        $config->merge($override);
    }
    
    return $config;
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);
    return $url;
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url_shared', function () {
    $config = $this->getConfig();

    $url_shared = new UrlResolver();
    $url_shared->setBaseUri($config->application->baseUri);
    return $url_shared;
});

/**
 * Setting up the view component
 */
$di->set('view', function () {
    $config = $this->getConfig();

    $view = new View();

    $view->setViewsDir($config->application->viewsDir);

    $view->registerEngines([
        '.volt' => function ($view) {
            $config = $this->getConfig();

            $volt = new VoltEngine($view, $this);

            $volt->setOptions([
                'compiledPath' => $config->application->cacheDir . 'volt/',
                'compiledSeparator' => '_'
            ]);

            $volt->getCompiler()->addFunction(
                'strtotime',
                function($date)
                {
                    return strtotime($date);
                }
            );
            $volt->getCompiler()->addFunction("substr", "substr");
            $volt->getCompiler()->addFunction(
                'url_shared',
                function($url_shared)
                {
                    return $this->url_shared->get($url_shared);
                }
            );



            return $volt;
        }
    ]);

    return $view;
}, true);

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->set('db', function () {
    $config = $this->getConfig();
    return new DbAdapter([
        'host' => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname' => $config->database->dbname
    ]);
});

/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
// $di->set('modelsMetadata', function () {
//     $config = $this->getConfig();
//     return new MetaDataAdapter([
//         'metaDataDir' => $config->application->cacheDir . 'metaData/'
//     ]);
// });

/**
 * Start the session the first time some component request the session service
 */
$di->set('session', function () {
    $session = new SessionAdapter();
    $session->start();
    return $session;
});

/**
 * Crypt service
 */
$di->set('crypt', function () {
    $config = $this->getConfig();

    $crypt = new Crypt();
    $crypt->setKey($config->application->cryptSalt);
    return $crypt;
});

/**
 * Dispatcher use a default namespace
 */
$di->set('dispatcher', function () {
//    // Create an EventsManager
//    $eventsManager = new EventsManager();
//
//    // Attach a listener
//    $eventsManager->attach(
//        "dispatch:beforeException",
//        function (Event $event, $dispatcher, Exception $exception) {
//            // Handle 404 exceptions
//            if ($exception instanceof DispatchException) {
//                $dispatcher->forward(
//                    [
//                        'controller' => 'index',
//                        'action'     => 'show404',
//                    ]
//                );
//
//                return false;
//            }
//        });
    $eventsManager = new EventsManager();
    $eventsManager->attach('dispatch:beforeException', new NotFoundPlugin);
    $dispatcher = new Dispatcher;
    //$dispatcher->setEventsManager($eventsManager);
    //$dispatcher->setEventsManager($eventsManager);
    $dispatcher->setDefaultNamespace('Vokuro\Controllers');
    return $dispatcher;
});

/**
 * Loading routes from the routes.php file
 */
$di->set('router', function () {
    return require APP_PATH . '/config/routes.php';
});

/**
 * Flash service with custom CSS classes
 */
$di->set('flashSession', function () {
    return new FlashSession([
        'error' => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice' => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ]);
});

/**
 * Custom authentication component
 */
$di->set('auth', function () {
    return new Auth();
});

/**
 * Mail service uses AmazonSES
 */
$di->set('mail', function () {
    return new Mail();
});

/**
 * Setup the private resources, if any, for performance optimization of the ACL.  
 */
$di->setShared('AclResources', function() {
    $pr = [];
    if (is_readable(APP_PATH . '/config/privateResources.php')) {
        $pr = include APP_PATH . '/config/privateResources.php';
    }
    return $pr;
});

/**
 * Access Control List
 * Reads privateResource as an array from the config object.
 */
$di->set('acl', function () {
    $acl = new Acl();
    $pr = $this->getShared('AclResources')->privateResources->toArray();
    $acl->addPrivateResources($pr);
    return $acl;
});

/**
 * Logger service
 */
$di->set('logger', function ($filename = null, $format = null) {
    $config = $this->getConfig();

    $format   = $format ?: $config->get('logger')->format;
    $filename = trim($filename ?: $config->get('logger')->filename, '\\/');
    $path     = rtrim($config->get('logger')->path, '\\/') . DIRECTORY_SEPARATOR;

    $formatter = new FormatterLine($format, $config->get('logger')->date);
    $logger    = new FileLogger($path . $filename);

    $logger->setFormatter($formatter);
    $logger->setLogLevel($config->get('logger')->logLevel);

    return $logger;
});

// Register a user component
$di->set(
    "menus",
    function () {
        return new Menus();
    }
);

$di->setShared('db', function() {
    Phalcon\Mvc\Model::setup(['exceptionOnFailedSave' => false]);
    $config = $this->getConfig();
    return new DbAdapter([
        'host' => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname' => $config->database->dbname,
        "options" => array(
            PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'
        )
    ]);


});


$di->setShared('apiFactory', function() {
    return new \Vokuro\ApiFactory($this->getConfig()->application->baseUri);
});


//
//pentavalue CmsHelpers
$di->set(
    "CmsHelpers",
    function () {
        return new CmsHelpers();
    }
);

/**
 * Data CMS Search
 */
$di->set('CmsSearch', function () {
    return new CmsSearch();
});
///
$di->set('ApiFactory', function () {
    return new \Vokuro\ApiFactory();
});

$di->setShared('apiFactory', function()
{
    $api_factory = new \Vokuro\ApiFactory($this->getConfig()->application->baseUri);
    return $api_factory;
});

$di->setShared('emailService', function()
{
    return \Vokuro\UsersModule\Services\EmailService::_instantiate();
});

$di->setShared('responseService',function()
{
    return \Vokuro\UsersModule\Services\ResponseService::_instantiate();
});

$di->setShared('validationService', function()
{
    return \Vokuro\UsersModule\Services\ValidationService::_instantiate();
});

$di->setShared('base64stringToImageService', function()
{
    return \Vokuro\UsersModule\Services\Base64ToImageService::_instantiate();
});

$di->setShared('userSettingsService', function()
{
    return Vokuro\UsersModule\Services\UserSettingsService::_instantiate();
});

$di->setShared('redirectService', function()
{
    return \Vokuro\UsersModule\Services\RedirectService::_instantiate();
});

$di->setShared('jwtService', function()
{
    return \Vokuro\UsersModule\Services\JwtService::_instantiate();
});

$di->setShared('facebookService', function()
{
    $fb_service = new \Vokuro\UsersModule\Services\GuzzleService('https://graph.facebook.com/');
    return $fb_service;
});

$di->setShared('instagramService', function()
{
    $insta_service = new \Vokuro\UsersModule\Services\GuzzleService('https://api.instagram.com/v1/');
    return $insta_service;
});

$di->setShared('OffersService', function()
{
    $api_factory = new \Vokuro\Offers\Services\OffersService();
    return $api_factory;
});

$di->setShared('DiscountsService', function()
{
    $api_factory = new \Vokuro\Discounts\Services\DiscountsService();
    return $api_factory;
});
$di->set('SharedFunctions', function () {
    return new SharedFunctions();
});

$di->set('MaintenancePermissions', function () {
    return new \Vokuro\Permissions\MaintenancePermissions();
});

$di->set('SalesVisitsPermissions', function () {
    return new \Vokuro\Permissions\SalesVisitsPermissions();
});

$di->setShared('TanksBranches', function()
{
    return new \Vokuro\Services\TanksBranchesService();
});
