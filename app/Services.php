<?php

use Phalcon\Mvc\View;
use Phalcon\DI\FactoryDefault;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\Url as UrlProvider;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaData;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Flash\Session as FlashSession;
use Phalcon\Events\Manager as EventsManager;


class Services extends \Base\Services
{
    /**
     * Register a user component
     */
    protected function initElements()
    {
        //return new Menus();
    }
    protected function initDispatcher()
    {
        die("adasdasdada");
        $eventsManager = new EventsManager;
        /**
         * Check if the user is allowed to access certain action using the SecurityPlugin
         */
        //$eventsManager->attach('dispatch:beforeDispatch', new SecurityPlugin);
        /**
         * Handle exceptions and not-found exceptions using NotFoundPlugin
         */
        $eventsManager->attach('dispatch:beforeException', new NotFoundPlugin);
        $dispatcher = new Dispatcher;
        $dispatcher->setEventsManager($eventsManager);
        return $dispatcher;
    }

}
