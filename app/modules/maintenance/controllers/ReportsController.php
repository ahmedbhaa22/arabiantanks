<?php
namespace Vokuro\Maintenance\Controllers;

use Models\TanksRegions;
use Models\UsersMobile;
use Vokuro\Cms\Services\BranchesService;
use Vokuro\Cms\Services\ProductService;
use Vokuro\Controllers\ControllerBase;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Models\MaintenancePendingReqReasons;
use Vokuro\Maintenance\Models\TicketProblemDetails;
use Vokuro\Maintenance\Models\TicketProblemsStatus;
use Vokuro\Maintenance\Models\Tickets;
use Vokuro\Maintenance\Models\TicketsInstallationStatus;
use Vokuro\Maintenance\Services\ProblemsApi;
use Vokuro\Maintenance\Services\RequestsProblemsApi;
use Vokuro\Models\UsersUsersRules;


class ReportsController extends ControllerBase{
    public function indexAction(){
        $this->view->open_count = Tickets::find(["ticket_status_id=1"]);
        $this->view->assign_count = Tickets::find(["ticket_status_id=2"]);
        $this->view->closed_count = Tickets::find(["ticket_status_id=3"]);
        $this->view->pending_count = Tickets::find(["ticket_status_id=4"]);
        $this->view->approve_count = Tickets::find(["ticket_status_id=8"]);
        $this->view->approved_count = Tickets::find(["ticket_status_id=9"]);
    }
    public function generalAction(){
        $problem = new ProblemsApi();
        $this->view->main_cats = $problem->getDepts();
        $regions=TanksRegions::find();
        $this->view->regions = $regions;
        $all_problems = TicketProblemDetails::find();
        $this->view->all_problems = $all_problems;
        $problem_statuses = TicketProblemsStatus::find();
        $this->view->problem_statuses = $problem_statuses;
    }

    public function general_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $requests = new RequestsProblemsApi();

