<?php

/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 7/8/2018
 * Time: 7:38 PM
 */
namespace Vokuro\SalesVisits\Models;
use Phalcon\Mvc\Model;

class TanksSalesRepsClients extends Model
{
    public function getSource()
    {
        return 'tanks_sales_reps_clients';
    }
    public function initialize() {
        $this->belongsTo(
            "sales_rep_id",
            'Models\UsersMobile',
            "ID",
            [
                'alias' => 'SalesPerson',
                'reusable' => true
            ]
        );
    }
}