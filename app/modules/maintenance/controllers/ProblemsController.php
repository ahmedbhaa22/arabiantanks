<?php
namespace Vokuro\Maintenance\Controllers;

use Vokuro\Controllers\ControllerBase;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Services\ProblemsApi;


class ProblemsController extends ControllerBase
{
    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';

    public function indexAction()
    {
        //$this->view->disable();
        $data["id"] = 1;
        $problem = new ProblemsApi();
        // $search_param["name"] = "Tank Leaking";
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        $search_param["page"] = $page;
        $search = $problem->search($search_param);
        $this->view->content = $search;

    }

    public function newAction()
    {
        $problem = new ProblemsApi();
        $this->view->main_cats = $problem->getDepts();

    }

    public function product_typeAction($main_cat)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $problem = new ProblemsApi();
        $search_param["id"] = $main_cat;
        $this->view->product_types = $problem->getChildDepts($search_param);

    }

    public function product_capacityAction($child_cat)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $problem = new ProblemsApi();
        $search_param["id"] = $child_cat;
        $this->view->attributes = $problem->getAttributeForChildDept($search_param);
    }

    public function product_sizeAction($child_cat)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $problem = new ProblemsApi();
        $search_param["id"] = $child_cat;
        $this->view->result = $problem->getProductSizes($search_param);
    }

    public function createAction()
    {
        if (!$this->request->isPost()) {
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        $data = [];
//        if($this->request->getPost("main_dept")==7){
//            $data["data_cms_depts_rel_id"] = $this->request->getPost("product_type");
//        }else{
//            $data["data_cms_depts_rel_id"] = $this->request->getPost("main_dept");
//        }
        $data["data_cms_depts_rel_id"] = $this->request->getPost("main_dept","int");


        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                if ($file->getKey() == "problem_pic") {
                    //die("Islam");
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    $data["photo"] = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                }
            }
        }

        $problem = new ProblemsApi();
        $data["data_cms_id"]=0;
        $create_problem= $problem->createProblem($data);
        $data=[];
        $data["ticket_id"] = $create_problem["id"];
        foreach ($this->request->getPost("problem_name") as $key => $name) {
            $data["name"] = $name;
            $data["spot_on_photo"] = $this->request->getPost("problem_spot")[$key];
            if ($data["name"] == "" || $data["spot_on_photo"] == "") {
                continue;
            }
            $problem->addProblemDetails($data);
        }
        $this->flashSession->success("Problem Created Successfully");
        return $this->response->redirect("maintenance_module/problems/index");
    }

    public function createDetailsAction()
    {
        $problem = new ProblemsApi();
        if ($this->request->getPost("update_pic")) {
            if ($this->request->hasFiles() == true) {
                foreach ($this->request->getUploadedFiles() as $file) {
                    if ($file->getKey() == "img") {
                        //die("Islam");
                        $random = new Random();
                        $random_name = $random->uuid() . "." . $file->getExtension();
                        $data["id"] = $this->request->getPost("ticket_id");
                        $data["pic"] = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                        $problem->updateProblem($data);
                        return $this->response->redirect($_SERVER['HTTP_REFERER']);

                    }
                }

            }
        }
        $data["ticket_id"] = $this->request->getPost("ticket_id");
        foreach ($this->request->getPost("problem_name") as $key => $name) {
            $data["name"] = $name;
            $data["spot_on_photo"] = $this->request->getPost("problem_spot")[$key];
            if ($data["name"] == "" || $data["spot_on_photo"] == "") {
                continue;
            }
            $problem->addProblemDetails($data);
        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);


    }
    public function deleteAction($problem_id){
        $data['id'] = $problem_id;
        $problem = new ProblemsApi();
        $result = $problem->deleteProblem($data);
        return $this->response->redirect("maintenance_module/problems/index");

    }

    public function viewAction($id)
    {

        $problem = new ProblemsApi();
        $req = ["id" => $id];
        $this->view->problem = $problem->view($req);


    }

    public function problems_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $data["id"] = 1;
        $problem = new ProblemsApi();
        // $search_param["name"] = "Tank Leaking";
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        $search_param["page"] = $page;
        $search = $problem->search($search_param);
        $this->view->content = $search;
    }

    public function products_in_catAction($dept_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $dept_id = (int)$dept_id;
        $search_param["departments"][] = $dept_id;
        $search_param["application_id"] = 1;

        $content=$this->CmsSearch->content_search($search_param);
        $this->view->content = $content;

    }
}



