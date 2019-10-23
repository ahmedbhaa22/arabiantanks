<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 12:01 PM
 */

namespace Vokuro\Offers\Models;


use Phalcon\Mvc\Model;

class OfferRelItems extends Model
{
    public $id;
    public $offer_id;
    public $data_cms_id;
    public $created_at;
    public $updated_at;

    public function getSource()
    {
        return 'offer_rel_items';
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