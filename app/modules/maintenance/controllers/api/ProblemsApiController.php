<?php
namespace Vokuro\Maintenance\Controllers\Api;

use Vokuro\Controllers\ControllerApiBase;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Services\ProblemsApi;

class ProblemsControllerApi extends ControllerApiBase{
    public function indexAction(){
        $this->view->disable();
        $data["id"]=1;
            $problem = new ProblemsApi();
           // $search_param["name"] = "Tank Leaking";
            $search_param["page"] = 1;
           print_r($problem->search());
    }
    public function createAction(){
        $data=[];
        $data["category_attribute_id"]=33;
        $data["category_attribute_value"]=1200;
        $data["data_cms_depts_rel_id"]=39;
        $data["photo"]="photo.jpg";
        $problem = new ProblemsApi();
        var_dump($problem->createProblem($data));
    }
    public function createDetailsAction(){
        $data["ticket_id"]=2;
        $data["name"]="Tanks Leaking";
        $data["spot_on_photo"]=3;
        $problem = new ProblemsApi();
        var_dump($problem->addProblemDetails($data));
    }
}



