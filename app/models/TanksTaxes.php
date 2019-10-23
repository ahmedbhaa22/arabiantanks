<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;



class TanksTaxes extends Model
{
    public function getSource()
    {
        return 'tanks_taxes';
    }
    public function initialize()
    {

    }
}