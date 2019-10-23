<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 6/19/2017
 * Time: 9:21 AM
 */

namespace Vokuro\UsersModule;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Vokuro\ApiFactory;


class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();

        $loader->registerNamespaces(
            [
                "Vokuro\\UsersModule\\Controllers" => "../app/modules/users/controllers/",
                "Vokuro\\UsersModule\\Models"      => "../app/modules/users/models/",
                "Vokuro\\UsersModule\\Services"    => "../app/modules/users/services/",
                "Vokuro\\UsersModule\\ServicesInterfaces"    => "../app/modules/users/servicesInterfaces/",
                "Vokuro"                                     => "../app/library/",
                "Vokuro\\Cart\\Models"                       => "../app/modules/cart/models/",
                "Vokuro\\Discounts\\Models"                  => "../app/modules/discounts/models/",
                "Vokuro\\Offers\\Models"                  => "../app/modules/offers/models/"
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

                $dispatcher->setDefaultNamespace("Vokuro\\UsersModule\\Controllers");

                return $dispatcher;
            }
        );

        $di->set(
            "url",
            function () {
                $url = new Url();
                $config = $this->getConfig();
                $base_uri = $config->application->baseUri;
                // print_r($base_uri);

                $url->setBaseUri($base_uri . "users_module/");
                $url->setStaticBaseUri($base_uri);
                return $url;
            }
        );

        // Registering the view component
        $di->set(
            "view",
            function () {
                $view = new View();

                $view->setViewsDir("../app/modules/users/views/");

                $view->registerEngines([
                    '.volt' => function ($view) {
                        $config = $this->getConfig();

                        $volt = new VoltEngine($view, $this);
                        $volt->setOptions(array(
                            'compiledPath' => $config->application->cacheDir . 'volt/',
                            'compiledSeparator' => '_'
                        ));


                        return $volt;
                    }
                ]);

                return $view;
            }
        );

        $di->set('apiFactory', function()
        {
            return new ApiFactory($this->getConfig()->application->baseUri);
        });
    }
}
