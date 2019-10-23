<?php

namespace Vokuro\Cms\Controllers;

use Models\GeneralNotifications;
use Vokuro\Controllers\ControllerBase;
use Phalcon\Http\Request;
use Phalcon\Security;
use Phalcon\Mvc\Url;

class SystemNotificationsController extends ControllerBase
{
    public function indexAction(){
        $external_requests ="(1,3)";
        $notifications = GeneralNotifications::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND external_type_id IN {$external_requests} and is_read=0 ORDER BY id desc"]);
        $this->view->notifications = $notifications;

    }
}