<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/4/2017
 * Time: 11:20 PM
 */

namespace Vokuro\UsersModule\Models;


use Phalcon\Mvc\Model;

class LoginTypes extends Model
{
    public $id;
    public $name;

    public function getSource()
    {
        return 'user_module_login_types';
    }

    public function initialize()
    {
        $this->hasMany(
            'id',
            UserTokens::class,
            'type',
            [
                'alias' => 'tokens'
            ]
        );

        $this->hasOne(
            'id',
            SocialAppInfo::class,
            'social_app_type',
            [
                'alias' => 'appInfo'
            ]
        );
    }

    public static function normal()
    {
        return self::findFirst([
            'name like {name}',
            'bind' => [
                'name' => '%normal%'
            ]
        ])->id;
    }

    public static function facebook()
    {
        return self::findFirst([
            'name like {name}',
            'bind' =>[
                'name' => '%facebook%'
            ]
        ])->id;
    }

    public static function twitter()
    {
        return self::findFirst([
            'name like {name}',
            'bind' =>[
                'name' => '%twitter%'
            ]
        ])->id;
    }

    public static function instagram()
    {
        return self::findFirst([
            'name like {name}',
            'bind' =>[
                'name' => '%instagram%'
            ]
        ])->id;
    }
}