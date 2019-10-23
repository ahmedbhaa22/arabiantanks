<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 11:52 AM
 */

namespace Vokuro\Offers\Models;


use Models\Content;
use Models\TanksRegions;
use Phalcon\Mvc\Model;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Offers\Models\OffersLang;

class Offers extends Model
{
    private static $accessible_vars = [
        'id',
        'name',
        'image',
        'discount_percent',
        'products_number',
        'max_purchase_number',
        'description',
        'show_in_homepage',
        'price',
        'original_price',
        'active',
        'created_at',
        'updated_at'
    ];
    public $id;
    public $name;
    public $image;
    public $discount_percent;
    public $products_number;
    public $max_purchase_number;
    public $description;
    public $show_in_homepage;
    public $price;
    public $original_price;
    public $active;
    public $created_at;
    public $updated_at;

    public function getSource()
    {
        return 'offers';
    }

    public function initialize()
    {
        $this->hasManyToMany(
            'id',
            OfferRelTypes::class,
            'offer_id', 'type_id',
            OfferTypes::class,
            'id',
            [
                'alias' => 'types'
            ]
        );

        $this->hasManyToMany(
            'id',
            OfferRelItems::class,
            'offer_id', 'data_cms_id',
            Content::class,
            'ID',
            [
                'alias' => 'products'
            ]
        );

        $this->hasManyToMany(
            'id',
            OfferRegions::class,
            'offer_id', 'region_id',
            TanksRegions::class,
            'id',
            [
                'alias' => 'regions'
            ]
        );

        $this->hasMany(
            'id',
            OfferRelTypes::class,
            'offer_id',
            [
                'alias' => 'offer_types'
            ]
        );
        $this->belongsTo(
            'id',
            OffersLang::class,
            'offer_id',
            [
                'alias' => 'lang'
            ]
        );

    }

    public static function getDetailed($offer_id, $region_id, $base_uri, $upload_location, $homepage=null,$lang_id)
    {

        $result = [];
        $offers = null;

        if($offer_id!=null)
        {

            $offers = static::find([
                "id = {$offer_id} and active = 1"]);

        }
        else
        {
            if(isset($homepage) && $homepage == 1)
            {
                $offers = static::find([
                    'active = 1 and show_in_homepage = 1'
                ]);
            }
            else
            {
              $offers = static::find([
                  'active = 1'
              ]);
            }
        }


        foreach($offers as $offer)
        {


            $offer_model = [];

            if(isset($region_id) && !isset($offer_id))
            {
                if(!static::filterOfferByRegion($offer, $region_id))
                {

                    continue;
                }
            }


            $offer_model['id']          = $offer->id;
            $offer_model['name']        = $offer->name;
            $offer_model['image']       = $base_uri.$upload_location.$offer->image;
            $offer_model['description'] = $offer->description;
            $offer_model['content']     = '';
            $offer_model['created_at']  = $offer->created_at;
            $offer_model['duration']    = '';
            $offer_model['visit_num']   = '';
            $offer_model['order']       = '';
            $offer_model['link_share']  = '';
            $offer_model['price']       = $offer->price;
            $offer_model['product_type']       = 2;
            if(isset($_GET["mobile"])){
                $offer_model['more']        = static::getOfferMoreMobile($offer, $offer->id, $base_uri);
            }else{
                $offer_model['more']        = static::getOfferMore($offer, $offer->id, $base_uri);
            }

            $offer_model['media']       = [];

            $offer_model['settings']       = [];

            if($lang_id==2){
                $offer_model['name']        = $offer->lang->name ?: $offer->name;
                $offer_model['image']       = $base_uri.$upload_location.$offer->lang->img ?: $base_uri.$upload_location.$offer->image;
                $offer_model['description'] = $offer->lang->description ?: $offer->description;
            }

            $result[] = $offer_model;
        }

        return $result;
    }

