<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/21/2017
 * Time: 2:54 PM
 */

namespace Vokuro\Cart\Models;


use Phalcon\Mvc\Model;

class OrderStatuses extends Model
{
    public $id;
    public $status_name;
    public $display_name;
    public $parent_status_id;
    public $application_id;
    public $module_id;

    public function getSource()
    {
        return 'data_cms_order_status';
    }

    public static function wishlist()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%wishlist%'
            ]
        ])->id;
    }

    public static function cart()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%cart%'
            ]
        ])->id;
    }

    public static function newOrder()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%new_order%'
            ]
        ])->id;
    }

    public static function paymentConfirmed()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%payment_confirmed%'
            ]
        ])->id;
    }

    public static function paymentRejected()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%payment_rejected%'
            ]
        ])->id;
    }

    public static function pending()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%pending%'
            ]
        ])->id;
    }

    public static function shipping()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%shipping%'
            ]
        ])->id;
    }

    public static function delivered()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%delivered%'
            ]
        ])->id;
    }

    public static function canceled()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%canceled%'
            ]
        ])->id;
    }

    public static function returned()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%returned%'
            ]
        ])->id;
    }

    public static function inProgress()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%in_progress%'
            ]
        ])->id;
    }

    public static function returnedWithPermission()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%returned_with_permission%'
            ]
        ])->id;
    }

    public static function fixProduct()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%fix_product%'
            ]
        ])->id;
    }

    public static function returnProduct()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%return_product%'
            ]
        ])->id;
    }

    public static function rejectProduct()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%reject_product%'
            ]
        ])->id;
    }

    public static function cancel()
    {
        return static::findFirst([
            'status_name like {name}',
            'bind' => [
                'name' => '%cancel%'
            ]
        ])->id;
    }

    public static function purchaseOrderStatuses()
    {
        return [
            static::newOrder(),
            static::paymentConfirmed(),
            static::inProgress(),
            static::shipping(),
            static::delivered(),
            static::returned(),
            static::canceled()
        ];
    }

    public static function purchaseOrderStatusObjects()
    {
        return static::query()->inWhere('id', static::purchaseOrderStatuses())->execute();
    }

    public static function statisticsUnfinishedOrdersStatuses()
    {
        return [
            static::newOrder(),
            static::pending()
        ];
    }

    public static function statisticsAllOrdersStatuses()
    {
        return [
            static::newOrder(),
            static::pending(),
            static::shipping(),
            static::cancel()
        ];
    }
}