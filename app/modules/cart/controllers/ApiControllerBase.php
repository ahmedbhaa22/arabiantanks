<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/21/2017
 * Time: 2:34 PM
 */

namespace Vokuro\Cart\Controllers;

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;

class ApiControllerBase extends Controller
{
	public $lang;
    public $lang_id;


    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
    	if($this->request->isGet() && is_array($this->request->get()) && array_key_exists('lang_id', $this->request->get()))
        {
            $this->lang = ($this->request->get('lang_id') == 1)?'ar':'en';
            $this->lang_id = $this->request->get('lang_id');
        }
        if($this->request->isPost() && is_array($this->request->getJsonRawBody(true)) && array_key_exists('lang_id', $this->request->getJsonRawBody(true)))
        {
            $this->lang = ($this->request->getJsonRawBody(true)['lang_id'] == 1)?'ar':'en';
            $this->lang_id = $this->request->getJsonRawBody(true)['lang_id'];
        }
    }

    protected function sendJson($content)
    {
        $this->response->setContentType('application/json', 'UTF-8');
        $this->response->setJsonContent($content);
        $this->response->send();
    }
}