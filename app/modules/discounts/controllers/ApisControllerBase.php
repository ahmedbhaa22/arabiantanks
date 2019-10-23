<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 2:03 PM
 */

namespace Vokuro\Discounts\Controllers;


use Phalcon\Mvc\Controller;

class ApisControllerBase extends Controller
{
    protected function sendJson($content)
    {
        $this->response->setContentType('application/json', 'UTF-8');
        $this->response->setContent(json_encode($content));
        $this->response->send();
    }
}