<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/4/2017
 * Time: 11:04 PM
 */

namespace Vokuro\UsersModule\Services;


use Models\UsersMobile;
use Phalcon\Mvc\Controller;
use Vokuro\UsersModule\Models\UserTokens;
use Vokuro\UsersModule\ServicesInterfaces\UserSettingsServiceInterface;

class UserSettingsService implements UserSettingsServiceInterface
{
    private $user = null;
    private $controller_obj;

    private function __construct(){}

    public static function _instantiate()
    {
        static $instance = null;

        if($instance === null)
        {
            $instance = new UserSettingsService();
        }

        return $instance;
    }

    private function setUser($token)
    {
        $user_token = UserTokens::findFirst([
            'conditions' => 'token like {token}',
            'bind' => [
                'token' => $token
            ]
        ]);

        if($user_token)
        {

            $user_id = $user_token->user_id;
            $this->user = UsersMobile::findFirst($user_id);
        }

        return $this;
    }

    public function getUser()
    {
        return $this->user;
    }

    public function fetchSettings($token)
    {
        $settings = null;

        $this->setUser($token);

        if(isset($this->user))
        {
            $settings = $this->user->setting;
        }

        return $settings;
    }

    public function setSettings()
    {
        // TODO: Implement setSettings() method.
    }


    public function checkUserStatus($user, $request_data)
    {
        $result = false;

        if($this->controller_obj->security->checkHash($request_data['password'], $user->Pass))
        {
            if($user->activeToken)
            {
                $result = US_HAS_ACTIVE_TOKEN;
            }
            else
            {
                $result = US_NEEDS_TOKEN;
            }
        }
        else
        {
            $result = US_UNAUTHORIZED;
        }

        return $result;
    }

    public function setControllerObj($controller_obj)
    {
        if(isset($controller_obj) && $controller_obj instanceof Controller)
        {
            $this->controller_obj = $controller_obj;
        }

        return $this;
    }

    public function getVerificationCode($user)
    {
        $result = false;
        $verification_code = $this->generateVerificationCode();

        $user->confirm_code = $verification_code;
        $user->confirm_code_expired = 0;

        if($user->save())
        {
            $result = $verification_code;
        }

        return $result;
    }

    private function generateVerificationCode()
    {
        $verification_code = randomString();

        $user_with_code_exists = userWithVerificationCodeExists($verification_code);

        if($user_with_code_exists)
        {
            $this->generateVerificationCode();
        }

        return $verification_code;
    }

    public function verifyUser($verification_code)
    {
        $result = false;

        if(isset($verification_code))
        {
            $result = UsersMobile::findFirst([
                'confirm_code like {code} AND confirm_code_expired = 0',
                'bind' => [
                    'code' => $verification_code
                ]
            ]);
        }

        return $result;
    }
}