<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 12/18/2017
 * Time: 11:31 AM
 */
namespace Vokuro\Maintenance\Services;

use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Models\TicketProblemDetails;
use Vokuro\Maintenance\Models\TicketProblems;

class ProblemsApi extends Component{
    public $page=1;
    public function __construct($page=1)
    {
        $this->page = $page;
    }

    public function search($search_param=null){
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Maintenance\Models\TicketProblemDetails");
        $builder->leftJoin("Vokuro\Maintenance\Models\TicketProblems", "Vokuro\Maintenance\Models\TicketProblems.id = Vokuro\Maintenance\Models\TicketProblemDetails.ticket_id");
        if(isset($search_param["data_cms_depts_rel_id"])){
            $builder->andWhere("Vokuro\Maintenance\Models\TicketProblems.data_cms_depts_rel_id ={$search_param["data_cms_depts_rel_id"]}");
        }
        if(isset($search_param["name"])){
            $builder->andWhere("Vokuro\Maintenance\Models\TicketProblemDetails.name like '%{$search_param['name']}%'");
        }
        $page = $this->page;
        if(isset($search_param["page"])){
            $page = $search_param["page"];
        }
        $builder->orderBy("Vokuro\Maintenance\Models\TicketProblems.id DESC");
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
    public function view($search_param){
        $id = $search_param["id"];
        $problem = TicketProblems::findFirst(["id={$id}"]);
        $result=[];
        if($problem){
            $result= $problem->toArray();
            $result["department_name"] = $problem->problem_type->Title;
            $result["department_parent_id"] = $problem->problem_type->Parent_Depts_ID;
            $result["department_parent_title"] = $problem->problem_type->Parent->Title;
            if($problem->content){
                $result["product_name"] = $problem->content->Title;
            }else{
                $result["product_name"] = "";
            }

            $result["details"]=$problem->problem_details->toArray();
        }
        return $result;
    }
    public function addProblemDetails($data){
        $problem = new TicketProblemDetails();
        $problem->ticket_id=$data["ticket_id"];
        $problem->name = $data["name"];
        $problem->spot_on_photo = $data["spot_on_photo"];
        $problem->save();
        $result = $problem->toArray();
        return $result;
    }

    public function createProblem($data){
        $problem = new TicketProblems($data);
        //$category_attribute_value=\DataKeyvalueOptionLang::findFirst(["Option_ID={$data["category_attribute_value"]}"]);

        if(!$problem->save()){
            die();
        }
        $result = $problem->toArray();
        return $result;
    }
    public function deleteProblem($data){
        $problem = TicketProblems::findFirst(["id={$data['id']}"]);
        if($problem->delete()){
            $problem_details = TicketProblemDetails::findFirst(["ticket_id={$problem->id}"]);
            foreach ($problem_details as $problem_detail){
                $problem_detail->delete();
            }
            return true;
        }
        return false;
    }
    public function updateProblem($data){
        $problem = TicketProblems::findFirst(["id={$data['id']}"]);
        $problem->photo = $data["pic"];
        $problem->save();
        $result = $problem->toArray();
        return $result;
    }
    public function getPaginationInfo(PaginatorQueryBuilder $paginator){
        $result = [];
        $result["items"] =[];
        foreach ($paginator->getPaginate()->items as $info){
            $row= $info->toArray();
            $row["data_cms_depts_rel_id"] = $info->ticket->data_cms_depts_rel_id;
            $row["category_attribute_id"] = $info->ticket->category_attribute_id;
            $row["category_attribute_id"] = $info->ticket->category_attribute_id;
            $row["department_name"] = $info->ticket->problem_type->Title;
            $row["department_parent_id"] = $info->ticket->problem_type->Parent_Depts_ID;
            $row["department_parent_title"] = $info->ticket->problem_type->Parent->Title;
            $row["data_cms_id"] = $info->ticket->data_cms_id;
            $row["product_name"]="";
            if($info->ticket->content){
                $row["product_name"]=$info->ticket->content->Title;
            }
            $row["photo"] = $info->ticket->photo;
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

    public  function getDepts(){
        $result=[];
        $depts = \DataCmsDeptsRel::find(["Application_ID=1 AND subject_to_maintenance=1 AND Parent_Depts_ID=0"]);
        if(count($depts)>0){
            $result["items"]=$depts->toArray();
            //this part translate the result to arabic
            foreach ($result["items"] as $k=>$item){
                $dept_lang=\DataCmsDeptsRelLang::findFirst(["dept_id={$item["ID"]} AND lang_id=1"]);
                if($dept_lang){
                    $result["items"][$k]["Title"] = $dept_lang->title;
                }
            }
        }
        return $result;
    }

    public  function getChildDepts($search_param){
        $id = $search_param["id"];
        $result=[];
        $depts = \DataCmsDeptsRel::find(["Application_ID=1 AND Parent_Depts_ID={$id} AND subject_to_maintenance=1"]);
        if(count($depts)>0){
            $result["items"]=$depts->toArray();
            foreach ($result["items"] as $k=>$item) {
                $dept_lang = \DataCmsDeptsRelLang::findFirst(["dept_id={$item["ID"]} AND lang_id=1"]);
                if ($dept_lang) {
                    $result["items"][$k]["Title"] = $dept_lang->title;
                }
            }
        }
        return $result;
    }

    public  function getProductTypesDoors($search_param){
        $id = $search_param["id"];
        $result=[];
        $options = \DataKeyvalueOption::find(["DKV_ID=95"]);
        foreach($options as $option){
            $row["ID"] = $option->ID;
            $row["Title"] = $option->OptionLang->Title;
            $result["items"][]=$row;
        }
        return $result;
    }

    public  function getProductTypesPumps($search_param){
        $id = $search_param["id"];
        $result=[];
        $options = \DataKeyvalueOption::find(["DKV_ID=97"]);
        foreach($options as $option){
            $row["ID"] = $option->ID;
            $row["Title"] = $option->OptionLang->Title;
            $result["items"][]=$row;
        }
        return $result;
    }

    public  function getProductTypesCoverings($search_param){
        $id = $search_param["id"];
        $result=[];
        $options = \DataKeyvalueOption::find(["DKV_ID=93"]);
        foreach($options as $option){
            $row["ID"] = $option->ID;
            $row["Title"] = $option->OptionLang->Title;
            $result["items"][]=$row;
        }
        return $result;
    }

    public function getAttributeForChildDept($search_param){
        $id = $search_param["id"];
        $attribute= \DataKeyvalueDeptCms::find(["dept_id={$id} and subject_to_maintenance=1"]);
        $attributes =[];
        foreach ($attribute as $item){
            $result["attribute_type"] = $item->attribute_type;
            if($item->getLang(["Lang_ID=1"])){
                $result["attribute_title"] = $item->getLang(["Lang_ID=1"])->Title;
            }else{
                $result["attribute_title"] = $item->Lang->Title;
            }

            $options = \DataKeyvalueOption::find(["DKV_ID={$item->dkv_id}"]);
            $result["attribute_id"]=$item->dkv_id;
            $result["attribute_options"]=[];
            foreach ($options as $option){
                $row["option_id"]=$option->ID;
                $row["title"]=$option->OptionLang->Title;
                $result["attribute_options"][]=$row;

            }
            $attributes[]= $result;
        }
        return $attributes;

    }

    public function getProductSizes($search_param){
        $id = $search_param["id"];
        $type_attribute= \DataKeyvalueOption::findFirst(["ID={$id}"]);
        switch($type_attribute->DKV_ID){
            case 95://doors
                $options = \DataKeyvalueOption::find(["DKV_ID=96"]);
                $result["attribute_id"]=96;
                break;
            case 97://pumps
                $options = \DataKeyvalueOption::find(["DKV_ID=98"]);
                $result["attribute_id"]=98;
                break;
            case 93://coverings
                $options = \DataKeyvalueOption::find(["DKV_ID=94"]);
                $result["attribute_id"]=94;
                break;
        }

        $result["attribute_options"]=[];
        foreach ($options as $option){
            $row["option_id"]=$option->ID;
            $row["title"]=$option->OptionLang->Title;
            $result["attribute_options"][]=$row;
        }
        return $result;
    }
    public function getProblemsWithCat($search_param){
        $data_cms_depts_rel_id = $search_param["data_cms_depts_rel_id"];
        $problems = [];
        //check if There is problem matching the search criteria
        $problem = TicketProblems::findFirst(["data_cms_depts_rel_id = {$data_cms_depts_rel_id}"]);
        if(!$problem){
            return $problems;
        }
        $problem_details= TicketProblemDetails::find(["ticket_id={$problem->id}"]);
        return $problem_details->toArray();
    }

    public function getProblemsWithProduct($search_param){
        $data_cms_id = $search_param["data_cms_id"];
        $problems = [];
        //check if There is problem matching the search criteria
        $problem = TicketProblems::find(["data_cms_id = {$data_cms_id}"]);
        if(count($problem)==0){
            return $problems;
        }
        foreach ($problem as $item){
            $problems_ids[]=$item->id;
        }
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Maintenance\Models\TicketProblemDetails");
        $builder->inWhere("ticket_id", $problems_ids);
        $problem_details= $builder->getQuery()->execute();
        return $problem_details->toArray();
    }
}

