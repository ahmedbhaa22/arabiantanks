<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 11:55 AM
 */

namespace Vokuro\Offers\Models;


use Phalcon\Mvc\Model;

class OfferTypes extends Model
{
    public $id;
    public $name;
    public $created_at;
    public $updated_at;

    public function getSource()
    {
        return 'offer_types';
    }

    public function initialize()
    {
        $this->hasManyToMany(
            'id',
            OfferRelTypes::class,
            'type_id', 'offer_id',
            Offers::class,
            'id'
        );
    }

    public static function untilFinished()
    {
        return static::findFirst(["name = 'Until Finished'"])->id;
    }

    public static function limitedPeriod()
    {
        return static::findFirst(["name = 'Limited Period'"])->id;
    }
}