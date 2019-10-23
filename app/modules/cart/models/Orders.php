<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/21/2017
 * Time: 2:12 PM
 */

namespace Vokuro\Cart\Models;


use Models\UsersMobile;
use Phalcon\Mvc\Model;

class Orders extends Model
{
    public $id;
    public $user_id;
    public $address_id;
    public $date;
    public $updated_at;
    public $application_id;
    public $module_id;
    public $total_price;
    public $status;
    public $payment_receipt;
    public $user_comment;

    public function getSource()
    {
        return 'data_cms_orders';
    }

    public function initialize()
    {
        $this->hasMany(
            'id',
            OrderItems::class,
            'order_id',
            [
                'alias' => 'items'
            ]
        );

        $this->belongsTo(
            'user_id',
            UsersMobile::class,
            'ID',
            [
                'alias' => 'user'
            ]
        );

        $this->belongsTo(
            'status',
            OrderStatuses::class,
            'id',
            [
                'alias' => 'statusDetails'
            ]
        );

        $this->belongsTo(
            'address_id',
            \Vokuro\UsersModule\Models\UserAddresses::class,
            'id',
            [
                'alias' => 'userAddress'
            ]
        );
    }

    public static function getDetailed($user_id, $type,$order_id=null)
    {
        $order_model['items']['cms']    = [];
        $order_model['items']['offers'] = [];
        if($order_id!=null){
            $order = self::findFirst([
                'id='.$order_id,

            ]);
        }else{
            $order = self::findFirst([
                'user_id = {user_id} and status = {status}',
                'bind' => [
                    'user_id' => $user_id,
                    'status' => $type
                ]
            ]);
        }



//        if($order){
//            die("Order Found");
//        }

        if($order)
        {

            $order_model['items']['cms'] = $order->getItems([OrderItems::class.'.item_type_id = 1'])->toArray();
            $order_model['items']['offers'] = $order->getItems([OrderItems::class.'.item_type_id = 2'])->toArray();
        }
       // print_r($order_model);die;

        return $order_model;
    }

    public static function getUserCart($user_id)
    {
        $cart = null;

        $user_cart = static::findFirst([
            'user_id = {user_id} and status = {status}',
            'bind' => [
                'user_id' => $user_id,
                'status'  => OrderStatuses::cart()
            ]
        ]);

        if($user_cart)
        {
            $cart = $user_cart;
        }
        else
        {
            $user_cart = new Orders();

            $user_cart->user_id = $user_id;
            $user_cart->address_id = 0;
            $user_cart->date = time();
            $user_cart->updated_at = time();
            $user_cart->application_id = 1;
            $user_cart->module_id = 1;
            $user_cart->status = OrderStatuses::cart();

            $user_cart->save();

            $cart = $user_cart;
        }

        return $cart;
    }

    public static function getUserWishlist($user_id)
    {
        $wishlist = null;

        $user_wishlist = static::findFirst([
            'user_id = {user_id} and status = {status}',
            'bind' => [
                'user_id' => $user_id,
                'status'  => OrderStatuses::wishlist()
            ]
        ]);

        if($user_wishlist)
        {
            $wishlist = $user_wishlist;
        }
        else
        {
            $wishlist = new Orders();

            $wishlist->user_id = $user_id;
            $wishlist->address_id = 0;
            $wishlist->application_id = 1;
            $wishlist->module_id = 1;
            $wishlist->date = time();
            $wishlist->updated_at = time();
            $wishlist->status = OrderStatuses::wishlist();

            $wishlist->save();
        }

        return $wishlist;
    }

    public static function handleChangeCartToNewOrder($user, $payment_receipt, $user_comment, $total_price)
    {
        $result = false;

        $cart = Orders::getUserCart($user->ID);

        $cart->status          = OrderStatuses::newOrder();
        $cart->payment_receipt = $payment_receipt;
        $cart->address_id      = $user->mainAddress->id;
        $cart->total_price     = $total_price;
        $cart->updated_at      = time();
        if(strlen($user_comment))
        {
            $cart->user_comment = $user_comment;
        }

        if($cart->save())
        {
            $result = $cart;

            $new_cart = new Orders();

            $new_cart->user_id    = $cart->user_id;
            $new_cart->address_id = 0;
            $new_cart->date       = time();
            $new_cart->updated_at = time();
            $new_cart->application_id = 1;
            $new_cart->module_id      = 1;
            $new_cart->status         = OrderStatuses::cart();

            $new_cart->save();
        }

        return $result;
    }

    public function itemsCount()
    {
        return count($this->items);
    }

    public function formattedDate()
    {
        return date('d/m/Y', $this->date);
    }
}