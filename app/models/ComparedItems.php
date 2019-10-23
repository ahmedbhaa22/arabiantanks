<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 11/1/2017
 * Time: 1:21 PM
 */

namespace Vokuro\Models;


use Phalcon\Mvc\Model;

class ComparedItems extends Model
{
    public $id;
    public $item_id;
    public $user_id;

    public function getSource()
    {
        return 'compared_items';
    }

    public static function get($user_id)
    {
        return static::find([
            'user_id = {user_id}',
            'bind' => [
                'user_id' => $user_id
            ]
        ]);
    }

    public function remove($user_id, $item_id)
    {
        $result = false;

        $compare_item = static::findFirst([
            'user_id = {user_id} and item_id = {item_id}',
            'bind' => [
                'user_id' => $user_id,
                'item_id' => $item_id
            ]
        ]);

        if($compare_item && $compare_item->delete())
        {
            $result = true;
        }

        return $result;
    }
}