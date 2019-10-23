<?php
namespace Vokuro\Cms\Services;

use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Models\MaintenancePendingReqReasons;

class PendReqReasonsSerivce extends Component{

    public function getReasons($search_param){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Maintenance\Models\MaintenancePendingReqReasons");

        $page = 1;
        if(isset($search_param["page"])){
            $page = $search_param["page"];
        }
        if(isset($search_param["id"])){
            $builder->andWhere("Vokuro\Maintenance\Models\MaintenancePendingReqReasons.id ={$search_param["id"]}");
        }
        $builder->orderBy("Vokuro\Maintenance\Models\MaintenancePendingReqReasons.id DESC");
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit" => 5,
                "page" => $page,
            ]
        );
        $result= $this->getPaginationInfo($paginator);
        return $result;

    }
    public function getAllReasons(){
        $reasons = MaintenancePendingReqReasons::find();
        $result = $reasons->toArray();
        return $result;
    }
    public function addReason($reason_info){
        $reason = new MaintenancePendingReqReasons();
        $reason->reason_title = $reason_info["reason_title"];
        if(!$reason->save()){
            return "error";
        }
        //$branch->save();
        return $reason->toArray();
    }
    public function deleteReason($reason_info){
        $branch = MaintenancePendingReqReasons::findFirst(["conditions" => "id = ?1",
            "bind"       => [
                1 => $reason_info["id"],
            ]
        ]);
        if($branch){
            $branch->delete();
        }
        return true;
    }
    public function getPaginationInfo(PaginatorQueryBuilder $paginator){
        $result = [];
        $result["items"] =[];
        foreach ($paginator->getPaginate()->items as $info){
            $row= $info->toArray();
            $result["items"][] = $row;
            $row=[];
        }
        //$result["items"] = $paginator->getPaginate()->items->toArray();
        $result["before"] = $paginator->getPaginate()->before;
        $result["next"] = $paginator->getPaginate()->next;
        $result["last"] = $paginator->getPaginate()->last;
        $result["total_pages"] = $paginator->getPaginate()->total_pages;
        $result["current"] = $paginator->getPaginate()->current;
        $result["total_items"]=$paginator->getPaginate()->total_items;
        return $result;
    }

}