    private static function getOfferMore($offer, $offer_id, $base_uri)
    {
        $more = [];

        $more_keys = ['branch_id', 'types', 'keyvalue', 'actions', 'type_id','extra'];

        foreach($more_keys as $key)
        {
            switch($key)
            {
                case 'branch_id':
                    $offer_more_model['key'] = '';
                    $offer_more_model['group_name'] = '';
                    $offer_more_model['value'] = [];

                    $offer_more_model['key']        = $key;
                    $offer_more_model['group_name'] = 'Branches';
                    $offer_more_model['value']      = static::structureOfferRegions($offer);

                    $more[] = $offer_more_model;
                    break;
                case 'types':
                    $offer_more_model['key'] = '';
                    $offer_more_model['group_name'] = '';
                    $offer_more_model['value'] = [];

                    $offer_more_model['key']        = $key;
                    $offer_more_model['group_name'] = 'Offer Types';
                    $offer_more_model['value']      = static::structureOfferTypes($offer);

                    $more[] = $offer_more_model;
                    break;
                case 'keyvalue':
                    $offer_more_model['key'] = '';
                    $offer_more_model['group_name'] = '';
                    $offer_more_model['value'] = [];

                    $offer_more_model['key']        = $key;
                    $offer_more_model['group_name'] = 'Key Value Fields';
                    $offer_more_model['value']      = static::structureOfferKeyValue($offer);

                    $more[] = $offer_more_model;
                    break;
                case 'actions':
                    $offer_more_model['key'] = '';
                    $offer_more_model['group_name'] = '';
                    $offer_more_model['value'] = [];

                    if(!isset($offer_id))
                    {
                        $offer_more_model['key']        = $key;
                        $offer_more_model['group_name'] = 'Actions';
                        $offer_more_model['value'][] = ["parameter"=>"view", "value"=>$base_uri.'offers_module/apis/get/'.$offer->id];

                        $more[] = $offer_more_model;
                    }
                    break;
                case 'extra':
                    $offer_more_model['key'] = 'extra';
                    $offer_more_model['group_name'] = 'Extra Fields';
                    $offer_more_model['value'][] = ["parameter"=>"price", "value"=>$offer->price,"name"=>"price"];
                    $more[] = $offer_more_model;
                    break;
                case 'item_type':
                    $offer_more_model['key']        = $key;
                    $offer_more_model['group_name'] = 'Item Type';
                    $offer_more_model['value'][]    = ["type_id"=>2];

                    $more[] = $offer_more_model;
                    break;
            }
        }

        return $more;
    }

    public static function structureOfferRegions($offer)
    {
        $structured_regions        = [];
        $region_model_container    = [];
        $region_model['parameter'] = '';
        $region_model['value']     = '';

        $regions = $offer->regions;

        if(count($regions))
        {
            foreach($regions->toArray() as $region)
            {
                foreach($region as $k=>$v)
                {
                    if($k == 'id' || $k == 'name')
                    {
                        $region_model['parameter'] = $k;
                        $region_model['value']     = $v;
                        $region_model_container[] = $region_model;
                    }
                }

                $structured_regions[] = $region_model_container;
                $region_model_container = [];
            }
        }

        return $structured_regions;
    }

    public static function structureOfferTypes($offer)
    {
        $structured_types = [];
        $type_model_container = [];
        $type_model['parameter'] = '';
        $type_model['value']     = '';

        $types = $offer->types;

        if(count($types))
        {
            foreach($types->toArray() as $type)
            {
                foreach($type as $k=>$v)
                {
                    if($k === 'id' || $k === 'name')
                    {
                        $type_model['parameter'] = $k;
                        $type_model['value'] = $v;
                        $type_model_container[] = $type_model;
                    }
                }

                $structured_types[] = $type_model_container;
                $type_model_container = [];
            }
        }

        return $structured_types;
    }

