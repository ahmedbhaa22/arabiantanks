<?php
namespace Vokuro\Maintenance\Controllers;

use Models\TanksRegions;
use Models\UserCategories;
use Models\UsersMobile;
use Vokuro\Cms\Services\BranchesService;
use Vokuro\Cms\Services\ProductService;
use Vokuro\Controllers\ControllerBase;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Maintenance\Models\MaintenanceExchangeReqReasons;
use Vokuro\Maintenance\Models\MaintenancePendingReqReasons;
use Vokuro\Maintenance\Models\TicketHistory;
use Vokuro\Maintenance\Models\TicketProblemDetails;
use Vokuro\Maintenance\Models\TicketProblemsStatus;
use Vokuro\Maintenance\Models\Tickets;
use Vokuro\Maintenance\Models\TicketsInstallationStatus;
use Vokuro\Maintenance\Models\TicketsTechReportPhotos;
use Vokuro\Maintenance\Services\ProblemsApi;
use Vokuro\Maintenance\Services\ProductsAttributesOptions;
use Vokuro\Maintenance\Services\RequestsProblemsApi;
use Vokuro\Models\UsersUsersRules;
use Vokuro\Pentavalue\RequestValidation;
use Vokuro\UsersModule\Models\UserAddresses;
use Vokuro\UsersModule\Models\UserData;


class RequestsController extends ControllerBase

{
    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';

    public function onConstruct(){
//dd($_REQUEST);
    }

    public function indexAction()
    {

    }

    public function newAction()
    {

        $problem = new ProblemsApi();
        $this->view->main_cats = $problem->getDepts();
        //branches
        $branches_service = new BranchesService();
        $this->view->all_branches = $branches_service->getAllBranches();
        $cities = $branches_service->getCities();
        $this->view->cities = $cities;
        $client = $this->request->getQuery("client");
        $this->view->revise_client_name ="";
        $this->view->revise_client_mail ="";
        $this->view->revise_client_mobile ="";
        $this->view->revise_client_region ="";
        $this->view->client_exists=false;
        if($client){
            $client = UsersMobile::findFirst(["ID={$client} AND category_id is not null"]);
            $this->view->client_exists = $client;

            $this->view->revise_client_name =$client->Title;
            $this->view->revise_client_mail =$client->Mail;
            $this->view->revise_client_mobile =$client->Mobile;
            $this->view->revise_client_region =$client->data->region->city->name;
        }
        $categories = UserCategories::find();
        $this->view->categories = $categories;
        $regions    = TanksRegions::find();
        $this->view->regions   = $regions;
    }

