<?php
namespace Vokuro\Models;

use Phalcon\Mvc\Model;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;


class TanksMostSellingProducts extends Model
{
    public function getSource()
    {
        return 'tanks_most_selling_products';
    }
}