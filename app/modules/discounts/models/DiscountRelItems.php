<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 1:53 PM
 */

namespace Vokuro\Discounts\Models;


use Phalcon\Mvc\Model;

class DiscountRelItems extends Model
{
    public $id;
    public $discount_id;
    public $data_cms_id;
    public $created_at;
    public $updated_at;

    public function getSource()
    {
        return 'discount_rel_items';
    }
    public function initialize()
    {

        $this->belongsTo(
            "data_cms_id",
            'Models\Content',
            "ID",
            [
                'alias' => 'Content',
                'reusable' => true
            ]
        );
    }
}