        // $search_param["name"] = "Tank Leaking";
        $filter["ticket_number"] = "";
        $filter["ticket_status_id"] = "";
        $filter["ticket_problem_id"] = "";
        $filter['client_mobile'] = "";
        $filter['product_name'] = "";
        $filter['client_name'] = "";
        $filter['date_from'] = "";
        $filter['date_to'] = "";
        $filter['cities'] = [];
        $filter['regions'] = [];
        $filter['branches'] = [];
        $filter['filter_regions'] = "";
        $filter['order_branch'] = "";
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        if ($this->request->getPost("ticket_number") && $this->request->getPost("ticket_number") != "") {
            $filter["ticket_number"] = $this->request->getPost("ticket_number");
            $search_param["ticket_number"] = $filter["ticket_number"];
        }
        if ($this->request->getPost("ticket_status_id") && $this->request->getPost("ticket_status_id") != "") {
            $filter["ticket_status_id"] = $this->request->getPost("ticket_status_id");
            $search_param["ticket_status_id"] = $filter["ticket_status_id"];
            $this->tag->setDefault("ticket_status_id", $filter["ticket_status_id"]);
        }
        if ($this->request->getPost("ticket_problem_id") && $this->request->getPost("ticket_problem_id") != "") {
            $filter["ticket_problem_id"] = $this->request->getPost("ticket_problem_id");
            $search_param["ticket_problem_id"] = $filter["ticket_problem_id"];
            $this->tag->setDefault("ticket_problem_id", $filter["ticket_problem_id"]);
        }
        if ($this->request->getPost("client_mobile") && $this->request->getPost("client_mobile") != "") {
            $filter["client_mobile"] = $this->request->getPost("client_mobile");
            $search_param["client_mobile"] = $filter["client_mobile"];
            $this->tag->setDefault("client_mobile", $filter["client_mobile"]);
        }
        if ($this->request->getPost("product_name") && $this->request->getPost("product_name") != "") {
            $filter["product_name"] = $this->request->getPost("product_name");
            $search_param["product_name"] = $filter["product_name"];
        }
        if ($this->request->getPost("client_name") && $this->request->getPost("client_name") != "") {
            $filter["client_name"] = $this->request->getPost("client_name");
            $search_param["client_name"] = $filter["client_name"];
        }
        if ($this->request->getPost("date_from") && $this->request->getPost("date_from") != "") {
            $filter["date_from"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_from")));
            $search_param["date_from"] = $filter["date_from"];
        }
        if ($this->request->getPost("date_to") && $this->request->getPost("date_to") != "") {
            $filter["date_to"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_to")));
            $search_param["date_to"] = $filter["date_to"];
        }
        if($this->request->getPost("city")){
            $filter["city"]=$this->request->getPost("city");
            $this->tag->setDefault("city", $filter["city"]);
        }
        $branches_service = new BranchesService();
        if($this->request->getPost("filter_regions")){
            $filter["filter_regions"]=$this->request->getPost("filter_regions");
            $search_param["filter_regions"] = $filter["filter_regions"];
            $cities[]=$filter["city"];
            $regions = $branches_service->getRegionsInCities($cities);
            $filter["regions"] = $regions;
            $this->tag->setDefault("filter_regions", $filter["filter_regions"]);
        }
        if($this->request->getPost("data_cms_id") && $this->request->getPost("data_cms_id")!=""){
            $search_param["data_cms_id"] = (int)$this->request->getPost("data_cms_id");
        }
        if($this->request->getPost("product_type") && $this->request->getPost("product_type")!=""){
            $search_param["product_type"] = (int)$this->request->getPost("product_type");
        }
        if($this->request->getPost("branch") && $this->request->getPost("branch")!=""){
            $search_param["order_company_branch_id"] = $this->request->getPost("branch","int");
        }
        if($this->request->getPost("regions") && $this->request->getPost("regions")!=""){
            $search_param["regions"] = $this->request->getPost("regions");
        }

        $search_param["page"] = $page;
        $search = $requests->search($search_param);
        $this->view->content = $search;
        $this->view->filter = $filter;
        $problem_statuses = TicketProblemsStatus::find();
        $this->view->problem_statuses = $problem_statuses;
        $all_problems = TicketProblemDetails::find();
        $this->view->all_problems = $all_problems;

    }

    public function requestsAction(){

    }

    public function requests_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $requests = new RequestsProblemsApi();
        // $search_param["name"] = "Tank Leaking";
        $filter["ticket_number"] = "";
        $filter["ticket_status_id"] = "";
        $filter["ticket_problem_id"] = "";
        $filter['client_mobile'] = "";
        $filter['product_name'] = "";
        $filter['client_name'] = "";
        $filter['date_from'] = "";
        $filter['date_to'] = "";
        $filter['cities'] = [];
        $filter['regions'] = [];
        $filter['branches'] = [];
        $filter['filter_regions'] = "";
        $filter['order_branch'] = "";
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        if ($this->request->getPost("ticket_number") && $this->request->getPost("ticket_number") != "") {
            $filter["ticket_number"] = $this->request->getPost("ticket_number");
            $search_param["ticket_number"] = $filter["ticket_number"];
        }
        if ($this->request->getPost("ticket_status_id") && $this->request->getPost("ticket_status_id") != "") {
            $filter["ticket_status_id"] = $this->request->getPost("ticket_status_id");
            $search_param["ticket_status_id"] = $filter["ticket_status_id"];
            $this->tag->setDefault("ticket_status_id", $filter["ticket_status_id"]);
        }
        if ($this->request->getPost("ticket_problem_id") && $this->request->getPost("ticket_problem_id") != "") {
            $filter["ticket_problem_id"] = $this->request->getPost("ticket_problem_id");
            $search_param["ticket_problem_id"] = $filter["ticket_problem_id"];
            $this->tag->setDefault("ticket_problem_id", $filter["ticket_problem_id"]);
        }
        if ($this->request->getPost("client_mobile") && $this->request->getPost("client_mobile") != "") {
            $filter["client_mobile"] = $this->request->getPost("client_mobile");
            $search_param["client_mobile"] = $filter["client_mobile"];
            $this->tag->setDefault("client_mobile", $filter["client_mobile"]);
        }
        if ($this->request->getPost("product_name") && $this->request->getPost("product_name") != "") {
            $filter["product_name"] = $this->request->getPost("product_name");
            $search_param["product_name"] = $filter["product_name"];
        }
        if ($this->request->getPost("client_name") && $this->request->getPost("client_name") != "") {
            $filter["client_name"] = $this->request->getPost("client_name");
            $search_param["client_name"] = $filter["client_name"];
        }
        if ($this->request->getPost("date_from") && $this->request->getPost("date_from") != "") {
            $filter["date_from"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_from")));
            $search_param["date_from"] = $filter["date_from"];
        }
        if ($this->request->getPost("date_to") && $this->request->getPost("date_to") != "") {
            $filter["date_to"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_to")));
            $search_param["date_to"] = $filter["date_to"];
        }
        if($this->request->getPost("city")){
            $filter["city"]=$this->request->getPost("city");
            $this->tag->setDefault("city", $filter["city"]);
        }
        $branches_service = new BranchesService();
        if($this->request->getPost("filter_regions")){
            $filter["filter_regions"]=$this->request->getPost("filter_regions");
            $search_param["filter_regions"] = $filter["filter_regions"];
            $cities[]=$filter["city"];
            $regions = $branches_service->getRegionsInCities($cities);
            $filter["regions"] = $regions;
            $this->tag->setDefault("filter_regions", $filter["filter_regions"]);
        }
        if($this->request->getPost("order_branch")){
            $filter["order_branch"]=$this->request->getPost("order_branch");
            $search_param["region_id"] = $filter["filter_regions"];
            $search_param["company_branch_id"] = $this->request->getPost("order_branch");
            $branches = $branches_service->getAllBranchesByCityAndReg($search_param);
            $filter["branches"] = $branches;
            $this->tag->setDefault("order_branch", $filter["order_branch"]);
        }
        $search_param["page"] = $page;
        $search = $requests->search($search_param);
        $this->view->content = $search;
        $this->view->filter = $filter;
        $problem_statuses = TicketProblemsStatus::find();
        $this->view->problem_statuses = $problem_statuses;
        $all_problems = TicketProblemDetails::find();
        $this->view->all_problems = $all_problems;
        $branches_service = new BranchesService();
        $cities = $branches_service->getCities();
        $this->view->cities = $cities;
    }

    public function pendingAction(){

    }

    public function pending_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $requests = new RequestsProblemsApi();
        // $search_param["name"] = "Tank Leaking";
        $filter["ticket_number"] = "";
        $filter["ticket_status_id"] = "";
        $filter["ticket_problem_id"] = "";
        $filter['client_mobile'] = "";
        $filter['product_name'] = "";
        $filter['client_name'] = "";
        $filter['date_from'] = "";
        $filter['date_to'] = "";
        $filter['cities'] = [];
        $filter['regions'] = [];
        $filter['branches'] = [];
        $filter['filter_regions'] = "";
        $filter['order_branch'] = "";
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        if ($this->request->getPost("ticket_number") && $this->request->getPost("ticket_number") != "") {
            $filter["ticket_number"] = $this->request->getPost("ticket_number");
            $search_param["ticket_number"] = $filter["ticket_number"];
        }
        if ($this->request->getPost("ticket_status_id") && $this->request->getPost("ticket_status_id") != "") {
            $filter["ticket_status_id"] = $this->request->getPost("ticket_status_id");
            $search_param["ticket_status_id"] = $filter["ticket_status_id"];
            $this->tag->setDefault("ticket_status_id", $filter["ticket_status_id"]);
        }
//        if ($this->request->getPost("ticket_problem_id") && $this->request->getPost("ticket_problem_id") != "") {
//            $filter["ticket_problem_id"] = $this->request->getPost("ticket_problem_id");
//            $search_param["ticket_problem_id"] = $filter["ticket_problem_id"];
//            $this->tag->setDefault("ticket_problem_id", $filter["ticket_problem_id"]);
//        }
        $search_param["ticket_status_id"] = 4;
        if ($this->request->getPost("client_mobile") && $this->request->getPost("client_mobile") != "") {
            $filter["client_mobile"] = $this->request->getPost("client_mobile");
            $search_param["client_mobile"] = $filter["client_mobile"];
            $this->tag->setDefault("client_mobile", $filter["client_mobile"]);
        }
        if ($this->request->getPost("product_name") && $this->request->getPost("product_name") != "") {
            $filter["product_name"] = $this->request->getPost("product_name");
            $search_param["product_name"] = $filter["product_name"];
        }
        if ($this->request->getPost("client_name") && $this->request->getPost("client_name") != "") {
            $filter["client_name"] = $this->request->getPost("client_name");
            $search_param["client_name"] = $filter["client_name"];
        }
        if ($this->request->getPost("date_from") && $this->request->getPost("date_from") != "") {
            $filter["date_from"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_from")));
            $search_param["date_from"] = $filter["date_from"];
        }
        if ($this->request->getPost("date_to") && $this->request->getPost("date_to") != "") {
            $filter["date_to"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_to")));
            $search_param["date_to"] = $filter["date_to"];
        }
        if($this->request->getPost("city")){
            $filter["city"]=$this->request->getPost("city");
            $this->tag->setDefault("city", $filter["city"]);
        }
        $branches_service = new BranchesService();
        if($this->request->getPost("filter_regions")){
            $filter["filter_regions"]=$this->request->getPost("filter_regions");
            $search_param["filter_regions"] = $filter["filter_regions"];
            $cities[]=$filter["city"];
            $regions = $branches_service->getRegionsInCities($cities);
            $filter["regions"] = $regions;
            $this->tag->setDefault("filter_regions", $filter["filter_regions"]);
        }
        if($this->request->getPost("order_branch")){
            $filter["order_branch"]=$this->request->getPost("order_branch");
            $search_param["region_id"] = $filter["filter_regions"];
            $search_param["company_branch_id"] = $this->request->getPost("order_branch");
            $branches = $branches_service->getAllBranchesByCityAndReg($search_param);
            $filter["branches"] = $branches;
            $this->tag->setDefault("order_branch", $filter["order_branch"]);
        }
        $search_param["page"] = $page;
        $search = $requests->search($search_param);
        $this->view->content = $search;
        $this->view->filter = $filter;
        $problem_statuses = TicketProblemsStatus::find();
        $this->view->problem_statuses = $problem_statuses;
        $all_problems = TicketProblemDetails::find();
        $this->view->all_problems = $all_problems;
        $branches_service = new BranchesService();
        $cities = $branches_service->getCities();
        $this->view->cities = $cities;
    }

    public function exchangeAction(){

    }

    public function exchange_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $requests = new RequestsProblemsApi();
        // $search_param["name"] = "Tank Leaking";
        $filter["ticket_number"] = "";
        $filter["ticket_status_id"] = "";
        $filter["ticket_problem_id"] = "";
        $filter['client_mobile'] = "";
        $filter['product_name'] = "";
        $filter['client_name'] = "";
        $filter['date_from'] = "";
        $filter['date_to'] = "";
        $filter['cities'] = [];
        $filter['regions'] = [];
        $filter['branches'] = [];
        $filter['filter_regions'] = "";
        $filter['order_branch'] = "";
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        if ($this->request->getPost("ticket_number") && $this->request->getPost("ticket_number") != "") {
            $filter["ticket_number"] = $this->request->getPost("ticket_number");
            $search_param["ticket_number"] = $filter["ticket_number"];
        }
        if ($this->request->getPost("ticket_status_id") && $this->request->getPost("ticket_status_id") != "") {
            $filter["ticket_status_id"] = $this->request->getPost("ticket_status_id");
            $search_param["ticket_status_id"] = $filter["ticket_status_id"];
            $this->tag->setDefault("ticket_status_id", $filter["ticket_status_id"]);
        }
//        if ($this->request->getPost("ticket_problem_id") && $this->request->getPost("ticket_problem_id") != "") {
//            $filter["ticket_problem_id"] = $this->request->getPost("ticket_problem_id");
//            $search_param["ticket_problem_id"] = $filter["ticket_problem_id"];
//            $this->tag->setDefault("ticket_problem_id", $filter["ticket_problem_id"]);
//        }
        $search_param["ticket_status_id"] = 8;
        if ($this->request->getPost("client_mobile") && $this->request->getPost("client_mobile") != "") {
            $filter["client_mobile"] = $this->request->getPost("client_mobile");
            $search_param["client_mobile"] = $filter["client_mobile"];
            $this->tag->setDefault("client_mobile", $filter["client_mobile"]);
        }
        if ($this->request->getPost("product_name") && $this->request->getPost("product_name") != "") {
            $filter["product_name"] = $this->request->getPost("product_name");
            $search_param["product_name"] = $filter["product_name"];
        }
        if ($this->request->getPost("client_name") && $this->request->getPost("client_name") != "") {
            $filter["client_name"] = $this->request->getPost("client_name");
            $search_param["client_name"] = $filter["client_name"];
        }
        if ($this->request->getPost("date_from") && $this->request->getPost("date_from") != "") {
            $filter["date_from"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_from")));
            $search_param["date_from"] = $filter["date_from"];
        }
        if ($this->request->getPost("date_to") && $this->request->getPost("date_to") != "") {
            $filter["date_to"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_to")));
            $search_param["date_to"] = $filter["date_to"];
        }
        if($this->request->getPost("city")){
            $filter["city"]=$this->request->getPost("city");
            $this->tag->setDefault("city", $filter["city"]);
        }
        $branches_service = new BranchesService();
        if($this->request->getPost("filter_regions")){
            $filter["filter_regions"]=$this->request->getPost("filter_regions");
            $search_param["filter_regions"] = $filter["filter_regions"];
            $cities[]=$filter["city"];
            $regions = $branches_service->getRegionsInCities($cities);
            $filter["regions"] = $regions;
            $this->tag->setDefault("filter_regions", $filter["filter_regions"]);
        }
        if($this->request->getPost("order_branch")){
            $filter["order_branch"]=$this->request->getPost("order_branch");
            $search_param["region_id"] = $filter["filter_regions"];
            $search_param["company_branch_id"] = $this->request->getPost("order_branch");
            $branches = $branches_service->getAllBranchesByCityAndReg($search_param);
            $filter["branches"] = $branches;
            $this->tag->setDefault("order_branch", $filter["order_branch"]);
        }
        $search_param["page"] = $page;
        $search = $requests->search($search_param);
        $this->view->content = $search;
        $this->view->filter = $filter;
        $problem_statuses = TicketProblemsStatus::find();
        $this->view->problem_statuses = $problem_statuses;
        $all_problems = TicketProblemDetails::find();
        $this->view->all_problems = $all_problems;
        $branches_service = new BranchesService();
        $cities = $branches_service->getCities();
        $this->view->cities = $cities;
    }


    public function export_excelAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $requests = new RequestsProblemsApi();

        // $search_param["name"] = "Tank Leaking";
        $filter["ticket_number"] = "";
        $filter["ticket_status_id"] = "";
        $filter["ticket_problem_id"] = "";
        $filter['client_mobile'] = "";
        $filter['product_name'] = "";
        $filter['client_name'] = "";
        $filter['date_from'] = "";
        $filter['date_to'] = "";
        $filter['cities'] = [];
        $filter['regions'] = [];
        $filter['branches'] = [];
        $filter['filter_regions'] = "";
        $filter['order_branch'] = "";
        $page = 1;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        }
        if ($this->request->getPost("ticket_number") && $this->request->getPost("ticket_number") != "") {
            $filter["ticket_number"] = $this->request->getPost("ticket_number");
            $search_param["ticket_number"] = $filter["ticket_number"];
        }
        if ($this->request->getPost("ticket_status_id") && $this->request->getPost("ticket_status_id") != "") {
            $filter["ticket_status_id"] = $this->request->getPost("ticket_status_id");
            $search_param["ticket_status_id"] = $filter["ticket_status_id"];
            $this->tag->setDefault("ticket_status_id", $filter["ticket_status_id"]);
        }
        if ($this->request->getPost("ticket_problem_id") && $this->request->getPost("ticket_problem_id") != "") {
            $filter["ticket_problem_id"] = $this->request->getPost("ticket_problem_id");
            $search_param["ticket_problem_id"] = $filter["ticket_problem_id"];
            $this->tag->setDefault("ticket_problem_id", $filter["ticket_problem_id"]);
        }
        if ($this->request->getPost("client_mobile") && $this->request->getPost("client_mobile") != "") {
            $filter["client_mobile"] = $this->request->getPost("client_mobile");
            $search_param["client_mobile"] = $filter["client_mobile"];
            $this->tag->setDefault("client_mobile", $filter["client_mobile"]);
        }
        if ($this->request->getPost("product_name") && $this->request->getPost("product_name") != "") {
            $filter["product_name"] = $this->request->getPost("product_name");
            $search_param["product_name"] = $filter["product_name"];
        }
        if ($this->request->getPost("client_name") && $this->request->getPost("client_name") != "") {
            $filter["client_name"] = $this->request->getPost("client_name");
            $search_param["client_name"] = $filter["client_name"];
        }
        if ($this->request->getPost("date_from") && $this->request->getPost("date_from") != "") {
            $filter["date_from"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_from")));
            $search_param["date_from"] = $filter["date_from"];
        }
        if ($this->request->getPost("date_to") && $this->request->getPost("date_to") != "") {
            $filter["date_to"] = date('Y-m-d H:i:s', strtotime($this->request->getPost("date_to")));
            $search_param["date_to"] = $filter["date_to"];
        }
        if($this->request->getPost("city")){
            $filter["city"]=$this->request->getPost("city");
            $this->tag->setDefault("city", $filter["city"]);
        }
        $branches_service = new BranchesService();
        if($this->request->getPost("filter_regions")){
            $filter["filter_regions"]=$this->request->getPost("filter_regions");
            $search_param["filter_regions"] = $filter["filter_regions"];
            $cities[]=$filter["city"];
            $regions = $branches_service->getRegionsInCities($cities);
            $filter["regions"] = $regions;
            $this->tag->setDefault("filter_regions", $filter["filter_regions"]);
        }
        if($this->request->getPost("data_cms_id") && $this->request->getPost("data_cms_id")!=""){
            $search_param["data_cms_id"] = (int)$this->request->getPost("data_cms_id");
        }
        if($this->request->getPost("product_type") && $this->request->getPost("product_type")!=""){
            $search_param["product_type"] = (int)$this->request->getPost("product_type");
        }
        if($this->request->getPost("branch") && $this->request->getPost("branch")!=""){
            $search_param["order_company_branch_id"] = $this->request->getPost("branch","int");
        }
        if($this->request->getPost("regions") && $this->request->getPost("regions")!=""){
            $search_param["regions"] = $this->request->getPost("regions");
        }

        $search_param["page"] = $page;
        $search_param["no_pagination"]=1;
        $search = $requests->search($search_param);
        //Build The Excel Sheet
        $fields_title = ["رقم الطلب","اسم العميل","تليفون العميل","عنوان العميل","فرع الصيانة","المنتج","المشكلة","الحالة","التاريخ"];
        // exporting data

        //this because php-zip extension is not installed
        \PHPExcel_Settings::setZipClass(\PHPExcel_Settings::PCLZIP);
        $phpexcel = new \PHPExcel();

        $phpexcel->getProperties()->setCreator('AlArabia Tanks');
        $phpexcel->getProperties()->setTitle('Report');
        $phpexcel->getProperties()->setSubject('Export Report');
        $phpexcel->setActiveSheetIndex(0);

        $header_fields = $fields_title;

        $file_header = $this->createFileHeader();

        for ($i = 0; $i < count($header_fields); $i++) {
            $phpexcel->getActiveSheet()->setCellValue($file_header[$i], $header_fields[$i]);
            $phpexcel->getActiveSheet()->getStyle($file_header[$i])->applyFromArray([
                'fill' => [
                    'type' => \PHPExcel_Style_Fill::FILL_SOLID,
                    'color' => [
                        'rgb' => 'FF0000'
                    ]
                ]
            ]);
        }
//            \PHPExcel_Shared_Font::setTrueTypeFontPath('C:/Windows/Fonts/');
//            \PHPExcel_Shared_Font::setAutoSizeMethod(\PHPExcel_Shared_Font::AUTOSIZE_METHOD_EXACT);

        $row = 2;
        foreach ($search["items"] as $item) {
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $row, $item['ticket_number']);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $row, $item['client_name']);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(2, $row, $item['client_mobile']);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(3, $row, $item['client_address']);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(4, $row, $item['maintenance_branch']);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(5, $row, $item['product_name']);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(6, $row, $item['problem_name']);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(7, $row, $item['ticket_status_name']);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(8, $row, $item['created_at']);

//            $date = new \DateTime();
//            $date->setTimestamp($report->report_date);
//
//            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(4, $row, $date->format("Y-m"));
            $row++;
        }
//            foreach(range('B','G') as $columnID) {
//                $phpexcel->getActiveSheet()->getColumnDimension($columnID)
//                    ->setAutoSize(true);
//            }

        $obj_writer = new \PHPExcel_Writer_Excel2007($phpexcel);

        $file_name = date('Y-m-d H-i-s') . '.xlsx';
        $file_path = BASE_PATH . '/public/uploads/' . $file_name;
        ob_clean();
        $obj_writer->save($file_path);
        return json_encode(['status' => 'success', 'file_name' => $file_name]);

    }

    private function createFileHeader($start_index = -1, $header=[])
    {
        $chars = range('A','Z');
        $header = $header;

        if($start_index === -1)
        {
            foreach($chars as $char)
            {
                $header[] = $char.'1';
            }

            $this->createFileHeader($start_index+1, $header);
        }
        elseif($start_index !== 26)
        {
            foreach($chars as $char)
            {
                $header[] = $chars[$start_index].$char.'1';
            }

            $this->createFileHeader($start_index+1, $header);
        }

        return $header;
    }

    public function testAction(){
        $this->view->disable();
        var_dump(extension_loaded ('zip'));

    }


}



