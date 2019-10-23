<?php
namespace Vokuro\Cms\Services;

use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoStates;
use Vokuro\Maintenance\Models\TicketProblemDetails;
use Vokuro\Maintenance\Models\TicketProblems;
use Vokuro\Models\CompanyBranches;
use Models\UserCategories;

class ClientCatsService extends Component{

    public function getClientCats($search_param){
        $builder = $this->modelsManager->createBuilder()
            ->from("Models\UserCategories");
        if(isset($search_param["id"])){
            if($search_param["id"]!="all"){
                $builder->andWhere("Models\UserCategories.id ={$search_param["id"]}");
            }

        }

       $builder->orderBy("Models\UserCategories.id DESC");
        $page = 1;
        if(isset($search_param["page"])){
            $page = $search_param["page"];
        }
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit" => 10,
                "page" => $page,
            ]
        );
        $result= $this->getPaginationInfo($paginator);
        return $result;

    }
    public function getAllClientCats(){
        $clients_cats = UserCategories::find();
        $result = $clients_cats->toArray();
        return $result;

    }
    public function addCat($cat_info){
        $rule = new UserCategories();
        $rule->name = $cat_info["name"];
        $rule->application_id = 1;
        if(!$rule->save()){
            return "error";
        }
        //$branch->save();
        return $rule->toArray();
    }
    public function deleteCat($cat_info){
        $branch = UserCategories::findFirst(["conditions" => "id = ?1",
            "bind"       => [
                1 => $cat_info["id"],
            ]
        ]);
        if($branch){
            $branch->delete();
        }
        return true;
    }
    public function getRegions($city_id){
        $regions = GeoRegions::find(["conditions" => "city_id = ?1",
            "bind"       => [
                1 => $city_id,
            ]
        ]);

        return $regions;
    }
    public function getCities(){
        $cities = GeoCities::find();
        return $cities;
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