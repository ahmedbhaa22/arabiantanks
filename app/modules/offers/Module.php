<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 9:50 AM
 */

namespace Vokuro\Offers;

use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\DiInterface;
use Vokuro\ApiFactory;

class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();

        $loader->registerNamespaces([
            'Vokuro\\Offers\\Controllers' => '../app/modules/offers/controllers/',
            'Vokuro\\Offers\\Models'      => '../app/modules/offers/models/',
            "Vokuro\\Offers\\Services"    => "../app/modules/offers/services/",
        ]);

        $loader->register();
    }

    public function registerServices(DiInterface $di)
    {
        $di->set('dispatcher', function()
        {
            $dispatcher = new Dispatcher();

            $dispatcher->setDefaultNamespace('Vokuro\\Offers\\Controllers');

            return $dispatcher;
        });

        $di->set('view', function()
        {
            $view = new View();

            $view->setViewsDir(__DIR__ . '/views/');
            //$view->setLayoutsDir(__DIR__ . '/views/layouts/');
            $view->setLayoutsDir('../../../views/layouts/');

            $view->registerEngines([
                '.volt' => function($view, $dispatcher)
                {
                    $config = $this->getConfig();

                    $volt = new VoltEngine($view, $dispatcher);

                    $volt->setOptions([
                        'compiledPath'      => $config->application->cacheDir . 'volt/',
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
    }
}