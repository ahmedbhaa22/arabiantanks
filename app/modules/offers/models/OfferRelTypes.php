<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 11:59 AM
 */

namespace Vokuro\Offers\Models;


use Phalcon\Mvc\Model;

class OfferRelTypes extends Model
{
    public $id;
    public $offer_id;
    public $type_id;
    public $start_date;
    public $end_date;
    public $created_at;
    public $updated_at;

    public function getSource()
    {
        return 'offer_rel_types';
    }
}