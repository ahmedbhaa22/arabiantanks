<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/13/2017
 * Time: 9:53 PM
 */
namespace Models;


use Models\UsersMobile;
use Phalcon\Mvc\Model;

class NotificationsTypes extends Model
{
    public $id;
    public $name;

    public function getSource()
    {
        return 'notifications_types';
    }

    public static function find($params=null)
    {
        return parent::find($params);
    }

    public static function findFirst($params=null)
    {
        return parent::findFirst($params);
    }

    public function initialize()
    {
        // define relations
    }

    public static function web()
    {
        return self::findFirst([
            'name like {type}',
            'bind' => [
                'type' => '%'.'web'.'%'
            ]
        ])->id;
    }

    public static function email()
    {
        return self::findFirst([
            'name like {type}',
            'bind' => [
                'type' => '%'.'email'.'%'
            ]
        ])->id;
    }
}