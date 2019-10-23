<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;



class TanksCountries extends Model
{
    public function getSource()
    {
        return 'tanks_countries';
    }
    public function initialize()
    {

    }
}