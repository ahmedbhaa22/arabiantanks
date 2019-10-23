<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/24/2017
 * Time: 12:41 PM
 */

namespace Vokuro\Models;


use Models\Content;
use Phalcon\Mvc\Model;

class ProductExtraFields extends Model
{
    public $id;
    public $module_id;
    public $item_id;
    public $price;
    public $old_price;
    public $cost;
    public $free_shipping;
    public $shipping_fee;
    public $minimum_in_cart;
    public $maximum_in_cart;

    public function getSource()
    {
        return 'product_extra_fields';
    }

    public function initialize()
    {
        $this->belongsTo(
            'module_id',
            \UsersApplicationModule::class,
            'ID',
            [
                'alias' => 'module'
            ]
        );

        $this->belongsTo(
            'item_id',
            Content::class,
            'ID',
            [
                'alias' => 'product'
            ]
        );
    }
    public function returnExtra(){
        $metadata = $this->getModelsMetaData();
        $attributes = $metadata->getAttributes($this);
        foreach($attributes as $k=>$v){
            if (in_array($v,array('id','module_id','item_id'))) unset($attributes[$k]);
        }
        return $attributes;
    }
}