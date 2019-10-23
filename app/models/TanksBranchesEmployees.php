<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;



class TanksBranchesEmployees extends Model
{
    public function getSource()
    {
        return 'tanks_branches_employees';
    }
    public function initialize()
    {

    }
}