<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;



class TanksPollsVisits extends Model
{
    public function getSource()
    {
        return 'tanks_polls_visits';
    }
    public function initialize()
    {
        $this->belongsTo(
            "visit_id",
            'Models\SalesVisits',
            "id",
            [
                'alias' => 'VisitDetails',
                'reusable' => true
            ]
        );
    }
}