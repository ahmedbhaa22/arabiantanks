<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/13/2017
 * Time: 10:01 PM
 */

namespace Models;


use Models\UsersMobile;
use Phalcon\Mvc\Model;

class NotificationsShowType extends Model
{
    public $id;
    public $name;

    public function getSource()
    {
        return 'notifications_show_type';
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

    public static function now()
    {
        return self::findFirst([
            'name like {type}',
            'bind' => [
                'type' => '%'.'now'.'%'
            ]
        ])->id;
    }

    public static function scheduled()
    {
        return self::findFirst([
            'name like {type}',
            'bind' => [
                'type' => '%'.'scheduled'.'%'
            ]
        ])->id;
    }
}