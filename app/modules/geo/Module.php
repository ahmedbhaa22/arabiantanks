<?php

namespace Vokuro\Geo;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;

class Module implements ModuleDefinitionInterface
{
    /**
     * Register a specific autoloader for the module
     */
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();

        $loader->registerNamespaces(
            [
                "Vokuro\\Geo\\Controllers" => "../app/modules/geo/controllers/",
                "Vokuro\\Geo\\Models"      => "../app/modules/geo/models/",
                "Vokuro\\Geo\\Services"      => "../app/modules/geo/services/",
                "Vokuro"      => "../app/library/",
            ]
        );

        $loader->register();
    }

    /**
     * Register specific services for the module
     */
    public function registerServices(DiInterface $di)
    {
        // Registering a dispatcher
        $di->set(
            "dispatcher",
            function () {
                $dispatcher = new Dispatcher();

                $dispatcher->setDefaultNamespace("Vokuro\\Geo\\Controllers");

                return $dispatcher;
            }
        );

        $di->set("url", function()
        {
           $url = new Url();
            $config = $this->getConfig();
            $base_uri = $config->application->baseUri;

            $url->setBaseUri($base_uri . 'geo_module/');
            $url->setStaticBaseUri($base_uri);

            return $url;
        });

        // Registering the view component
        $di->set(
            "view",
            function () {
                $view = new View();

                $view->setViewsDir("../app/modules/geo/views/");
                $view->setLayoutsDir('../../../views/layouts/');

                $view->registerEngines([
                    '.volt' => function ($view) {
                        $config = $this->getConfig();

                        $volt = new VoltEngine($view, $this);


                        return $volt;
                    }
                ]);

                return $view;
            }
        );
    }
}