    public static function structureOfferKeyValue($offer)
    {
        $keyvalue_fields = ['discount_percent','products_number','max_purchase_number','show_in_homepage','price',
        'original_price','active','updated_at'];

        $structured_keyvalues = [];

        $kv_model['id']         = '';
        $kv_model['paramter']   = '';
        $kv_model['value']      = [];
        $kv_model['dkv_id']     = '';
        $kv_model['setting_id'] = '';

        foreach($offer->toArray() as $k=>$v)
        {
            if(in_array($k, $keyvalue_fields))
            {
                $kv_model['paramter'] = $k;
                $kv_model['value'][]    = ['value_id' => '' , 'value_title' => $v];
                $structured_keyvalues[] = $kv_model;

                $kv_model['paramter']   = '';
                $kv_model['value']      = [];
            }
        }

        $offer_rel_types = OfferRelTypes::find([
            'offer_id = {offer}',
            'bind' => [
                'offer' => $offer->id
            ]
        ]);

        foreach($offer_rel_types as $offer_rel_type)
        {
            if($offer_rel_type->type_id == 2)
            {
                $kv_model['paramter'] = 'start_date';
                $kv_model['value'][]    = ['value_id'=>'', 'value_title'=>$offer_rel_type->start_date];
                $structured_keyvalues[] = $kv_model;

                $kv_model['paramter']   = '';
                $kv_model['value']      = [];

                $kv_model['paramter'] = 'end_date';
                $kv_model['value'][]    = ['value_id'=>'', 'value_title'=>$offer_rel_type->end_date];
                $structured_keyvalues[] = $kv_model;
                $kv_model['paramter']   = '';
                $kv_model['value']      = [];
            }
        }

        return $structured_keyvalues;
    }

    public static function filterOfferByRegion($offer, $region_id)
    {
        $result = false;
        $offer_regions_ids = [];

        foreach($offer->regions as $offer_region)
        {
            $offer_regions_ids[] = $offer_region->id;
        }

        if(in_array($region_id, $offer_regions_ids))
        {
            $result = true;
        }

        return $result;
    }

    public function getStartEndDates()
    {
        $details = OfferRelTypes::findFirst([
            'offer_id = :offer_id: and type_id = :type_id:',
            'bind' => [
                'offer_id' => $this->id,
                'type_id'  => OfferTypes::limitedPeriod()
            ]
            ]);

        return ' From: ' . date('d/m/Y', $details->start_date) . ' To: ' . date('d/m/Y', $details->end_date);
    }


    //Because Mobile is Diffrenet From Web
    private static function getOfferMoreMobile($offer, $offer_id, $base_uri) {
        $more = [];
        $more_keys = ['branch_id', 'types', 'keyvalue', 'actions', 'type_id'];
        foreach($more_keys as $key) {
            switch($key) {
                case 'branch_id':
//                    $offer_more_model['key'] = '';
//                    $offer_more_model['group_name'] = '';
//                    $offer_more_model['value'] = [];
//
//                    $offer_more_model['key']        = $key;
//                    $offer_more_model['group_name'] = 'Branches';
//                    $offer_more_model['value']      = static::structureOfferRegionsMobile($offer);
//
//                    $more[] = $offer_more_model;
                    break;
                case 'types':
                    $offer_more_model['key'] = '';
                    $offer_more_model['group_name'] = '';
                    $offer_more_model['value'] = [];

                    $offer_more_model['key']        = $key;
                    $offer_more_model['group_name'] = 'Offer Types';
                    $offer_more_model['value']      = static::structureOfferTypesMobile($offer);

                    $more[] = $offer_more_model;
                    break;
                case 'keyvalue':
                    $offer_more_model['key'] = '';
                    $offer_more_model['group_name'] = '';
                    $offer_more_model['value'] = [];

                    $offer_more_model['key']        = $key;
                    $offer_more_model['group_name'] = 'Key Value Fields';
                    $offer_more_model['value']      = static::structureOfferKeyValueMobile($offer);

                    $more[] = $offer_more_model;
                    break;
                case 'actions':
                    $offer_more_model['key'] = '';
                    $offer_more_model['group_name'] = '';
                    $offer_more_model['value'] = [];

                    if(!isset($offer_id))
                    {
                        $offer_more_model['key']        = $key;
                        $offer_more_model['group_name'] = 'Actions';
                        $offer_more_model['value'][] = array(
                            "parameter"=>"view",
                            "value" => array(
                                'value' => array(
                                    'value_type' => 'normal',
                                    'value_string' => $base_uri.'offers_module/apis/get/'.$offer->id
                                )
                            )
                        );

                        $more[] = $offer_more_model;
                    }
                    break;
                case 'item_type':
                    $offer_more_model['key']        = $key;
                    $offer_more_model['group_name'] = 'Item Type';
                    $offer_more_model['value'][]    = ["type_id"=>2];

                    $more[] = $offer_more_model;
                    break;
            }
        }

        return $more;
    }

