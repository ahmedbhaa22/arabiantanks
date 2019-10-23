<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/7/2017
 * Time: 2:33 PM
 */

namespace Vokuro\UsersModule\Models;


use Phalcon\Mvc\Model;

class SocialAppInfo extends Model
{
    public $id;
    public $consumer_key;
    public $consumer_secret;
    public $social_app_type;

    public function getSource()
    {
        return 'user_module_social_app_info';
    }

    public function initialize()
    {
        $this->belongsTo(
            'social_app_type',
            LoginTypes::class,
            'id',
            [
                'alias' => 'socialApp'
            ]
        );
    }

    public static function getConsumerKey($type)
    {
        $result = false;

        $data = self::findFirst([
            'social_app_type = {type}',
            'bind' => [
                'type' => $type
            ]
        ]);

        if($data)
        {
            $result = $data->consumer_key;
        }

        return $result;
    }

    public static function getConsumerSecret($type)
    {
        $result = false;

        $data = self::findFirst([
            'social_app_type = {type}',
            'bind' => [
                'type' => $type
            ]
        ]);

        if($data)
        {
            $result = $data->consumer_secret;
        }

        return $result;
    }
}