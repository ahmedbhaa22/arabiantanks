<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 7/9/2018
 * Time: 12:53 PM
 */

namespace Vokuro\Polls\Controllers;
use Models\SalesVisits;
use Models\TanksPollsVisits;
use Models\UserCategories;
use Vokuro\Controllers\ControllerBase;
use Vokuro\Models\UsersUsersRules;
use Vokuro\Polls\Services\PollVisitsService;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;

class PollsVisitsController extends ControllerBase
{
    public function indexAction(){
        $search_param =[];
        $filter["client_mobile"]="";
        $filter["sales_person"]="";
        $filter["client_name"]="";
        $filter["date_from"]="";
        $filter["date_to"]="";
        $page= $this->request->getQuery("page")?:1;
        if ($this->request->get("client_mobile") && $this->request->get("client_mobile") != "") {
            $filter["client_mobile"] = $this->request->get("client_mobile");
            $search_param["client_mobile"] = $filter["client_mobile"];
            $this->tag->setDefault("client_mobile", $filter["client_mobile"]);
        }
        if ($this->request->get("client_name") && $this->request->get("client_name") != "") {
            $filter["client_name"] = $this->request->get("client_name");
            $search_param["client_name"] = $filter["client_name"];
        }
        if ($this->request->get("sales_person") && $this->request->get("sales_person") != 0) {
            $filter["sales_person"] = $this->request->get("sales_person");
            $search_param["sales_person"] = $filter["sales_person"];
        }
        if ($this->request->get("client_category") && $this->request->get("client_category") != 0) {
            $filter["client_category"] = $this->request->get("client_category");
            $search_param["client_category"] = $filter["client_category"];
        }
        if($this->request->get("date_from")){
            $date_from = new \DateTime($this->request->get("date_from"));
            $search_param["date_from"] = $date_from->format('U');
            $filter["date_from"] =$this->request->get("date_from");
        }
        if($this->request->get("date_to")){
            $date_to = new \DateTime($this->request->get("date_to"));
            $search_param["date_to"] = $date_to->format('U');
            $filter["date_to"] =$this->request->get("date_to");
        }

        $polls_visits_service = new PollVisitsService();
        $paginator = new PaginatorQueryBuilder([
            'builder' => $polls_visits_service->search($search_param),
            'limit'   => 40,
            'page'    => $page
        ]);
        $this->view->page = $paginator->getPaginate();
        //Sales Person
        $sales_persons = UsersUsersRules::find(["rule_id=7"]);
        $this->view->sales_persons = $sales_persons;
        $this->view->filter = $filter;
        $this->view->client_categories = UserCategories::find();

    }
    public function ask_visitAction($visit_id){
        $visit = SalesVisits::findFirst(["id={$visit_id}"]);
        $this->view->client = $visit->getClient();
        $client_data = $visit->getClient()->data ?: null;
        $this->view->client_data= $client_data;
        $this->view->visit= $visit;
    }

    public function delete_visitAction($visit_id){
        $polls_visits = TanksPollsVisits::findFirst(["visit_id={$visit_id}"]);
        $polls_visits->delete();
        $visit = SalesVisits::findFirst(["id={$visit_id}"]);
        $visit->delete();

        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    public function export_excelAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $polls_visits_service = new PollVisitsService();
        if ($this->request->getPost("client_mobile") && $this->request->getPost("client_mobile") != "") {
            $filter["client_mobile"] = $this->request->getPost("client_mobile");
            $search_param["client_mobile"] = $filter["client_mobile"];
            $this->tag->setDefault("client_mobile", $filter["client_mobile"]);
        }
        if ($this->request->getPost("client_name") && $this->request->getPost("client_name") != "") {
            $filter["client_name"] = $this->request->getPost("client_name");
            $search_param["client_name"] = $filter["client_name"];
        }
        if ($this->request->getPost("sales_person") && $this->request->getPost("sales_person") != 0) {
            $filter["sales_person"] = $this->request->getPost("sales_person");
            $search_param["sales_person"] = $filter["sales_person"];
        }
        if($this->request->getPost("date_from")){
            $date_from = new \DateTime($this->request->getPost("date_from"));
            $search_param["date_from"] = $date_from->format('U');
        }
        if($this->request->getPost("date_to")){
            $date_to = new \DateTime($this->request->getPost("date_to"));
            $search_param["date_to"] = $date_to->format('U');
        }
        $search_param["no_pagination"]=1;
        $search_builder = $polls_visits_service->search($search_param);
        $results = $search_builder->getQuery()->execute();
        //Build The Excel Sheet
        $fields_title = ["نوع المهمة","اسم العميل","البريد الالكتروني","تم اضافة العميل بواسطة","رقم تليفون العميل","تاريخ الزيارة","تصنيف العميل","المندوب صاحب الزيارة","تم استبيان العميل أم لا"];
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
        foreach ($results as $item) {
            if(!$item->getVisitDetails()){
                continue;
            }
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $row, $item->VisitDetails->missionType->name_ar);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $row, $item->VisitDetails->client->Title);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(2, $row, $item->VisitDetails->client->Mail);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(3, $row, $item->VisitDetails->client->CreatedBy->Title);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(4, $row, $item->VisitDetails->client->Mobile);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(5, $row, $item->VisitDetails->formattedDate('d/m/Y'));
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(6, $row, $item->VisitDetails->client->category->name);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(7, $row, $item->VisitDetails->salesPerson->Title);
            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow(8, $row, $item->done);


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
        var_dump($_SESSION);
    }
}