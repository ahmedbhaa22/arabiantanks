<?php

use Phalcon\Loader;

$loader = new Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerNamespaces([
    'Vokuro\Models'      => $config->application->modelsDir,
    'Models'      => $config->application->modelsDir,
    'Vokuro\Controllers' => $config->application->controllersDir,
    'Vokuro\Forms'       => $config->application->formsDir,
    'Vokuro' => $config->application->libraryDir,
    'Vokuro\Notifications\Models' => APP_PATH . '/modules/notifications/models',
    'Vokuro\Geo\Models' => APP_PATH . '/modules/geo/models',
    // 'Vokuro\Services' => $config->application->servicesDir,
    // 'Vokuro\ServicesInterfaces' => $config->application->servicesInterfacesDir,
    'Vokuro\UsersModule\Services' => APP_PATH . "/modules/users/services",
    'Vokuro\UsersModule\ServicesInterfaces' => APP_PATH . "/modules/users/servicesInterfaces",
    'Vokuro\UsersModule\Models' => APP_PATH . "/modules/users/models",
    'Vokuro\Cart\Models' => APP_PATH . "/modules/cart/models",
    'Vokuro\Offers\Models' => APP_PATH . "/modules/offers/models",
    'Vokuro\Discounts\Models' => APP_PATH . "/modules/discounts/models",
    'Vokuro\Maintenance\Services' => APP_PATH . "/modules/maintenance/services",
    'Vokuro\Maintenance\Models' => APP_PATH . "/modules/maintenance/models",
]);
$loader->register();

$loader->registerDirs([
    'Vokuro\Models'      => $config->application->modelsDir,
    "../app/cmshelpers",
    $config->application->pluginsDir,
]);


$loader->register();

// Use composer autoloader to load vendor classes
require_once BASE_PATH . '/vendor/autoload.php';
