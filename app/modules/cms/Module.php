<?php

namespace Vokuro\Cms;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Events\Manager as EventsManager;

use Phalcon\DI\FactoryDefault;
use Phalcon\Mvc\User\Plugin;

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
                "Vokuro\\Cms\\Controllers" => "../app/modules/cms/controllers/",
                //"Vokuro\\Cms\\Models"      => "../app/modules/cms/models/",
                "Vokuro\\Discounts\\Models" => "../app/modules/discounts/models",
                "Vokuro\\Cart\\Models" => "../app/modules/cart/models/",
                "Vokuro\\Cms\\Services"    => "../app/modules/cms/services/",
                "Vokuro\UsersModule\Models" => "../app/modules/users/models/",
                "Vokuro\UsersModule\Services" => "../app/modules/users/services/",
                "Vokuro\Cart\Models" => "../app/modules/cart/models/",
                "Vokuro\Maintenance\Models" => "../app/modules/maintenance/models/",
                "Vokuro\\Offers\\Models" => "../app/modules/offers/models/",
                "Vokuro\\SalesVisits\\Models" => "../app/modules/sales_visits/models/"
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

                $dispatcher = new Dispatcher;
//                $eventsManager = new EventsManager();
//                $eventsManager->attach('dispatch:beforeException', new NotFoundPlugin);
//                $dispatcher->setEventsManager($eventsManager);
                $dispatcher = new Dispatcher();

                $dispatcher->setDefaultNamespace("Vokuro\\Cms\\Controllers");

                return $dispatcher;
            }
        );

        // Registering the view component
        $di->set(
            "view",
            function () {
                $view = new View();

                $view->setViewsDir("../app/modules/cms/views/");
                $view->setLayoutsDir('../../../views/layouts/');

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
            $url->setBaseUri($config->application->baseUri."cms_module/");
            $url->setStaticBaseUri($config->application->baseUri);
            return $url;
        });

    }
}