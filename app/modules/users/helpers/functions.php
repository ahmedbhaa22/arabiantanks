<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/5/2017
 * Time: 4:14 PM
 */

/**
 * @param int $length
 * @return string
 *
 * generate a random string with default length og 10 characters
 */
function randomString($length = 10)
{
    $characters = 'aAbBcC012dDeEfF345gGhHiI678jJkKlL91011mMnNoO1213pPqQrR141516sStTuUv171819VwWxXyYzZw';
    $random_string = '';
    for($i = 0; $i < $length; $i++)
    {
        $random_string .= $characters[rand(0, strlen($characters)-1)];
    }
    return $random_string;
}

/**
 * dump and die
 */
function dd()
{
    $args = func_get_args();
    foreach($args as $arg)
    {
        print_r($arg);
    }die;
}

/**
 * @param $request_data
 * @return bool|\Models\UsersMood
 *
 * gets user based on the login identifier (email|username|mobile)
 */
function identifyUser($request_data)
{
    $user = false;
    $login_identifier = getUserLoginIdentifier($request_data);

    if(isset($login_identifier))
    {
        $user = \Models\UsersMobile::findFirst([
            '(Mail like {identifier} OR User like {identifier} OR Mobile like {identifier}) AND Active = 1 AND Application_ID = {app_id}',
            'bind' => [
                'identifier' => '%'.$login_identifier.'%',
                'app_id'     => $request_data['app_id']
            ]
        ]);
    }

    return $user;
}

/**
 * @param $request_data
 * @return null
 *
 * gets the user login identifier (email|username|mobile)
 */
function getUserLoginIdentifier($request_data)
{
    $identifier = null;

    if(array_has($request_data, 'email'))
    {
        $identifier = $request_data['email'];
    }
    elseif(array_has($request_data, 'username'))
    {
        $identifier = $request_data['username'];
    }
    elseif(array_has($request_data, 'mobile'))
    {
        $identifier = $request_data['mobile'];
    }

    return $identifier;
}

/**
 * @param $verification_code
 * @return \Models\UsersMood
 *
 * checks if user exists with the given verification code
 */
function userWithVerificationCodeExists($verification_code)
{
    return \Models\UsersMobile::findFirst([
        'conditions' => 'confirm_code like {code}',
        'columns' => 'ID',
        'bind' => [
            'code' => $verification_code
        ]
    ]);
}

function userCustomColumns($user, $public_path=null)
{
    // var_dump($user->Img);die;
    $user_data['id']             = $user->ID;
    $user_data['email']          = $user->Mail;
    $user_data['username']       = $user->User?:"";
    $user_data['mobile']         = $user->Mobile;
    $user_data['name']           = $user->Title;
    $user_data['join_date']      = $user->Join_Date;
    $user_data['application_id'] = $user->Application_ID;
    $user_data['is_active']      = $user->Active;
    $user_data['is_admin']       = $user->is_admin;
    $user_data['Img']            = (strlen($user->Img) > 0 && $user->Img != null)?$public_path.$user->Img:'';
    $user_data['gender_id']      = "";
    $user_data['birth_date']     = "";
    $user_data['timezone']       = "";
    $user_data['country_id']     = "";
    $user_data['city_id']        = "";
    $user_data['region_id']      = "";

    if($user->data)
    {
        $user_data['gender_id']  = $user->data->gender_id ?:"";
        $user_data['birth_date'] = $user->data->birthdate?: "";
        $user_data['timezone']   = $user->data->timezone?:"";
        $user_data['country_id'] = $user->data->country_id?:"";
        $user_data['city_id']    = $user->data->city_id?:"";
        $user_data['region_id']  = $user->data->region_id?:"";
    }

    $user_cart       = \Vokuro\Cart\Models\Orders::getDetailed($user->ID, \Vokuro\Cart\Models\OrderStatuses::cart());
    $user_cart_count = count($user_cart['items']['cms']) + count($user_cart['items']['offers']);

    $user_wishlist       = \Vokuro\Cart\Models\Orders::getDetailed($user->ID, \Vokuro\Cart\Models\OrderStatuses::wishlist());
    $user_wishlist_count = count($user_wishlist['items']['cms']) + count($user_wishlist['items']['offers']);

    $user_data['cart_count']     = $user_cart_count;
    $user_data['wishlist_count'] = $user_wishlist_count;
    $user_data['is_subscribed']  = $user->isSubscribed();

    return $user_data;
}

function orderDetails($order_id)
{
    $order = \Vokuro\Cart\Models\Orders::findFirst($order_id);

    $items_total_price  = 0;
    $offers_total_price = 0;
    $total_shipping_fee = 0;
    $total_items_cost   = 0;

    foreach($order->items as $item)
    {
        switch($item->item_type_id)
        {
            case 1:
            $items_total_price  += $item->count * $item->cmsDetails->extraFields->price;
            $total_items_cost   += $item->count * $item->cmsDetails->extraFields->cost;
            $total_shipping_fee += $item->cmsDetails->extraFields->shipping_fee;
            break;
            case 2:
            $offers_total_price += $item->count * $item->offerDetails->price;
            break;
        }
    }

    return [
    'total_price' => $items_total_price + $offers_total_price,
    'total_shipping_fee' => $total_shipping_fee,
    'total_cost' => $total_items_cost
    ];
}