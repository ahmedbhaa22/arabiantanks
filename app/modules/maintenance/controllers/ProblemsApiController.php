<?php
namespace Vokuro\Maintenance\Controllers;

use Vokuro\Controllers\ControllerApiBase;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Services\ProblemsApi;

class ProblemsApiController extends ControllerApiBase{
    public $request_data;
    public function onConstruct(){
        $this->view->disable();
        $this->request_data = json_decode(file_get_contents("php://input"),true);


    }
    public function listAction(){


        $problem = new ProblemsApi();

            $arr['eCode'] = 200;

            $arr['eMessage'] = "Success";

            $arr['eContent'] = $problem->search($this->request_data);

            header("Content-type:application/json");

            return json_encode($arr);


    }
    public function createAction(){
        $problem = new ProblemsApi();
        $param= ["category_attribute_id","category_attribute_value","data_cms_depts_rel_id","photo"];
        if(!$this->SharedFunctions->array_keys_exists($param,$this->request_data)){
            $arr['eCode'] = 204;

            $arr['eMessage'] = "Check All Parameters is sent";

            $arr['eContent'] = [];

            header("Content-type:application/json");
            return json_encode($arr);
        }
        $arr['eCode'] = 200;

        $arr['eMessage'] = "Success";

        $arr['eContent'] = $problem->createProblem($this->request_data);

        header("Content-type:application/json");

        return json_encode($arr);

    }
    public function createDetailsAction(){
        $problem = new ProblemsApi();
        $param= ["ticket_id","name","spot_on_photo"];
        if(!$this->SharedFunctions->array_keys_exists($param,$this->request_data)){
            $arr['eCode'] = 204;

            $arr['eMessage'] = "Check All Parameters is sent";

            $arr['eContent'] = [];

            header("Content-type:application/json");
            return json_encode($arr);
        }
        $arr['eCode'] = 200;

        $arr['eMessage'] = "Success";

        $arr['eContent'] = $problem->addProblemDetails($this->request_data);

        header("Content-type:application/json");

        return json_encode($arr);
//        $data["ticket_id"]=2;
//        $data["name"]="Tanks Leaking";
//        $data["spot_on_photo"]=3;

    }

    public function viewAction(){
        $problem = new ProblemsApi();
        $param= ["id"];
        if(!$this->SharedFunctions->array_keys_exists($param,$this->request_data)){
            $arr['eCode'] = 204;

            $arr['eMessage'] = "Check All Parameters is sent";

            $arr['eContent'] = [];

            header("Content-type:application/json");
            return json_encode($arr);
        }
        $arr['eCode'] = 200;

        $arr['eMessage'] = "Success";

        $arr['eContent'] = $problem->view($this->request_data);

        header("Content-type:application/json");
        return json_encode($arr);
    }

    public function deleteAction(){
        $problem = new ProblemsApi();
        $param= ["id"];
        if(!$this->SharedFunctions->array_keys_exists($param,$this->request_data)){
            $arr['eCode'] = 204;

            $arr['eMessage'] = "Check All Parameters is sent";

            $arr['eContent'] = [];

            header("Content-type:application/json");
            return json_encode($arr);
        }
        $arr['eCode'] = 200;

        $arr['eMessage'] = "Success";

        $arr['eContent'] = $problem->deleteProblem($this->request_data);

        header("Content-type:application/json");
        return json_encode($arr);
    }


    public function getDeptsAction(){
        $problem = new ProblemsApi();
        $arr['eCode'] = 200;

        $arr['eMessage'] = "Success";

        $arr['eContent'] = $problem->getDepts();

        header("Content-type:application/json");
        return json_encode($arr);
    }

    public function getChildDeptsAction(){
        $problem = new ProblemsApi();
        $param= ["id"];
        if(!$this->SharedFunctions->array_keys_exists($param,$this->request_data)){
            $arr['eCode'] = 204;

            $arr['eMessage'] = "Check All Parameters is sent";

            $arr['eContent'] = [];

            header("Content-type:application/json");
            return json_encode($arr);
        }
        $arr['eCode'] = 200;

        $arr['eMessage'] = "Success";

        $arr['eContent'] = $problem->getChildDepts($this->request_data);

        header("Content-type:application/json");
        return json_encode($arr);
    }


    public function response($data){
        $arr['eCode'] = 200;

        $arr['eMessage'] = "Success";

        $arr['eContent'] = $data;

        return json_encode($arr);

    }

    public function getAttributeForChildDeptAction(){
        $problem = new ProblemsApi();
        $param= ["id"];
        if(!$this->SharedFunctions->array_keys_exists($param,$this->request_data)){
            $arr['eCode'] = 204;

            $arr['eMessage'] = "Check All Parameters is sent";

            $arr['eContent'] = [];

            header("Content-type:application/json");
            return json_encode($arr);
        }
        $arr['eCode'] = 200;

        $arr['eMessage'] = "Success";

        $arr['eContent'] = $problem->getAttributeForChildDept($this->request_data);

        header("Content-type:application/json");
        return json_encode($arr);
    }
}



