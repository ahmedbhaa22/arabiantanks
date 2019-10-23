<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 9:50 AM
 */

namespace Vokuro\Cart;

use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\DiInterface;
use Vokuro\ApiFactory;
use Vokuro\UsersModule\Services\Base64ToImageService;
use Vokuro\UsersModule\Services\ValidationService;

class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();

        $loader->registerNamespaces([
            'Vokuro\\Cart\\Controllers' => '../app/modules/cart/controllers/',
            'Vokuro\\Cart\\Models'      => '../app/modules/cart/models/',
            'Vokuro\\Offers\\Models'     => '../app/modules/offers/models/',
            'Vokuro\\UsersModule\\Services' => '../app/modules/users/services',
            'Vokuro\\UsersModule\\ServicesInterfaces' => '../app/modules/users/servicesInterfaces',
            'Vokuro\\Discounts\\Models'  => '../app/modules/discounts/models/'
        ]);

        $loader->register();
    }

    public function registerServices(DiInterface $di)
    {
        $di->set('dispatcher', function()
        {
            $dispatcher = new Dispatcher();

            $dispatcher->setDefaultNamespace('Vokuro\\Cart\\Controllers');

            return $dispatcher;
        });

        $di->set('view', function()
        {
            $view = new View();

            $view->setViewsDir(__DIR__ . '/views/');
            $view->setLayoutsDir(__DIR__ . '/views/layouts/');

            $view->registerEngines([
                '.volt' => function($view, $dispatcher)
                {
                    $config = $this->getConfig();

                    $volt = new VoltEngine($view, $dispatcher);

                    $volt->setOptions([
                        'compiledPath'      => $config->application->cacheDir . '.volt',
                        'compiledSeparator' => '_'
                    ]);

                    return $volt;
                }
            ]);

            return $view;
        });

        $di->set('apiFactory', function()
        {
            return new ApiFactory($this->getConfig()->application->baseUri);
        });

        $di->set('validationService', function()
        {
            return ValidationService::_instantiate();
        });

        $di->set('base64ToImg', function()
        {

            $base64ToImg = Base64ToImageService::_instantiate();
            $base64ToImg->setBasePath($this->getConfig()->application->baseUri);
            $base64ToImg->setUploadPath('uploads/tanks/payment_receipts');
           return $base64ToImg;
        });
    }
}