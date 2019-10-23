<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/25/2017
 * Time: 8:58 PM
 */

namespace Vokuro\UsersModule\Models;


use Models\UsersMobile;
use Phalcon\Mvc\Model;

class UserAddresses extends Model
{
    public $id;
    public $user_id;
    public $country_id;
    public $city_id;
    public $region_id;
    public $details;
    public $postal_code;
    public $is_main;

    public function getSource()
    {
        return 'user_addresses';
    }

    public function initialize()
    {
        $this->belongsTo(
            'user_id',
            UsersMobile::class,
            'ID',
            [
                'alias' => 'user'
            ]
        );

        $this->belongsTo(
            'region_id',
            \Vokuro\Geo\Models\GeoRegions::class,
            'id',
            [
                'alias' => 'region'
            ]
        );
    }

    public static function getMainAddresses()
    {
        return static::find([
            'is_main = 1'
        ]);
    }

    public static function makeNotMain($addresses)
    {
        $result = false;
        try
        {
            foreach($addresses as $address)
            {
                $address->is_main = 0;
                $address->save();

                $result = true;
            }
        }
        catch(\Exception $e)
        {
            $result = false;
        }

        return $result;
    }

    public function createNewAddress($request_data, $user)
    {
        $result['code']     = 0;
        $result['messages'] = [];
        $result['created_address'] = '';

        $this->user_id     = $user->ID;
        $this->country_id  = $request_data['country_id'];
        $this->city_id     = $request_data['city_id'];
        $this->city_id     = $request_data['city_id'];
        $this->region_id   = $request_data['region_id'];
        $this->details     = $request_data['details'];
        $this->postal_code = $request_data['postal_code'];


        if(isset($request_data['is_main']) && $request_data['is_main'] == 1)
        {
            $main_addresses = UserAddresses::getMainAddresses();
            if(count($main_addresses))
            {
                if(UserAddresses::makeNotMain($main_addresses))
                {
                    $this->is_main = $request_data['is_main'];
                }
                else
                {
                    $result['messages'][] = 'Error creating main user address';
                    return $result;
                }
            }
            else
            {
                $this->is_main = $request_data['is_main'];
            }
        }

        if($this->save())
        {
            $result['code'] = 1;
            $result['created_address'] = $this;
        }
        else
        {
            $result['messages'] = $this->getMessages();
        }

        return $result;
    }

    public static function setMain($address_id)
    {
        $result['code']            = 0;
        $result['messages']        = [];
        $result['updated_address'] = '';

        $address = static::findFirst($address_id);

        $main_addresses = static::getMainAddresses();

        if(count($main_addresses))
        {
            if(static::makeNotMain($main_addresses))
            {
                $address->is_main = 1;
            }
            else
            {
                $result['messages'][] = 'Error setting main address';
                return $result;
            }
        }
       else
       {
           $address->is_main = 1;
       }

        if($address->save())
        {
            $result['code'] = 1;
            $result['updated_address'] = $address;
        }
        else
        {
            $result['messages'] = $address->getMessages();
        }

        return $result;
    }

    public static function deleteAddress($address_id)
    {
        $result['code'] = 0;
        $result['messages'] = [];

        $address = static::findFirst($address_id);

        if($address)
        {
            if(static::isMain($address))
            {
                $result['messages'][] = 'You can\'t delete a main address';
            }
            else
            {
                if($address->delete())
                {
                    $result['code'] = 1;
                }
                else
                {
                    $result['messages'] = $address->getMessages();
                }
            }
        }
        else
        {
            $result['messages'][] = 'address doesn\'t exist';
        }

        return $result;
    }

    public static function isMain($address)
    {
        return ($address->is_main == 1)?true:false;
    }

    public static function updateAddress($address, $request_data)
    {
        $result['code']            = 0;
        $result['messages']        = [];
        $result['updated_address'] = '';

        $address->country_id  = $request_data['country_id'];
        $address->city_id     = $request_data['city_id'];
        $address->region_id   = $request_data['region_id'];
        $address->details     = $request_data['details'];
        $address->postal_code = $request_data['postal_code'];

        if(isset($request_data['is_main']) && $request_data['is_main'] == 1)
        {
            $main_addresses = static::getMainAddresses();

            if(count($main_addresses))
            {
                if(!static::makeNotMain($main_addresses))
                {
                    $result['messages'][] = 'Error creating main user address';
                    return $result;
                }
            }

            $address->is_main = $request_data['is_main'];
        }

        if($address->save())
        {
            $result['code'] = 1;
            $result['updated_address'] = $address;
        }
        else
        {
            $result['messages'] = $address->getMessages();
        }

        return $result;
    }
}