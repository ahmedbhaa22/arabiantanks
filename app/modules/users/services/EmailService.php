<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/28/2017
 * Time: 2:09 PM
 */

namespace Vokuro\UsersModule\Services;


use Phalcon\Mvc\Controller;
use Vokuro\UsersModule\ServicesInterfaces\EmailServiceInterface;

class EmailService implements EmailServiceInterface
{
    private $controller;

    private function __construct(){}

    public static function _instantiate()
    {
        static $instance = null;

        if($instance === null)
        {
            $instance = new EmailService();
        }

        return $instance;
    }

    public function getControllerObj()
    {
        return $this->controller;
    }

    public function setControllerObj($controller_obj)
    {
        if(isset($controller_obj) && $controller_obj instanceof Controller)
        {
            $this->controller = $controller_obj;
        }

        return $this;
    }

    public function send($receiver_email, $receiver_name, $email_title, $email_template_name, $data=[])
    {
        $result = false;

        if(filter_var($receiver_email, FILTER_VALIDATE_EMAIL))
        {
            if(is_string($receiver_name) && strlen($receiver_name) && is_string($email_title) && strlen($email_title))
            {
                if(is_string($email_template_name) && strlen($email_template_name) && is_array($data))
                {
                    try
                    {
                        $this->controller->di->get('mail')
                            ->send([$receiver_email=>$receiver_name], $email_title, $email_template_name, $data);

                        $result = true;
                    }
                    catch(\Exception $e)
                    {
                        $result = false;
                    }
                }
            }
        }

        return $result;
    }
}