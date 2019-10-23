<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 1:51 PM
 */

namespace Vokuro\Discounts\Models;


use Models\Content;
use Phalcon\Mvc\Model;

class Discounts extends Model
{
    private static $di;
    private static $accessible_vars = [
        'id',
        'name',
        'percentage',
        'coupon',
        'start_date',
        'end_date',
        'active',
        'created_at',
        'updated_at'
    ];
    public $id;
    public $name;
    public $percentage;
    public $coupon;
    public $start_date;
    public $end_date;
    public $category_id;
    public $active;
    public $created_at;
    public $updated_at;

    public function getSource()
    {
        return 'discounts';
    }

    public function initialize()
    {
        $this->hasManyToMany(
            'id',
            DiscountRelItems::class,
            'discount_id', 'data_cms_id',
            Content::class,
            'ID',
            [
                'alias' => 'products'
            ]
        );

        $this->belongsTo(
            "category_id",
            \DataCmsDeptsRel::class,
            "id",
            [
                "alias" => "category"
            ]
        );
    }

    public static function getDetailed()
    {
        $result         = [];

        foreach(self::find() as $discount)
        {
            $discount_model = [];

            foreach(static::$accessible_vars as $var)
            {
                $discount_model[$var] = $discount->{$var};
            }

            $discount_model['products'] = $discount->products;

            $result[] = $discount_model;
        }

        return $result;
    }

    public function getStartDate()
    {
        return date('d/m/Y', $this->start_date);
    }

    public function getEndDate()
    {
        return date('d/m/Y', $this->end_date);
    }

    public function dateFieldStartDate()
    {
        return date('Y-m-d', $this->start_date);
    }

    public function dateFieldEndDate()
    {
        return date('Y-m-d', $this->end_date);
    }
}