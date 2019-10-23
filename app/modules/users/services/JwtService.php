<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/6/2017
 * Time: 3:34 PM
 */

namespace Vokuro\UsersModule\Services;


use Firebase\JWT\JWT;
use Models\UsersMobile;
use Vokuro\UsersModule\Models\LoginTypes;
use Vokuro\UsersModule\Models\TokenSecretKeys;
use Vokuro\UsersModule\Models\UserTokens;
use Vokuro\UsersModule\ServicesInterfaces\JwtServiceInterface;

class JwtService implements JwtServiceInterface
{
    private function __construct(){}

    public static function _instantiate()
    {
        static $instance = null;

        if($instance === null)
        {
            $instance = new JwtService();
        }

        return $instance;
    }

    /**
     * @param $user
     * @return bool|string
     *
     * generates a JWT based on user's data
     */
    public function generateToken($user)
    {
        $result = false;

        $secret_key = randomString();
        $token_data = [
            'id'   => $user->ID,
            'email' => $user->Mail,
            'name' => $user->Title,
            'created_at' => time()
        ];

        $jwt = JWT::encode($token_data, $secret_key);

        if($jwt)
        {
            $user_token = new UserTokens();

            $user_token->user_id = $user->ID;
            $user_token->token = $jwt;
            $user_token->is_expired = 0;
            $user_token->type = LoginTypes::normal();
            $user_token->created_at = time();
            $user_token->secretKey = $secret_key;

            if($user_token->save())
            {
                $token_secret_key = new TokenSecretKeys();
                $token_secret_key->token_id = $user_token->id;
                $token_secret_key->key = $secret_key;
                $token_secret_key->save();

                $user->token_id = $user_token->id;
                $user->confirm_key_expired = 1;

                if($user->save())
                {
                    $result = $jwt;
                }
            }
        }

        return $result;
    }

    /**
     * @param $token
     * @return bool|object
     *
     * decodes JWT to a json object
     */
    public function decodeToken($token)
    {
        $result = false;

        if(isset($token))
        {
            $token_obj = $this->getTokenData($token);

            if($token_obj)
            {
                $token_secret = $token_obj->secretKey;
                $result = JWT::decode($token, $token_secret->key, ['HS256']);
            }
        }

        return $result;
    }

    public function getUserActiveToken($user)
    {
        $result = false;

        if(isset($user))
        {
            if($user->activeToken)
            {
                $result = $user->activeToken;
            }
        }

        return $result;
    }

    /**
     * @param $access_token
     * @return bool|\Phalcon\Mvc\Model\Resultset|\Phalcon\Mvc\Phalcon\Mvc\Model
     *
     * returns the user based on the given token
     */
    public function getActiveUserData($access_token)
    {
        $result = false;

        $token_data = $this->getTokenData($access_token);

        if($token_data)
        {
            $user = $token_data->user;

            if($user)
            {
                //Commented For Error, To be reviewed
//                if($this->verifyUserToken($access_token, $user))
//                {
//                    $result = userCustomColumns($user);
//                }
                $result = userCustomColumns($user);

            }
        }

        return $result;
    }

    public function getActiveUser($access_token)
    {
        $result = false;

        $token_data = $this->getTokenData($access_token);

        if($token_data)
        {
            $user = $token_data->user;

            if($user)
            {
                $result = $user;
            }
        }

        return $result;
    }

    /**
     * @param $access_token
     * @return bool|\Phalcon\Mvc\Model
     *
     * gets the token object
     */
    public function getTokenData($access_token)
    {
        $result = false;

        $token_data = UserTokens::findFirst([
            'token like {token}',
            'bind' => [
                'token' => '%'.$access_token.'%'
            ]
        ]);

        if($token_data)
        {
            $result = $token_data;
        }

      return $result;
    }

    /**
     * @param $access_token
     * @param $user_obj
     * @return bool
     *
     * verification of the token against user
     */
    public function verifyUserToken($access_token, $user_obj)
    {
        $result = false;

        $decoded_token = $this->decodeToken($access_token);

        if($decoded_token->id === $user_obj->ID)
        {
            $result = true;
        }

        return $result;
    }

    public function expireToken($user)
    {
        $result = false;

        $token = $user->activeToken;

        $token->is_expired = 1;
        $token->expired_at = time();

        if($token->save())
        {
            $result = true;
        }
        else
        {
            $result = $token;
        }

        return $result;
    }
}