<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 7/9/2018
 * Time: 11:19 AM
 */

namespace Vokuro\Cms\Services;
use Models\SalesVisits;
use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;

class SalesVisitsService extends Component
{
    public function sales_rep_stats($mission_type_id,$sales_rep_id,$date){
        $builder = $this->modelsManager->createBuilder()->from(SalesVisits::class);
        $builder->columns(
            [
                "id" => "COUNT(*)",
            ]
        );
        $builder->andWhere("Models\SalesVisits.sales_person={$sales_rep_id}");
        $builder->andWhere("Models\SalesVisits.mission_type_id={$mission_type_id}");
        if($date["from"]!=null && $date["to"]!=null){
            $builder->betweenWhere("Models\SalesVisits.created_at", $this->stat_date_format($date["from"]), $this->stat_date_format($date["to"]));
        }
        $result = $builder->getQuery()->execute();
        return $result;

    }

    private function stat_date_format($date){
        $dateobj = \DateTime::createFromFormat("Y-m-d", $date);
        $timestamp = $dateobj->getTimestamp();
        return $timestamp;
    }
}