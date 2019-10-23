<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;



class TanksRegions extends Model
{
    public function getSource()
    {
        return 'tanks_regions';
    }
    public function initialize()
    {

    }
}