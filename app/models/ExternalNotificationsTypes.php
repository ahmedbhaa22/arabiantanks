<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/14/2017
 * Time: 11:05 AM
 */

namespace Models;


use Models\UsersMobile;
use Phalcon\Mvc\Model;

class ExternalNotificationsTypes extends Model
{
    public $id;
    public $external_type;
    public $app_id;
    public $module_id;

    public function getSource()
    {
        return 'external_notifications_types';
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

    public static function pricelistRequest($app_id)
    {
        return self::findFirst([
            'external_type like {type} and app_id = {app_id}',
            'bind' => [
                'type' => '%pricelist_request%',
                'app_id' => $app_id
            ]
        ])->id;
    }

    public static function pricelistResponse($app_id)
    {
        return self::findFirst([
            'external_type like {type} and app_id = {app_id}',
            'bind' => [
                'type' => '%pricelist_response%',
                'app_id' => $app_id
            ]
        ])->id;
    }

    public static function confirmUser($app_id)
    {
        return self::findFirst([
            'external_type like {type} and app_id = {app_id}',
            'bind' => [
                'type' => '%confirm_user%',
                'app_id' => $app_id
            ]
        ])->id;
    }
}