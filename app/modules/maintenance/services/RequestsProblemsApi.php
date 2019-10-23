<?php
namespace Vokuro\Maintenance\Services;
use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Models\TicketHistory;
use Vokuro\Maintenance\Models\Tickets;
use Vokuro\Maintenance\Models\TicketsTechReportNotes;
use Vokuro\Maintenance\Models\TicketsTechReportPhotos;
use Vokuro\Maintenance\Models\TicketsTechReports;
use Vokuro\Models\CompanyBranches;


class RequestsProblemsApi extends Component{
    public function search($search_param=null){

        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            // Get Parent Department
            $child = \DataCmsDeptsRel::find(["Parent_Depts_ID={$search_param["dept_id"]}"]);
            $depts_array=[];
            if(count($child)>0){
                foreach ($child as $item){
                    $depts_array[]=$item->ID;
                }

            }
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->inWhere("dept.Depts_ID", $depts_array);
        }
        if(isset($search_param["id"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.id={$search_param['id']}");
        }
        if(isset($search_param["ticket_number"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_number={$search_param['ticket_number']}");
        }

        if(isset($search_param["company_branch_id"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.company_branch_id={$search_param['company_branch_id']}");

        }
        if(isset($search_param["ticket_status_id"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_status_id={$search_param['ticket_status_id']}");
        }
        if(isset($search_param["ticket_problem_id"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_problem_id={$search_param['ticket_problem_id']}");
        }
        if(isset($search_param["date_from"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.created_at >= '{$search_param['date_from']}'");
        }
        if(isset($search_param["date_to"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.created_at <= '{$search_param['date_to']}'");
        }
        if(isset($search_param["category_attribute_value"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.category_attribute_value={$search_param['category_attribute_value']}");
        }
        if(isset($search_param["client_mobile"]) || isset($search_param["client_name"])){
            $builder->leftJoin("Models\UsersMobile", "client.ID = Vokuro\Maintenance\Models\Tickets.client_id", "client");
            if(isset($search_param["client_mobile"])){
                $builder->andWhere("client.Mobile={$search_param['client_mobile']}");
            }
            if(isset($search_param["client_name"])){
                $builder->andWhere("client.Title like '%{$search_param['client_name']}%'");
            }

        }
        if(isset($search_param["client_id"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.client_id={$search_param["client_id"]}");
        }
        if(isset($search_param["data_cms_id"]) && $search_param["data_cms_id"]!=0){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.data_cms_id={$search_param["data_cms_id"]}");
        }
        if(isset($search_param["product_name"])){
            $builder->leftJoin("Models\Content", "product.ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "product");
            $builder->andWhere("product.Title like '%{$search_param['product_name']}%'");
        }
        if(isset($search_param["order_company_branch_id"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.order_company_branch_id={$search_param["order_company_branch_id"]}");
        }
        if(isset($search_param["user_allowed_branches"]) && !empty($search_param["user_allowed_branches"])){
            $builder->inWhere("Vokuro\Maintenance\Models\Tickets.order_company_branch_id",$search_param["user_allowed_branches"]);
        }
        if(isset($search_param["product_type"]) && $search_param["product_type"]!=0){
            $builder->innerJoin("DataCmsDeptsRelItem", "DataCmsDeptsRelItem.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id");
            $builder->andWhere("DataCmsDeptsRelItem.Depts_ID ={$search_param['product_type']}");
        }
        if(isset($search_param["regions"]) && $search_param["regions"]!=0){
            $builder->innerJoin("Vokuro\Models\CompanyBranches", "Vokuro\Models\CompanyBranches.id = Vokuro\Maintenance\Models\Tickets.order_company_branch_id");
            $builder->andWhere("Vokuro\Models\CompanyBranches.region_id ={$search_param['regions']}");
        }
        $builder->orderBy("Vokuro\Maintenance\Models\Tickets.id DESC");
        $open= $builder->getQuery()->execute();
        if(isset($search_param["page"])){
            $page= $search_param["page"];
        }else{
            $page= 1;
        }

        if(isset($search_param["no_pagination"])){
            $res_limit=5000*5000;
        }else{
            $res_limit = 20;
        }
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit" => $res_limit,
                "page" => $page,
            ]
        );
        $result= $this->getPaginationInfo($paginator);
        $result["statistics"] = $this->getStatistics($search_param);
        return $result;
    }

    public function getPaginationInfo(PaginatorQueryBuilder $paginator){
        $result = [];
        $result["items"] =[];
        foreach ($paginator->getPaginate()->items as $info){
            $row= $info->toArray();
            $product_content = $info->getContent();
            //status class in list
            $row["list_status_class"]="label-info";
            $row["view_status_class"]="bg-info";
            switch ($row["ticket_status_id"]){
                case 4:
                    $row["list_status_class"]="label-warning";
                    $row["view_status_class"]="bg-warning";
                    break;
                case 1:
                    $row["list_status_class"]="label-danger";
                    $row["view_status_class"]="bg-danger";
                    break;
                case 3:
                    $row["list_status_class"]="label-success";
                    $row["view_status_class"]="bg-success";
                    break;
                default:
                    $row["list_status_class"]="label-info";
                    $row["view_status_class"]="bg-success";
                    break;
            }
            $row["installation_status_title"] = $info->install_status->title;
            $row["ticket_status_name"] = $info->problem_status->status_name;
            if($info->ticket_pending_reason!=0 ||$info->ticket_pending_reason!=null){
                $row["ticket_pending_reason_name"] = $info->pending_reason->reason_title;
            }
            if($info->ticket_exchange_reason!=0 ||$info->ticket_exchange_reason!=null){
                $row["ticket_exchange_reason_name"] = $info->exchange_reason->reason_title;
            }
            $row["problem_name"] = $info->problem_details->name;
            if( $product_content->getContent_lang(["lang_id=1"])){
                $row["product_name"] = $product_content->getContent_lang(["lang_id=1"])->title;
            }else{
                $row["product_name"] = $product_content->Title;
            }

            $row["product_main_cat"]="";
            $row["product_sub_cat"]="";
            $row["product_main_cat_id"]="";
            $row["product_sub_cat_id"]="";
            $product_depts = $product_content->Depts;
            foreach ($product_depts as $product_dept){
                if($product_dept->DeptDetails->Parent_Depts_ID == 0){
                    $row["product_main_cat_id"]=$product_dept->DeptDetails->ID;
                    $row["product_main_cat"]=$product_dept->DeptDetails->Title;
                }else{
                    $row["product_sub_cat_id"]=$product_dept->DeptDetails->ID;
                    $row["product_sub_cat"]=$product_dept->DeptDetails->Title;
                    // Get Main Cat
                    $row["product_main_cat_id"]=$product_dept->DeptDetails->Parent_Depts_ID;
                    $main_cat= \DataCmsDeptsRel::findFirst(["ID={$product_dept->DeptDetails->Parent_Depts_ID}"]);
                    $row["product_main_cat"]=$main_cat->Title;
                }

            }
            $row["client_name"] = $info->client->Title;
            $row["client_mobile"] = $info->client->Mobile;
            $row["client_address"] = $info->client->shippingAddresses[0]->details;
            $row["client_mail"] = $info->client->Mail;
            $row["maintenance_branch"] = $info->MaintenanceBranch->name;
            if($info->assigned_technician_id !=0){
                $row["assigned_technician_name"] = $info->tech_person->Title;
            }
            $row["tech_report"] = [];
            $row["tech_report"]["notes"] = [];
            $row["tech_report"]["photos"] = [];
            $row["tech_report"]["in_gurantee"]=0;
            $row["tech_report"]["manufacturing_year"]="";
            $row["tech_report"]["region_name"]="";
            $row["tech_report"]["branch_name"]="";
            $row["has_tech_report"]=0;
            //Check if has a technical report
            $tech_reports = $info->tech_report;
            if(count($tech_reports)>0){
                $row["has_tech_report"]=1;
                $row["tech_reports"]=[];
                foreach($tech_reports as $tech_report){
                    $report=$tech_report->toArray();
                    $photos= $tech_report->getPhotos();
                    $notes= $tech_report->getNotes();
                    $report["photos"]=$photos->toArray();
                    $report["notes"]=$notes->toArray();
                    $report["region_name"]="";
                    $report["branch_name"]="";
                    $row["tech_reports"][]=$report;
                }

            }
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

    public function getAllClients(){
        $builder = $this->modelsManager->createBuilder()
            ->from("Models\UsersMobile")
            ->andWhere("Models\UsersMobile.category_id!='NULL'");
        $result = $builder->getQuery()->execute();
        $clients_list = $result->toArray();
        return $clients_list;


    }

    public function createRequest($data){
        $ticket = new Tickets($data);
        if(!$ticket->save()){
            return $ticket->getMessages();
        }
        $ticket = Tickets::findFirst(["id={$ticket->id}"]);
        $ticket->ticket_number=$ticket->id;
        $ticket->save();
        return $ticket->toArray();

    }

    public function createTechReport($data){
        $tech_report = new TicketsTechReports($data);
        if(!$tech_report->save()){
            return $tech_report->getMessages();
        }
        return $tech_report->toArray();
    }

    public function addTechReportPhoto($data){
        $tech_report_photo = new TicketsTechReportPhotos($data);
        if(!$tech_report_photo->save()){
            return $tech_report_photo->getMessages();
        }
        return $tech_report_photo->toArray();
    }

    public function addTechReportNotes($data){
        $tech_report_notes = new TicketsTechReportNotes($data);
        if(!$tech_report_notes->save()){
            return $tech_report_notes->getMessages();
        }
        return $tech_report_notes->toArray();
    }

    public function order_history($order_id){
        $tickets = Tickets::find(["invoice_number={$order_id}"]);
        $order_history=[];
        foreach($tickets as $ticket){
            $history=[];
            $history["ticket_id"] = $ticket->id;
            $ticket_history=TicketHistory::find(["ticket_id={$ticket->id}","order" => "id ASC",]);
            foreach ($ticket_history as $item){
                $row =$item->toArray();
                $row["status_name"]=$item->status->status_name;
                $row["changed_at"]=$this->SharedFunctions->time_elapsed_string($item->changed_at);
                $history["ticket_history"][]=$row;
            }
            $order_history[]=$history;
        }
        return $order_history;
    }


    public function getStatistics($search_param){
        $result= [];
        $builder = $this->modelsManager->createBuilder()
            ->columns(array('count' => 'COUNT(id)'))
            ->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->andWhere("dept.Depts_ID={$search_param['dept_id']}");
        }
        $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_status_id=1");
        $open= $builder->getQuery()->execute();
        $result["open"] =  $open[0]->count;

        $builder = $this->modelsManager->createBuilder()
            ->columns(array('count' => 'COUNT(id)'))
            ->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->andWhere("dept.Depts_ID={$search_param['dept_id']}");
        }
        $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_status_id=2");
        $assigned_tech= $builder->getQuery()->execute();
        $result["assigned_to_tech"] =  $assigned_tech[0]->count;

        $builder = $this->modelsManager->createBuilder()
            ->columns(array('count' => 'COUNT(id)'))
            ->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->andWhere("dept.Depts_ID={$search_param['dept_id']}");
        }
        $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_status_id=3");
        $closed= $builder->getQuery()->execute();
        $result["closed"] =  $closed[0]->count;
        $builder = $this->modelsManager->createBuilder()
            ->columns(array('count' => 'COUNT(id)'))
            ->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->andWhere("dept.Depts_ID={$search_param['dept_id']}");
        }
        $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_status_id=4");
        $pending= $builder->getQuery()->execute();
        $result["pending"] =  $pending[0]->count;

        $builder = $this->modelsManager->createBuilder()
            ->columns(array('count' => 'COUNT(id)'))
            ->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->andWhere("dept.Depts_ID={$search_param['dept_id']}");
        }
        $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_status_id=6");
        $pending_approval= $builder->getQuery()->execute();
        $result["pending_approval"] =  $pending_approval[0]->count;


        $builder = $this->modelsManager->createBuilder()
            ->columns(array('count' => 'COUNT(id)'))
            ->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->andWhere("dept.Depts_ID={$search_param['dept_id']}");
        }
        $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_status_id=8");
        $replace= $builder->getQuery()->execute();
        $result["replace"] =  $replace[0]->count;

        $builder = $this->modelsManager->createBuilder()
            ->columns(array('count' => 'COUNT(id)'))
            ->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->andWhere("dept.Depts_ID={$search_param['dept_id']}");
        }
        $builder->andWhere("Vokuro\Maintenance\Models\Tickets.ticket_status_id=9");
        $replace= $builder->getQuery()->execute();
        $result["sent_to_replace"] =  $replace[0]->count;

        return $result;

    }


}