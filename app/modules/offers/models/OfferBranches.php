<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 12:06 PM
 */

namespace Vokuro\Offers\Models;


use Phalcon\Mvc\Model;

class OfferBranches extends Model
{
    public $id;
    public $offer_id;
    public $branch_id;
    public $created_at;
    public $updated_at;

    public function getSource()
    {
      return 'offer_delivery_places';
    }
}