<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/21/2017
 * Time: 2:14 PM
 */

namespace Vokuro\Cart\Models;


use Models\Content;
use Phalcon\Mvc\Model;
use Vokuro\Offers\Models\Offers;

class OrderItems extends Model
{
    public $id;
    public $order_id;
    public $item_type_id;
    public $item_id;
    public $date;
    public $application_id;
    public $module_id;
    public $cost;
    public $count;
    public $updated_at;
    public $color;
    public $delivery_place;

    public function getSource()
    {
        return 'data_cms_orders_purchase';
    }

    public function initialize()
    {
        $this->belongsTo(
            'order_id',
            Orders::class,
            'id',
            [
                'alias' => 'order',
            ]
        );

        $this->belongsTo(
            'item_type_id',
            OrderItemTypes::class,
            'id',
            [
                'alias' => 'type'
            ]
        );

        $this->belongsTo(
            'item_id',
            Content::class,
            'ID',
            [
                'conditions' => 'item_type_id = 1',
                'alias'      => 'cmsDetails'
            ]
        );

        $this->belongsTo(
            'item_id',
            Offers::class,
            'id',
            [
                'conditions' => 'item_type_id = 2',
                'alias'      => 'offerDetails'
            ]
        );

        $this->belongsTo(
            'color',
            \Vokuro\Models\SetupColors::class,
            'id',
            [
            'alias' => 'productColor'
            ]
        );

        $this->belongsTo(
            'delivery_place',
            \Vokuro\Models\CompanyBranches::class,
            'id',
            [
            'alias' => 'deliveryPlace'
            ]
        );
    }
}