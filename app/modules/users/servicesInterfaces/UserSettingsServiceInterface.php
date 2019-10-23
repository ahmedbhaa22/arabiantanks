<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/4/2017
 * Time: 10:47 PM
 */

namespace Vokuro\UsersModule\ServicesInterfaces;


interface UserSettingsServiceInterface
{
    public static function _instantiate();
    public function fetchSettings($token);
    public function setSettings();
    public function getUser();
    public function checkUserStatus($user, $request_data);
    public function setControllerObj($controller_obj);
}