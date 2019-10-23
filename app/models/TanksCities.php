<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;



class TanksCities extends Model
{
    public function getSource()
    {
        return 'tanks_cities';
    }
    public function initialize()
    {

    }
}