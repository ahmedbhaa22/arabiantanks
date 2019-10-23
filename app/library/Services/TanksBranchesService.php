<?php
namespace Vokuro\Services;

use Models\TanksCities;
use Models\TanksRegions;
use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Models\CompanyBranches;
use Vokuro\Models\SetupEntityLanguages;


class TanksBranchesService extends Component{
    public function getRegions(){
        $regions = TanksRegions::find();
        return $regions;
    }

    public function getCitiesByRegion($region_id){
        $cities = TanksCities::find([
            "region_id = {$region_id}"
        ]);
        return $cities;
    }
    public function getBranches($search_param){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Models\CompanyBranches");
        $page = 1;
        if(isset($search_param["page"])){
            $page = $search_param["page"];
        }
        if(isset($search_param["city_id"])){
            if($search_param["city_id"]!="all"){
                $builder->andWhere("Vokuro\Models\CompanyBranches.city_id ={$search_param["city_id"]}");
            }

        }
        if(isset($search_param["region_id"])){
            if($search_param["region_id"]!="all"){
                $builder->andWhere("Vokuro\Models\CompanyBranches.region_id ={$search_param["region_id"]}");
            }

        }
        $builder->orderBy("Vokuro\Models\CompanyBranches.id DESC");
        $paginator  = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit" => 10,
                "page" => $page,
            ]
        );
        $result= $this->getPaginationInfo($paginator);
        return $result;
    }

    public function addBranch($branch_info){
        $branch = new CompanyBranches();
        $branch->address = "Test";
        $branch->lat = 00;
        $branch->long = 00;
        $branch->company_id = 1;
        $branch->name = $branch_info["name"];
        $branch->region_id = $branch_info["region_id"];
        $branch->city_id = $branch_info["city_id"];
        if(!$branch->save()){
            return "error";
        }
        // lang
        $setup_ent_lang = new SetupEntityLanguages();
        $setup_ent_lang->item_id= $branch->id;
        $setup_ent_lang->lang_id=2;
        $setup_ent_lang->entity_id=21;
        $setup_ent_lang->application_id=1;
        $setup_ent_lang->translation = $branch_info["name_eng"];
        $setup_ent_lang->save();
        //$branch->save();
        return $branch->toArray();
    }
    public function getBranchesByRegion($region_id){
        $branches = CompanyBranches::find(["region_id={$region_id}"]);
        $result["items"] =[];
        foreach ($branches as $info){
            $row= $info->toArray();
            $row['branch_region_name']=$info->region->name;
            $row['branch_city_name']=$info->region->city->name;
            $row['branch_city_id']=$info->region->city->id;
            $result["items"][] = $row;
            $row=[];
        }
        return $result;
    }
    public function getPaginationInfo(PaginatorQueryBuilder $paginator){
        $result = [];
        $result["items"] =[];
        foreach ($paginator->getPaginate()->items as $info){
            $row= $info->toArray();
            $row['branch_region_name']=$info->tanks_region->name;
            $row['branch_city_name']=$info->tanks_city->name;
            $row['branch_city_id']=$info->city_id;
            $row['name_eng']=$info->english->translation;
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