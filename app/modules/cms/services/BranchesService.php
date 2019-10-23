<?php
namespace Vokuro\Cms\Services;

use Models\TanksCities;
use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoStates;
use Vokuro\Maintenance\Models\TicketProblemDetails;
use Vokuro\Maintenance\Models\TicketProblems;
use Vokuro\Models\CompanyBranches;
use Vokuro\Models\SetupEntityLanguages;

class BranchesService extends Component{

    public function getRegions($city_id){
        $regions = GeoRegions::find(["conditions" => "city_id = ?1",
            "bind"       => [
                1 => $city_id,
            ]
        ]);
        return $regions;
    }
    public function getRegionsInCities($cities){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Geo\Models\GeoRegions")->inWhere("city_id", $cities);

        $regions = $builder->getQuery()->execute();
        return $regions;
    }
    public function getCities(){
        $cities = TanksCities::find();
        return $cities;
    }
    public function getBranches($search_param){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Models\CompanyBranches");
        $page = 1;
        if(isset($search_param["page"])){
            $page = $search_param["page"];
        }
        if(isset($search_param["region_id"])){
            if($search_param["region_id"]!="all"){
                $builder->andWhere("Vokuro\Models\CompanyBranches.region_id ={$search_param["region_id"]}");
            }else{
                $builder->leftJoin("Vokuro\Geo\Models\GeoRegions", "Vokuro\Geo\Models\GeoRegions.id = Vokuro\Models\CompanyBranches.region_id");
                $builder->andWhere("Vokuro\Geo\Models\GeoRegions.city_id ={$search_param["city_id"]}");
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
//        $branches_query = CompanyBranches::find(["company_id=1"]);
//        $branches =[];
//        foreach ($branches_query as $item){
//            $row['branch_id']=$item->id;
//            $row['name']=$item->name;
//            $row['branch_region_id']=$item->region_id;
//            $row['branch_region_name']=$item->region->name;
//            $row['branch_city_name']=$item->region->city->id;
//            $row['branch_city_id']=$item->region->city->name;
//            $branches[]=$row;
//        }
//        return $branches;
    }

    public function getAllBranchesByCity($search_param){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Models\CompanyBranches");
        $builder->leftJoin("Vokuro\Geo\Models\GeoRegions", "Vokuro\Geo\Models\GeoRegions.id = Vokuro\Models\CompanyBranches.region_id");
        $builder->andWhere("Vokuro\Geo\Models\GeoRegions.city_id ={$search_param["city_id"]}");
        $builder->orderBy("Vokuro\Models\CompanyBranches.id DESC");
        $branches = $builder->getQuery()->execute();
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
    public function addBranch($branch_info){
        $branch = new CompanyBranches();
        $branch->address = "Test";
        $branch->lat = 00;
        $branch->long = 00;
        $branch->company_id = 1;
        $branch->name = $branch_info["name"];
        $branch->region_id = $branch_info["region_id"];
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

    public function deleteBranch($branch_info){
        $branch = CompanyBranches::findFirst(["conditions" => "id = ?1",
            "bind"       => [
                1 => $branch_info["id"],
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
            $row['branch_region_name']=$info->region->name;
            $row['branch_city_name']=$info->region->city->name;
            $row['branch_city_id']=$info->region->city->id;
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
    public function getAllBranches(){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Models\CompanyBranches");
        $branches =$builder->getQuery()
            ->execute();
        $result =[];
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
    public function getAllBranchesByCityAndReg($search_param){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Models\CompanyBranches");

        if(isset($search_param["region_id"])){
            if($search_param["region_id"]!="all"){
                $builder->andWhere("Vokuro\Models\CompanyBranches.region_id ={$search_param["region_id"]}");
            }else{
                $builder->leftJoin("Vokuro\Geo\Models\GeoRegions", "Vokuro\Geo\Models\GeoRegions.id = Vokuro\Models\CompanyBranches.region_id");
                $builder->andWhere("Vokuro\Geo\Models\GeoRegions.city_id ={$search_param["city_id"]}");
            }

        }
        $builder->orderBy("Vokuro\Models\CompanyBranches.id DESC");
        $branches = $builder->getQuery()->execute();
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

    public function getTechInBranch($search_param){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Models\UsersUsersRules")
            ->leftJoin("Vokuro\UsersModule\Models\UserData", "Vokuro\UsersModule\Models\UserData.user_id = Vokuro\Models\UsersUsersRules.user_id")
            ->andWhere("Vokuro\UsersModule\Models\UserData.branch_id={$search_param['branch_id']}")
        ;
        $techs = $builder->getQuery()->execute();
        $result["items"] =[];
        foreach ($techs as $info){
            if(!$info->getUser()){
                continue;
            }
            $row= $info->user->toArray();
            $result["items"][] = $row;
            $row=[];
        }
        return $result;
    }
}