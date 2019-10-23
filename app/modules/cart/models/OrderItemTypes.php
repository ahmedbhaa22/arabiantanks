<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/21/2017
 * Time: 2:16 PM
 */

namespace Vokuro\Cart\Models;


use Phalcon\Mvc\Model;

class OrderItemTypes extends Model
{
    public $id;
    public $name;

    public function getSource()
    {
        return 'data_cms_order_item_types';
    }

    public function initialize()
    {
        // define relations
    }

    public static function dataCms()
    {
        return static::findFirst([
            'name like {name}',
            'bind' => [
                'name' => '%data_cms%'
            ]
        ])->id;
    }

    public static function offer()
    {
        return static::findFirst([
            'name like {name}',
            'bind' => [
                'name' => '%offer%'
            ]
        ])->id;
    }
}