    public function requests_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $user_rules = $this->session->get('auth-identity')["rules"];
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
        $this->view->fast_search= 0;
        //Check if the request from the fast search page
        $fast_search= $this->request->getQuery("fast");
        if($fast_search==1){
            $this->view->fast_search= 1;
        }
    }

    public function requests_table_tanksAction()
    {
        $search_param["dept_id"] = 80;
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

    public function requests_table_coveringAction()
    {
        $search_param["dept_id"] = 81;
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

        if ($this->request->getPost("order_branch") && $this->request->getPost("order_branch") != "") {
            $filter["order_branch"] = $this->request->getPost("order_branch");
            $search_param["company_branch_id"] = $filter["order_branch"];
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

    public function requests_table_doorsAction()
    {
        $search_param["dept_id"] = 9;
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
        $search_param["page"] = $page;
        $search = $requests->search($search_param);
        $this->view->content = $search;
        $this->view->filter = $filter;
        $problem_statuses = TicketProblemsStatus::find();
        $this->view->problem_statuses = $problem_statuses;
        $all_problems = TicketProblemDetails::find();
        $this->view->all_problems = $all_problems;
    }

    public function requests_table_pumpsAction()
    {
        $search_param["dept_id"] = 83;
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
        $search_param["page"] = $page;
        $search = $requests->search($search_param);
        $this->view->content = $search;
        $this->view->filter = $filter;
        $problem_statuses = TicketProblemsStatus::find();
        $this->view->problem_statuses = $problem_statuses;
        $all_problems = TicketProblemDetails::find();
        $this->view->all_problems = $all_problems;
    }

    public function viewAction($id)
    {
        $requests = new RequestsProblemsApi();
        $search_param["id"] = $id;
        $search = $requests->search($search_param);
        $content = $search["items"][0];
        $this->view->content = $content;
        $this->view->ticket_status_id = $content["ticket_status_id"];
        $problem_statuses = TicketProblemsStatus::find();
        $this->view->problem_statuses = $problem_statuses;
        $this->tag->setDefault("problem_status", $content["ticket_status_id"]);
        $branches_service = new BranchesService();
        $cities = $branches_service->getCities();
        $this->view->cities = $cities;

    }

    public function createRequestAction()
    {
        $this->view->disable();
        if (!$this->request->isPost()) {
            echo "Error CSRF";
            die();
        }
        //check CSRF
        if ($this->security->checkToken()) {
            $check_required_array = [
                "client_choose",
                "report_notes",
                "data_cms_id",
                "chosen_problem",
                "purchase_branch",
                "order_notes",
                "city",
                "order_branch",
                "purhcase_invoice_number"


            ];
            foreach ($check_required_array as $required) {
                if (!isset($_POST[$required])) {
                    $this->flashSession->error("Error: You have to enter all required fields $required");
                   // return $this->response->redirect($_SERVER['HTTP_REFERER']);
                }
            }
            $data['client_id'] = $this->request->getPost("client_choose");

            $data['client_notes'] = $this->request->getPost("report_notes");
            $data['data_cms_id'] = $this->request->getPost("data_cms_id");
            $data['production_year'] = 0;
            $data['product_number'] = 0;
            //get the product attribute value and id for tanks (capacity)
            $products_attribute_service= new ProductsAttributesOptions();
            $category_attribute_result= $products_attribute_service->getTankCapacityInfo($this->request->getPost("product_type"),$data['data_cms_id']);
            $data['category_attribute_id'] = $category_attribute_result["category_attribute_id"]?:0;
            $data['category_attribute_value'] = $category_attribute_result["category_attribute_value"]?:0;
            $data['category_attribute_value_option_id'] = $category_attribute_result["category_attribute_value_option_id"]?:0;
            $data['category_attribute_type_id'] = $this->request->getPost("attribute_type_id")?:0;
            $data['category_attribute_type_value'] = $this->request->getPost("attribute_type_value")?:0;
            $data['category_attribute_type_value_option_id'] = $this->request->getPost("type")?:0;
            $data['ticket_problem_id'] = $this->request->getPost("chosen_problem");
            $data['installation_status_id'] = 0;
            $data['installation_reason'] = 0;
            $data['in_guarantee'] = 0;
            $data['photo'] = "";
            $data['report_notes'] = "";
            $data['ticket_status_id'] = 1;
            $data['company_branch_id'] = $this->request->getPost("purchase_branch");
            $data['invoice_number'] = $this->request->getPost("purhcase_invoice_number");
            $data['number_of_products'] = 0;
            $data['attached_file'] = "";
            $data['order_notes'] = $this->request->getPost("order_notes");
            $data['order_region_id'] = $this->request->getPost("city");
            $data['order_company_branch_id'] = $this->request->getPost("order_branch");
            $data['assigned_technician_id'] = 0;
            $data['created_by'] = $this->session->get('auth-identity')['id'];
            $data['modified_by'] = $this->session->get('auth-identity')['id'];
            //Adding Uploaded File
            if ($this->request->hasFiles() == true) {
                foreach ($this->request->getUploadedFiles() as $file) {
                    //die("Islam");
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                    $data["attached_file"] = $random_name;
                }

            }
            $requests_service = new RequestsProblemsApi();
            $result = $requests_service->createRequest($data);
            //Log Status
            $ticket_history= new TicketHistory();
            $ticket_history->ticket_id= $result['id'];
            $ticket_history->changed_at= $result['created_at'];
            $ticket_history->status_id= $result['ticket_status_id'];
            $ticket_history->save();
            return $this->response->redirect($this->url_shared->get("maintenance_module/requests/view/").$result["id"]);
        }
    }

    public function problems_in_catAction($cat_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $search_param["data_cms_depts_rel_id"] = (int)$cat_id;
        $problems_service = new ProblemsApi();
        $problems = $problems_service->getProblemsWithCat($search_param);
        $this->view->problems = $problems;
    }

    public function problems_in_productAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $search_param["data_cms_id"] = $this->request->getQuery("data_cms_id","int");
        $problems_service = new ProblemsApi();
        $problems = $problems_service->getProblemsWithProduct($search_param);
        $this->view->problems = $problems;
    }

    public function branches_by_cityAction($city_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $branches = $this->TanksBranches->getBranchesByRegion($city_id);
        $this->view->branches = $branches;
    }

    public function clientInfoAjaxAction($client_id)
    {
        $this->view->disable();
        $client_id = (int)$client_id;
        $user = UsersMobile::findFirst(["ID={$client_id}"]);
        $user_info = $user->toArray();
        $user_info["region_id"] = $user->data->region_id;
        $user_info["region_name"] = "الرياض";
        header("Content-type:application/json");
        echo json_encode($user_info);
    }

    public function getProductsWithAttributeAction($value, $attribute_id, $dept_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $search_param = [];
        $search_param["dept_id"] = $dept_id;//39;
        $search_param["dkv_id"] = $attribute_id;//88;
        $search_param["value"] = $value;//22;
        $product_service = new ProductService();
        $others_than_tanks=[9,10,31];
        if(!in_array($search_param["dept_id"],$others_than_tanks)){
            $result = $product_service->getProductWithAttributeOption($search_param);
        }else{
            $result = $product_service->getProductWithAttributeOptionOther($search_param);
        }

        $this->view->result = $result;
    }

    public function editAction($id)
    {
        $id =(int)$id;
        //Check Access
        $order = Tickets::findFirst(["id={$id}"]);
        if(!$this->MaintenancePermissions->checkEditReqAccess("requests","edit",$order)){
            $this->flashSession->error("You Don't Have Permission To This Section, Please Contact System Admin, لايوجد لك صلاحية للتعديل، الرجاء الاتصال بمدير النظام");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        $requests = new RequestsProblemsApi();
        $search_param["id"] = (int)$id;
        $search = $requests->search($search_param);
        $content = $search["items"][0];
        $this->view->content = $content;
        $install_statuses = TicketsInstallationStatus::find();
        foreach ($install_statuses as $k => $v) {
            $install_status_array[$v->id] = $v->title;
        }
        $this->view->install_statuses = $install_status_array;
        $pending_reasons = MaintenancePendingReqReasons::find();
        foreach ($pending_reasons as $k => $v) {
            $pending_reasons_array[$v->id] = $v->reason_title;
        }
        $this->view->pending_reasons = $pending_reasons_array;
        $this->tag->setDefault("pending_reason", $search["items"][0]["ticket_pending_reason"]);
        $this->tag->setDefault("install_status", $search["items"][0]["installation_status_id"]);
        $this->tag->setDefault("visit_date", $search["items"][0]["visit_date"]);

        //$this->tag->setDefault("pending_reason", $search["items"][0]["installation_status_id"]);
        //Get Product Info

        $problem = new ProblemsApi();

            $problem_statuses = TicketProblemsStatus::find();
            $this->view->problem_statuses = $problem_statuses;
            $this->tag->setDefault("problem_status", $content["ticket_status_id"]);
            $this->view->ticket_status_id = $content["ticket_status_id"];
            $maintenace_persons = UsersUsersRules::find(["rule_id=9"]);
            $maintenace_persons_array = [];
            foreach ($maintenace_persons as $k => $v) {
                $user_info = $v->User;
                $maintenace_persons_array[$user_info->ID] = $user_info->Title;
            }
            $this->view->maintenace_persons = $maintenace_persons_array;
            $this->tag->setDefault("maintenace_persons", $content["assigned_technician_id"]);


            $this->tag->setDefault("next_activation_date", $content["next_activation_date"]);

        $problem = new ProblemsApi();
        $this->view->main_cats = $problem->getDepts();

        $exchange_reasons = MaintenanceExchangeReqReasons::find();
        foreach ($exchange_reasons as $k => $v) {
            $exchange_reasons_array[$v->id] = $v->reason_title;
        }
        $this->view->exchange_reasons = $exchange_reasons_array;
        $this->tag->setDefault("exchange_reasons", $search["items"][0]["ticket_exchange_reason"]);



    }

    public function saveRequestAction()
    {
        $this->view->disable();
        if (!$this->request->isPost()) {
            echo "Post Only";
            die();
        }
        //check CSRF
//        if (!$this->security->checkToken()) {
//            $this->flashSession->error("Error CSRF: Refresh Edit Page with ctrl+F5 and save again");
//            return $this->response->redirect($_SERVER['HTTP_REFERER']);
//
//        }



        $ticket_id = $this->request->getPost("ticket_id", "int");

        $install_status = $this->request->getPost("install_status");

        $ticket_status_id = $this->request->getPost("problem_status");
        //Check Permissions
        if($ticket_status_id==8){
            //Check if user is Admin or CS Manager
            $user_rules = $this->session->get('auth-identity')["rules"];
         //   var_dump($user_rules);die;
            if(!array_key_exists(1,$user_rules) && !array_key_exists(5,$user_rules)){
                $this->flashSession->error("صلاحية التعميد لمدير خدمة العملاء ومدير النظام فقط");
                return $this->response->redirect($_SERVER['HTTP_REFERER']);
            }
        }
        $maintenace_persons = $this->request->getPost("maintenace_persons");
        $pending_reason = $this->request->getPost("pending_reason", "int");
        $exchange_reason = $this->request->getPost("exchange_reasons", "int");
        $next_activation_date = date("Y-m-d", strtotime($this->request->getPost("next_activation_date")));
        $visit_date = $this->request->getPost("visit_date");
        $ticket = Tickets::findFirst(["id={$ticket_id}"]);
        //status change for log
        $status_changed=0;


        if ($install_status != 0) {
            $ticket->installation_status_id = $install_status;
        }
        if ($maintenace_persons != 0) {
            $ticket->assigned_technician_id = $maintenace_persons;
        }
        if ($pending_reason != 0) {
            $ticket->ticket_pending_reason = $pending_reason;
        }

        if ($this->request->getPost("next_activation_date") != "") {
            $ticket->next_activation_date = $next_activation_date;
        }
        if($visit_date!=""){
            $ticket->visit_date = $visit_date;
        }
        if($ticket_status_id!=$ticket->ticket_status_id ){
            $status_changed=1;
        }
        $ticket->ticket_status_id = $ticket_status_id;
        if($ticket_status_id == 3){
            $ticket->back_to_cs = 1;
        }

        if($exchange_reason !=0){
            $ticket->ticket_exchange_reason	 = $exchange_reason;
        }
        if (!$ticket->save()) {
            foreach ($ticket->getMessages as $eMessage) {
                $this->flashSession->error($eMessage);
            }
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }

        $this->flashSession->success("Saved Successfully");
        //Log Status
        if($status_changed==1){
            $ticket_history= new TicketHistory();
            $ticket_history->ticket_id= $ticket->id;
            $ticket_history->changed_at= $ticket->created_at;
            $ticket_history->status_id= $ticket->ticket_status_id;
            $ticket_history->save();
        }

        return $this->response->redirect($_SERVER['HTTP_REFERER']);


    }

    public function getRegionsAjaxAction($value)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        //$city=$this->request->getPost("cities");
        $cities[] = $value;
        $branches_service = new BranchesService();
        $regions = $branches_service->getRegionsInCities($cities);
        $this->view->regions = $regions;
        $this->view->selected = 0;
        if ($this->request->getQuery("selected") != 0) {
            $this->view->selected = $this->request->getQuery("selected");
        }

    }

    public function branches_by_city_regionAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $branches_service = new BranchesService();
        $search_param["city_id"] = $this->request->getPost("filter_cities");
        $search_param["region_id"] = $this->request->getPost("filter_regions");
        $branches = $branches_service->getAllBranchesByCity($search_param);
        $this->view->branches = $branches;
    }

    public function tech_by_branchAction($branch_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $branches_service = new BranchesService();
        $search_param["branch_id"] = $branch_id;
        $techs = $branches_service->getTechInBranch($search_param);
        $this->view->techs = $techs;
    }

    public function assign_techAction()
    {
        if ($this->request->isPost()) {
            $tech_choose = $this->request->getPost("tech_choose");
            if ($tech_choose == "" || $tech_choose == 0) {
                $this->flashSession->error("You Must Choose Technician");
                return $this->response->redirect($_SERVER['HTTP_REFERER']);
            }
            $ticket_id = $this->request->getPost("ticket_id");
            $ticket = Tickets::findFirst(["id={$ticket_id}"]);
            $ticket->assigned_technician_id = $tech_choose;
            $ticket->save();
            $this->flashSession->success("Assigned Successfully");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function add_tech_reportAction()
    {
        if ($this->request->isPost()) {
            $data['ticket_id'] = $this->request->getPost("ticket_id");
            $data['data_cms_id'] = $this->request->getPost("data_cms_id");
            $data['manufacturing_year'] = $this->request->getPost("manuf_year");
            $data['installation_reasons'] = "None";
            $data['product_number'] = $this->request->getPost("product_number");
            $data['in_gurantee'] = 0;
            if (isset($_POST["in_wara"])) {
                $data['in_gurantee'] = 1;
            }
            $data['created_by'] = $this->session->get('auth-identity')['id'];
            $requests_service = new RequestsProblemsApi();
            $tech_report = $requests_service->createTechReport($data);
            if (isset($tech_report['id'])) {
                if ($this->request->hasFiles() == true) {
                    foreach ($this->request->getUploadedFiles() as $file) {
                        //die("Islam");
                        $random = new Random();
                        $random_name = $random->uuid() . "." . $file->getExtension();

                        $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                        $data_photo["tech_report_id"] = $tech_report['id'];
                        $data_photo["photo"] = $random_name;
                        $tech_report_photo = $requests_service->addTechReportPhoto($data_photo);


                    }

                }
            }
            if (isset($tech_report['id'])) {
                $data_notes['note'] = $this->request->getPost("note");
                $data_notes["tech_report_id"] = $tech_report['id'];
                $tech_report_note = $requests_service->addTechReportNotes($data_notes);
            }

            if($this->request->getPost("request_status")){
                $ticket = Tickets::findFirst(["id={$data['ticket_id']}"]);
                $ticket->ticket_status_id =  $this->request->getPost("request_status");
                $ticket->save();
            }
        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }



    public function add_tech_report_photoAction($tech_report_id){
        if(!$this->request->isPost()){
            die("Wrong Request");
        }
        $tech_report_id =(int)$tech_report_id;
        $requests_service = new RequestsProblemsApi();

        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                //die("Islam");
                $random = new Random();
                $random_name = $random->uuid() . "." . $file->getExtension();
                $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                $data_photo["tech_report_id"] = $tech_report_id;
                $data_photo["photo"] = $random_name;
                $tech_report_photo = $requests_service->addTechReportPhoto($data_photo);

            }

        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);


    }

    public function deleteRequestAction($id){
        $ticket = Tickets::findFirst(["id={$id}"]);
        if($ticket){
            $ticket->delete();
        }
        $ticket_history = TicketHistory::find(["ticket)id={$id}"]);
        foreach ($ticket_history as $ticket_his){
            $ticket_his->delete();
        }
        $this->flashSession->success("Deleted Successfully");
        return $this->response->redirect("maintenance_module/requests/index");
    }

    public function testAction()
    {
        $search_param = [];
        $requests = new RequestsProblemsApi();
        $search = $requests->getStatistics($search_param);

    }

    public function fast_searchAction(){

    }

    public function fast_search_client_autocompleteAction(){
        $this->view->disable();
        $this->response->setContentType('application/json', 'UTF-8');
        $q = $this->request->getQuery("q");
        $array["suggestions"]=[];
        $users = UsersMobile::find(["Title like '%{$q}%' AND category_id!='null'"]);
        foreach ($users as $user){
            $array["suggestions"][]=$user->Title;
        }
       // $array["suggestions"] = ["United Arab Emirates", "United Kingdom", "United States"];
        echo json_encode($array);

    }

    public function getClientsAjaxAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $page= 1;
        if($this->request->getQuery("page")){
           $page = $this->request->getQuery("page");
        }
        $builder = $this->modelsManager->createBuilder()->from(['client'=>UsersMobile::class])
            ->where('client.is_admin = 0')
            ->andWhere('client.category_id is not null');
        $client_name = $this->request->getPost("client_name");
        $client_mobile = $this->request->getPost("client_mobile");
        if($client_name && $client_name!=""){
          $builder->andWhere("client.Title like '%{$client_name}%'");
        }
        if($client_mobile && $client_mobile!=""){
            $builder->andWhere("client.Mobile ='{$client_mobile}'");
        }
        $paginator = new PaginatorQueryBuilder([
            'builder' => $builder,
            'limit'   => 5,
            'page'    => $page
        ]);
        $this->view->page   = $paginator->getPaginate();
        $this->view->fast_search = 0;
    }

    public function add_fast_clientAction(){
        if(!$this->request->isPost()){
            die;
        }
//        $validator = new RequestValidation($this->request);
//        $validation_result = $validator
//            ->required(['name','mobile']);
//            // ->required(['region_id','city_id','branch_id'])
//
//
//        if(count($validation_result))
//        {
//            $this->session->set('error_msgs', $validation_result);
//
//            return $this->response->redirect($this->url_shared->get('maintenance_module/requests/new'));
//
//        }
        $name               = $this->request->getPost('name');
        $email              = $this->request->getPost('email');
        $category_id        = 6;
        $mobile             = $this->request->getPost('mobile');
        $password           = 12345;
        $confirm_password   = 12345;
        $region_id          = $this->request->getPost('region');

        if(!$email || $email==""){
            $random = new \Phalcon\Security\Random();
            $email= "{$random->base64Safe(8)}@arabiatanks.com";
        }
        if(UsersMobile::emailExists($email))
        {
            $error_msg['field'] = 'email';
            $error_msg['message'] = 'تم تسجيل الدخول بهذا البريد الالكتروني من قبل';

            $this->flashSession->error("Email Exists");

            return $this->response->redirect($this->url_shared->get('maintenance_module/requests/new'));

        }
        $client = new UsersMobile;
        $client->Title          = $name;
        $client->Mail           = $email;
        $client->category_id    = $category_id;
        $client->Mobile         = $mobile;
        $client->Pass           = (isset($password) && strlen($password) > 0)?$this->security->hash($password):$client->Pass;
        $client->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $client->Active         = 1;
        $client->Module_ID         = 20002;
        if(!$client->save())
        {
            foreach ($client->getMessages() as $error){
                $this->flashSession->error($error);
            }
            return $this->response->redirect($this->url_shared->get('maintenance_module/requests/new'));
        }
        $gender = 1;
        $birthdate="10/12/1987";
        $user_data = new UserData();
        $user_data->user_id   = $client->ID;
        $user_data->gender_id = $gender;
        $user_data->birthdate = strtotime($birthdate);
        $user_data->region_id = (isset($region_id) && strlen($region_id)>0)?$region_id:null;
        $user_data->city_id   = (isset($city_id) && strlen($city_id)>0)?$city_id:null;
        $user_data->supervisor_comment = "";
        $user_data->branch_id          = (isset($branch_id)&&strlen($branch_id)>0)?$branch_id:null;
        $user_data->company_name       = "";
        $user_data->postal_code        = "";
        if(!$user_data->save())
        {
            foreach ($user_data->getMessages() as $error){
                $this->flashSession->error($error);
            }
            return $this->response->redirect($this->url_shared->get('maintenance_module/requests/new'));
        }

        $address=[];
        $client_address = new UserAddresses();

        $client_address->user_id     = $client->ID;
        $client_address->city_id     = (isset($address['city'])&&strlen($address['city'])>0)?$address['city']:null;
        $client_address->region_id   = (isset($address['region'])&&strlen($address['region'])>0)?$address['region']:null;
        $client_address->details     = (isset($address['details']) && strlen($address['details']) > 0)?$address['details']:'no address';
        $client_address->postal_code = 0000;
        $client_address->is_main     = (isset($address['is_main']))?1:0;
        if(!$client_address->save())
        {
            foreach ($client_address->getMessages() as $error){
                $this->flashSession->error($error);
            }
            return $this->response->redirect($this->url_shared->get('maintenance_module/requests/new'));
        }
        $this->flashSession->success("تمت اضافة عميل جديد بنجاح");
        return $this->response->redirect($this->url_shared->get("maintenance_module/requests/new?client={$client->ID}"));

    }

    public function tech_report_photo_deleteAction($pic_id){
        $photo = TicketsTechReportPhotos::findFirst(["id={$pic_id}"]);
        if($photo){
            if(file_exists(BASE_PATH."/public/uploads/".$photo->photo)){
                unlink(BASE_PATH."/public/uploads/".$photo->photo);
            }
            $photo->delete();
            $this->flashSession->success("تم مسح الصورة بنجاح");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);

        }else{
            return $this->response->redirect($_SERVER['HTTP_REFERER']);

        }


    }
    public function client_requests_ajaxAction($id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $requests_service = new RequestsProblemsApi();
        $search_param["client_id"]=$id;
        $result = $requests_service->search($search_param);
        $this->view->result = $result;
        print_r($result);
        die;
    }
    public function ticket_historyAction($ticket_id){
        $this->view->disable();
        $this->response->setContentType('application/json', 'UTF-8');
        $ticket_id = (int)$ticket_id;
        $request_service = new RequestsProblemsApi();
        $result = $request_service->ticket_history($ticket_id);
        echo json_encode($result);
    }

    public function requests_table_branchAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $user_branch_id=$this->session->get('auth-identity')['user_info']["branch"];
        $user_rules=$this->session->get('auth-identity')["rules"];
        if(!array_key_exists(1,$user_rules)){
            //$search_param["order_company_branch_id"] = $user_branch_id;
        }
        //$search_param["order_company_branch_id"] = $user_branch_id;
        $search_param["user_allowed_branches"]= $this->session->get('auth-identity')['user_info']["allowed_branches"];
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
        $this->view->fast_search= 0;
        //Check if the request from the fast search page
        $fast_search= $this->request->getQuery("fast");
        if($fast_search==1){
            $this->view->fast_search= 1;
        }
    }

}