    //Because Mobile is Diffrenet From Web
    public static function structureOfferRegionsMobile($offer) {
        $structured_regions        = [];
        $region_model_container    = [];
        $region_model['parameter'] = '';
        $region_model['value']     = '';
        $regions = $offer->regions;
        if(count($regions)) {
            foreach($regions->toArray() as $region) {
                $region_model['value']     = array(
                    'value_type' => 'object',
                    'value_obj' => array(
                        'value_id' => $region['id'],
                        'value_title' => $region['name']
                    ));
                $region_model_container = $region_model;
                $structured_regions[] = $region_model_container;
            }
        }
        return $structured_regions;
    }

    //Because Mobile is Diffrenet From Web
    public static function structureOfferTypesMobile($offer) {
        $structured_types = [];
        $type_model_container = [];
        $type_model['parameter'] = '';
        $type_model['value']     = '';
        $types = $offer->types;
        if(count($types)) {
            foreach($types->toArray() as $type) {
                $type_model['value']     = array(
                    'value_type' => 'object',
                    'value_obj' => array(
                        'value_id' => $type['id'],
                        'value_title' => $type['name']
                    ));
                $type_model_container = $type_model;
                $structured_types[] = $type_model_container;
            }
        }
        return $structured_types;
    }

    //Because Mobile is Diffrenet From Web
    public static function structureOfferKeyValueMobile($offer) {
        $keyvalue_fields = ['discount_percent','products_number','max_purchase_number','show_in_homepage','price',
            'original_price','active','updated_at'];

        $structured_keyvalues = [];
        $kv_model['id']         = '';
        $kv_model['parameter']   = '';
        $kv_model['value']      = [];
        $kv_model['dkv_id']     = '';
        $kv_model['setting_id'] = '';

        foreach($offer->toArray() as $k => $v) {
            if(in_array($k, $keyvalue_fields)) {
                $kv_model['parameter'] = $k;
                $kv_model['value']    = array('value_type' => 'normal', 'value_string' => $v);

                $structured_keyvalues[] = $kv_model;
                $kv_model['parameter']   = '';
                $kv_model['value']      = [];
            }
        }

        $offer_rel_types = OfferRelTypes::find([
            'offer_id = {offer}',
            'bind' => [
                'offer' => $offer->id
            ]
        ]);

        foreach($offer_rel_types as $offer_rel_type)
        {
            if($offer_rel_type->type_id == 2)
            {
                $kv_model['parameter'] = 'start_date';
                $kv_model['value']    = array(
                    'value' => array('value_type' => 'normal', 'value_string' => $offer_rel_type->start_date)
                );
                $structured_keyvalues[] = $kv_model;

                $kv_model['parameter']   = '';
                $kv_model['value']      = [];

                $kv_model['parameter'] = 'end_date';
                $kv_model['value']    = array(
                    'value' => array('value_type' => 'normal', 'value_string' => $offer_rel_type->end_date)
                );
                $structured_keyvalues[] = $kv_model;
                $kv_model['parameter']   = '';
                $kv_model['value']      = [];
            }
        }

        return $structured_keyvalues;
    }


}