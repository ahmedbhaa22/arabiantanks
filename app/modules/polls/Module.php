<?php

namespace Vokuro\Polls;

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
                "Vokuro\\Polls\\Controllers" => "../app/modules/polls/controllers/",
                "Vokuro\\Polls\\Models"      => "../app/modules/polls/models/",
                "Vokuro\\Polls\\Services"    => "../app/modules/polls/services/",
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

                $dispatcher->setDefaultNamespace("Vokuro\\Polls\\Controllers");

                return $dispatcher;
            }
        );

        $di->set("url", function()
        {
           $url = new Url();
            $config = $this->getConfig();
            $base_uri = $config->application->baseUri;

            $url->setBaseUri($base_uri . 'polls_module/');
            $url->setStaticBaseUri($base_uri);

            return $url;
        });
        $di->set("urlStatic", function()
        {
            $url = new Url();
            $config = $this->getConfig();
            $base_uri = $config->application->baseUri;

            $url->setBaseUri($base_uri);
            $url->setStaticBaseUri($base_uri);

            return $url;
        });

        // Registering the view component
        $di->set(
            "view",
            function () {
                $view = new View();


                $view->setViewsDir(__DIR__ . '/views/');
                $view->setLayoutsDir(__DIR__ . '/views/layouts/');

                $view->registerEngines([
                    '.volt' => function ($view) {
                        $config = $this->getConfig();

                        $volt = new VoltEngine($view, $this);
                        $volt->setOptions([
                            'compiledPath'      => $config->application->cacheDir . 'volt/',
                            'compiledSeparator' => '_'
                        ]);
                        $compiler = $volt->getCompiler(); $compiler->addFilter('round','round');

                        return $volt;
                    }
                ]);

                return $view;
            }
        );
    }
}