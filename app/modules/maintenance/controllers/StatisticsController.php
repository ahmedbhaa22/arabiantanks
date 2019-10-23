<?php
namespace Vokuro\Maintenance\Controllers;

use Vokuro\Controllers\ControllerBase;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Services\MaintenanceStatisticsApi;
use Vokuro\Maintenance\Services\RequestsProblemsApi;

class StatisticsController extends ControllerBase
{
    public function indexAction()
    {

    }

    public function stat_reqAction()
    {

    }

    public function stat_req_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $search = new MaintenanceStatisticsApi();
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        $search_param = [];
        $search_param["page"] = $page;
        $result = $search->general($search_param);
        $this->view->content = $result;
    }

    public function stat_reportAction()
    {
        $this->view->date_from = $this->request->getQuery("date_from");
        $this->view->date_to = $this->request->getQuery("date_to");
        $this->view->dept = $this->request->getQuery("dept");
        $this->view->val = $this->request->getQuery("val");

    }

    public function stat_report_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $search_param=[];
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        if ($this->request->getPost("date_from") && $this->request->getPost("date_from") != "") {
            $filter["date_from"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_from")));
            $search_param["date_from"] = $filter["date_from"];
        }
        if ($this->request->getPost("date_to") && $this->request->getPost("date_to") != "") {
            $filter["date_to"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_to")));
            $search_param["date_to"] = $filter["date_to"];
        }
        if ($this->request->getPost("dept_id") && $this->request->getPost("dept_id")!="") {
            $filter["dept_id"] = $this->request->getPost("dept_id");
            $search_param["dept_id"] = $filter["dept_id"];
        }
        if ($this->request->getPost("category_attribute_value") && $this->request->getPost("category_attribute_value")!="") {
            $filter["category_attribute_value"]=$this->request->getPost("val");
            $search_param["category_attribute_value"] =$this->request->getPost("val");
        }
        $requests = new RequestsProblemsApi();
        $search_param["page"]=$page;
        $search = $requests->search($search_param);
        $this->view->content = $search;

    }

    public function stat_picAction(){
        //$this->view->disable();
        $search_param=[];
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        if ($this->request->getPost("dept_id") && $this->request->getPost("dept_id")!="") {
            $filter["dept_id"] = $this->request->getPost("dept_id");
            $search_param["dept_id"] = $filter["dept_id"];
        }
        $search_param["dept_id"] = 36;
        $requests = new MaintenanceStatisticsApi();
        $search_param["page"]=$page;
        $search_param["stat_pic"] = "";
        $search = $requests->stat_pic_search($search_param);
        $this->view->content = $search;
    }
}



