<?php

namespace Vokuro\Controllers;

use Models\Content;
use Phalcon\Http\Request;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Mvc\Url;
use Vokuro\Forms\AdvancedSearchForm;
use Vokuro\Pentavalue\Keyvalue;
use Phalcon\Mvc\Model\Query\Builder;
use DataTables\DataTable;

class ImportDataController extends ControllerBase
{

    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';

    public function indexAction($Module_ID){
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataCmsImport', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

//        $parameters = $this->persistent->parameters;
//        if (!is_array($parameters)) {
//            $parameters = [];
//        }
//        $parameters["order"] = "ID DESC";
//        //$parameters["where"] = "ID!=8";
//        $parameters[$Module_ID] = "Module_ID";

        $parameters["order"] = "ID DESC";
        $content = \DataCmsImport::find(
            array(
                "Module_ID={$Module_ID}",
                "Order" => "ID Desc"
            ));

        if (count($content) == 0) {

        }

        //toggle
        $paginator = new Paginator([
            'data' => $content,
            'limit' => 8,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
        $this->view->base_uri = $this->config->application->baseUri;
        $this->view->Module_ID = $Module_ID;
        $source_types= \DataCmsImportType::find();
        $depts_sources= \DataCmsDeptsRel::find(array("Module_ID={$Module_ID}"));
        $order_types= \DataCmsImportOrderOption::find();
        $this->view->depts_sources = $depts_sources;
        $this->view->source_types = $source_types;
        $this->view->order_types = $order_types;
    }

    public function createAction(){
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "content",
                'action' => 'index'
            ]);

            return;
        }
        $import_data= new \DataCmsImport();
        $import_data->Depts_ID=(int)$this->request->getPost("Dept");
        $import_data->Name=$this->request->getPost("Name");
        $import_data->Type=(int)$this->request->getPost("Type");
        $import_data->Data=$this->request->getPost("Data");
        $import_data->Order=(int)$this->request->getPost("Order");
        $import_data->Operating_Menu=$this->request->getPost("op_menu");
        $import_data->Content=$this->request->getPost("content");
        $import_data->Module_ID=(int)$this->request->getPost("module");
        $import_data->Application_ID=$this->session->get('auth-identity')['Application_ID'];
        if (!$import_data->save()) {
            foreach ($import_data->getMessages() as $message) {
                $this->flash->error($message);
            }



            return;
        }
        else{
            $this->flash->success("Content was updated successfully");
            $this->dispatcher->forward([
                'controller' => "import_data",
                'action' => 'index',
                'param' => (int)$this->request->getPost("module")
            ]);

            return;

        }

    }

    public function ajaxContentAction($Module_ID)
    {
        if ($this->request->isAjax()) {
            $array = $this->modelsManager->createQuery("SELECT * FROM \DataCmsImport WHERE Module_ID = $Module_ID")
                ->execute()->toArray();
//            foreach ($array as $k => $v) {
//                $array[$k]["Date"] = date('m/d/Y', $v["DateTime"]);
//                $array[$k]["Time"] = date('H:i:s', $v["DateTime"]);
//            }
            $dataTables = new DataTable();
            // die(print_R( $array ));
            $dataTables->fromArray($array)->sendResponse();
        }

    }
    public function editAction($ID){
        if($this->request->isPost()){
            $ID=(int)$this->request->getPost("ID");
            $content= \DataCmsImport::findFirst(array("ID ={$ID}"));
            $content->Module_ID = (int)$this->request->getPost('module');
            $content->Depts_ID = (int)$this->request->getPost('Dept');
            $content->Data = $this->request->getPost('Data');
            $content->Name = $this->request->getPost('Name');
            $content->Order =(int)$this->request->getPost('Order');
            $content->Operating_Menu = $this->request->getPost('op_menu');
            $content->Content = $this->request->getPost('Content');
            $content->Type = $this->request->getPost('Type');
            if(!$content->save()){
                foreach ($content->getMessages() as $message) {
                    $this->flash->error($message);
                }

                $source_types= \DataCmsImportType::find();
                $depts_sources= \DataCmsDeptsRel::find(array("Module_ID={$content->Module_ID}"));
                $order_types= \DataCmsImportOrderOption::find();
                $this->view->depts_sources = $depts_sources;
                $this->view->source_types = $source_types;
                $this->view->order_types = $order_types;
                $this->view->ID = $ID;
                $this->view->Module_ID = $content->Module_ID;
                return;
            }
            else{
                $source_types= \DataCmsImportType::find();
                $depts_sources= \DataCmsDeptsRel::find(array("Module_ID={$content->Module_ID}"));
                $order_types= \DataCmsImportOrderOption::find();
                $this->view->depts_sources = $depts_sources;
                $this->view->source_types = $source_types;
                $this->view->order_types = $order_types;
                $this->view->ID = $ID;
                $this->view->Module_ID = $content->Module_ID;
                $this->flash->success("Content was updated successfully");
            }
        }
        else{
            $content= \DataCmsImport::findFirst(array("ID={$ID}"));
            $this->tag->setDefault("Dept", $content->Depts_ID);
            $this->tag->setDefault("Name", $content->Name);
            $this->tag->setDefault("Data", $content->Data);
            $this->tag->setDefault("Order", $content->Order);
            $this->tag->setDefault("Type", $content->Type);
            $this->tag->setDefault("op_menu", $content->Operating_Menu);
            $this->tag->setDefault("Content", $content->Content);
            $this->view->Module_ID = $content->Module_ID;
            $source_types= \DataCmsImportType::find();
            $depts_sources= \DataCmsDeptsRel::find(array("Module_ID={$content->Module_ID}"));
            $order_types= \DataCmsImportOrderOption::find();
            $this->view->depts_sources = $depts_sources;
            $this->view->source_types = $source_types;
            $this->view->order_types = $order_types;
            $this->view->ID = $ID;
        }
    }
}