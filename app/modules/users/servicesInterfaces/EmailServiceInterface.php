<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/28/2017
 * Time: 2:51 PM
 */

namespace Vokuro\UsersModule\ServicesInterfaces;


interface EmailServiceInterface
{
    public static function _instantiate();
    public function setControllerObj($controller_ob);
    public function getControllerObj();
    public function send($receiver_email, $receiver_name, $email_title, $email_template_name, $data=[]);
}