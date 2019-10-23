<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 5/27/2018
 * Time: 11:35 AM
 */

namespace Vokuro\Offers\Models;
use Phalcon\Mvc\Model;
use Vokuro\Offers\Models\Offers;


class OffersLang extends Model
{
    public function getSource()
    {
        return 'offers_lang';
    }
    public function initialize()
    {
        $this->belongsTo(
            'offer_id',
            Offers::class,
            'id',
            [
                'alias' => 'offer'
            ]
        );
    }
}