<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/6/2017
 * Time: 3:29 PM
 */

namespace Vokuro\UsersModule\ServicesInterfaces;


interface JwtServiceInterface
{
    public static function _instantiate();
    public function generateToken($user);
    public function decodeToken($token);
    public function getUserActiveToken($user);
    public function getActiveUser($access_token);
    public function getTokenData($access_token);
    public function verifyUserToken($access_token, $user_obj);
    public function expireToken($token);
}