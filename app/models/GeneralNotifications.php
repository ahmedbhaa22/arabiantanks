<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/13/2017
 * Time: 9:56 PM
 */

namespace Models;


use Models\UsersMobile;
use Phalcon\Mvc\Model;

class GeneralNotifications extends Model
{
    public $id;
    public $type_id;
    public $user_id;
    public $module_id;
    public $application_id;
    public $time;
    public $external_type_id;
    public $show_type_id;
    public $content;
    public $is_read;
    public $url;

    public function getSource()
    {
        return 'general_notifications';
    }

    public static function find($params=null)
    {
        return parent::find($params);
    }

    public static function get($criteria=['type'=>null,'show_type'=>null,
        'external_type'=>null,'user'=>null,'app'=>null,'module'=>null])
    {
        $result = [];

        if(is_array($criteria))
        {
            $result = self::find([
                'type_id = {type} and show_type_id = {show_type}
                and external_type_id = {external_type} and user_id = {user} and application_id = {app} and module_id = {module}',
                'bind' => [
                    'type' => $criteria['type'],
                    'show_type' => $criteria['show_type'],
                    'external_type' => $criteria['external_type'],
                    'user' => $criteria['user'],
                    'app' => $criteria['app'],
                    'module' => $criteria['module']
                ],
                'limit' => 20
            ]);
        }

        return $result;
    }

    public static function findFirst($params=null)
    {
        return parent::findFirst($params);
    }

    public function initialize()
    {
        $this->belongsTo(
            'type_id',
            NotificationsTypes::class,
            'id',
            [
                'alias' => 'type'
            ]
        );

        $this->belongsTo(
            'user_id',
            UsersMobile::class,
            'ID',
            [
                'alias' => 'to'
            ]
        );

        $this->belongsTo(
            'show_type_id',
            NotificationsShowType::class,
            'id',
            [
                'alias' => 'showType'
            ]
        );

        $this->belongsTo(
            'external_type_id',
            ExternalNotificationsTypes::class,
            'id',
            [
                'alias' => 'externalType'
            ]
        );
    }
}