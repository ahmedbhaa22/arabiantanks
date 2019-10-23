<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/5/2017
 * Time: 3:43 PM
 */

namespace Vokuro\UsersModule\Services;


use Phalcon\Mvc\Controller;

class RedirectService
{
    private $controller_obj;

    private function __construct(){}

    public static function _instantiate()
    {
        static $instance = null;

        if($instance === null)
        {
            $instance = new RedirectService();
            $instance->controller_obj = null;
        }

        return $instance;
    }

    public function back()
    {
        return $this->controller_obj->response->redirect($this->controller_obj->request->getServer('HTTP_REFERER'));
    }

    public function withMessage($type, $message, $destination=null)
    {
        switch($type)
        {
            case 'error':
                $this->controller_obj->flashSession->error($message);
                return $this->controller_obj->response->redirect($destination);
                break;
            case 'success':
                $this->controller_obj->flashSession->success($message);
                return $this->controller_obj->response->redirect($destination);
                break;
            default:
                return $this->controller_obj->response->redirect($destination);
                break;
        }
    }

    public function toAction($controller_name, $action_name, $data)
    {
        return $this->controller_obj->dispatcher->forward([
            'controller' => $controller_name,
            'action' => $action_name,
            'params'=>[
                $data
            ]
        ]);
    }

    public function withDataInSession($data=['key'=>'', 'content'=>null], $destination)
    {
        $this->controller_obj->session->set($data['key'], $data['content']);
        return $this->controller_obj->response->redirect($destination);
    }

    public function withDataInQueryString($data=['key'=>'value'], $destination)
    {
        return $this->controller_obj->response->redirect($destination.'?'.http_build_query($data));
    }

    public function getControllerObj()
    {
        return $this->controller_obj;
    }

    public function setControllerObj($controller_obj)
    {
        if(isset($controller_obj) && $controller_obj instanceof Controller)
        {
            $this->controller_obj = $controller_obj;
        }

        return $this;
    }
}