<?php

namespace Vokuro\Messages;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Vokuro\Messages\Services\MessagesService;

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
                "Vokuro\\Messages\\Controllers" => "../app/modules/messages/controllers/",
                "Vokuro\\Messages\\Models"      => "../app/modules/messages/models/",
                "Vokuro\\Messages\\Services"      => "../app/modules/messages/services/",
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

                $dispatcher->setDefaultNamespace("Vokuro\\Messages\\Controllers");

                return $dispatcher;
            }
        );

        $di->set("url", function()
        {
           $url = new Url();
            $config = $this->getConfig();
            $base_uri = $config->application->baseUri;

            $url->setBaseUri($base_uri . 'messages_module/');
            $url->setStaticBaseUri($base_uri);

            return $url;
        });

        // Registering the view component
        $di->set(
            "view",
            function () {
                $view = new View();

                $view->setViewsDir("../app/modules/messages/views/");
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

        $di->set(
            "msgService",
            function () {
                return new MessagesService();
            }
        );
    }
}