<?php

namespace Vokuro\Control;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Url as UrlResolver;

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
                "Vokuro\\Control\\Controllers" => "../app/modules/control/controllers/",
                //"Vokuro\\Cms\\Models"      => "../app/modules/cms/models/",
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

                $dispatcher->setDefaultNamespace("Vokuro\\Control\\Controllers");

                return $dispatcher;
            }
        );

        // Registering the view component
        $di->set(
            "view",
            function () {
                $view = new View();

                $view->setViewsDir("../app/modules/control/views/");
                //$view->setLayoutsDir('../../../views/layouts/');

                $view->registerEngines([
                    '.volt' => function ($view) {
                        $config = $this->getConfig();

                        $volt = new VoltEngine($view, $this);
                        $volt->setOptions([
                            'compiledPath' => $config->application->cacheDir . 'volt/',
                            'compiledSeparator' => '_'
                        ]);


                        return $volt;
                    }
                ]);

                return $view;
            }
        );

        $di->setShared('url', function () {
            $config = $this->getConfig();
            $url = new UrlResolver();
            $url->setBaseUri($config->application->baseUri."control_module/");
            $url->setStaticBaseUri($config->application->baseUri);
            return $url;
        });

    }
}