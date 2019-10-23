<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 3/6/2017
 * Time: 1:40 PM
 */

namespace Vokuro\Ads;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\Url;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Vokuro\Auth\Auth;
use Phalcon\Crypt;

date_default_timezone_set('Africa/Cairo');
class Module implements ModuleDefinitionInterface
{
    public function registerAutoLoaders(DiInterface $di = null)
    {
        // register specific module auto loader

        $loader = new Loader();

        $loader->registerNamespaces(
            [
                "Vokuro\\Ads\\Controllers" => "../app/modules/ads/controllers/",
                "Vokuro\\Ads\\Models"      => "../app/modules/ads/models/",
                "Vokuro"      => "../app/library/",
            ]
        );

        $loader->register();
    }

    public function registerServices(DiInterface $di)
    {
        // register specific module services

        // registering dispatcher service
        $di->set("dispatcher", function()
        {
            $dispatcher = new Dispatcher();
            $dispatcher->setDefaultNamespace("Vokuro\\Ads\\Controllers");

            return $dispatcher;
        });

        // registering url service
        $di->set("url", function()
        {
           $url = new Url();
            $config = $this->getConfig();
            $base_uri = $config->application->baseUri;

            $url->setBaseUri($base_uri . 'ads_module/');
            $url->setStaticBaseUri($base_uri);

            return $url;
        });

        // registering view service
        $di->set("view", function()
        {
            $view = new View();
            $view->setViewsDir("../app/modules/ads/views");
            $view->setLayoutsDir('../../../views/layouts/');

            $view->registerEngines(
                [
                    '.volt' => function($view)
                    {
                        $config = $this->getConfig();

                        $volt = new VoltEngine($view, $this);

                        return $volt;
                    }
                ]
            );

            return $view;
        });

        $di->set('session', function () {
            $session = new SessionAdapter();
            $session->start();
            return $session;
        });

        $di->set('crypt', function () {
            $config = $this->getConfig();

            $crypt = new Crypt();
            $crypt->setKey($config->application->cryptSalt);
            return $crypt;
        });

        $di->set('auth', function () {
            return new Auth();
        });

        // registering user service
        $di->set("userService", function()
        {
            $id = $this->getShared('auth')->getIdentity()['id'];
            $user = Users::findFirst($id);

            return $user;
        });

    }
}