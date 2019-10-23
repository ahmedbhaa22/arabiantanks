<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 12:18 PM
 */

namespace Vokuro\Offers\Controllers;


use Phalcon\Mvc\Controller;

class ApiControllerBase extends Controller
{
    public function beforeExecuteRoute()
    {
        $this->view->disable();
    }

    protected function sendJson($content)
    {
        $this->response->setContentType('application/json', 'UTF-8');
        $this->response->setContent(json_encode($content));
        $this->response->send();
    }
}