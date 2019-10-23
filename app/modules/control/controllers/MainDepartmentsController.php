<?php

namespace Vokuro\Control\Controllers;

use \DataCmsDepts;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;


class MainDepartmentsController extends ModuleBase {

    const UPLOAD_LOCATION = 'uploads/';

    public function indexAction($Module_ID){
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataCmsDepts', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";
        //die(var_dump($parameters));

        $departments = DataCmsDepts::find(["Module_ID={$Module_ID}"]);

        if (count($departments) == 0) {

        }


        $paginator = new Paginator([
            'data' => $departments,
            'limit'=> 10,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
		$this->view->Module_ID= $Module_ID;
    }

    public function editAction($ID){

        $Application = \UsersApplication::findFirst(["ID= {$this->session->get('auth-identity')['Application_ID']}"]);
        if (count($Application->Langs) == 0) {
            $this->view->has_langs = 0;
        } else {
            $this->view->has_langs = 1;
            $application_languages = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND is_default=0"]);
            $this->view->langs = $application_languages;

        }
        if (!$this->request->isPost()) {

            $dept = DataCmsDepts::findFirstByID($ID);
            if (!$dept) {
                $this->flash->error("Department was not found");

                $this->dispatcher->forward([
                    'controller' => "Departments",
                    'action' => 'index'
                ]);

                return;
            }

            $this->view->ID = $dept->ID;
            $this->view->Module_ID = $dept->Module_ID;
            $this->tag->setDefault("ID", $dept->ID);
            $this->tag->setDefault("Title", $dept->Title);
            $this->tag->setDefault("Des", $dept->Des);
            $this->tag->setDefault("Img", $dept->Img);
            $this->tag->setDefault("Module_ID", $dept->Module_ID);
            $this->tag->setDefault("Target_Layout_ID", $dept->Target_Layout_ID);
            $this->tag->setDefault("Target_Action_ID", $dept->Target_Action_ID);
            if (isset($_GET['lang_id'])) {
                $lang_id = $_GET['lang_id'];
                $data_cms_lang = \DataCmsDeptsLang::findFirst(["core_dept_id={$ID} AND lang_id={$lang_id}"]);
                $this->tag->setDefault("Title", $data_cms_lang->title);
                $this->tag->setDefault("Des", $data_cms_lang->des);
            }


        }

    }

    public function newAction($Module_ID){
        $this->tag->setDefault("Module_ID", $Module_ID);
        $this->view->Module_ID = $Module_ID;
    }

    public function createAction(){
        if (!$this->request->isPost()) {
            $this->dispatcher->forward(
                [
                    "controller" => "content",
                    "action"     => "index",
                ]
            );
        }
        //die(var_dump($_POST));

        $dept = new DataCmsDepts();
        $dept->Title = $this->request->getPost("Title");
        $dept->Des = $this->request->getPost("Des");
        if ($this->request->hasFiles() == true) {
           // die("islam");
            foreach ($this->request->getUploadedFiles() as $file) {
                $random= new Random();
                $random_name = $random->uuid().".".$file->getExtension ();
                if($file->getName() != "") {
                    $dept->Img = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION . $random_name );
                }
            }
        }

        $dept->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $dept->Module_ID = $this->request->getPost("Module_ID");
        $dept->Target_Layout_ID = $this->request->getPost("Target_Layout_ID");;
        $dept->Target_Action_ID = $this->request->getPost("Target_Action_ID");;
        if (!$dept->save()) {

            foreach ($dept->getMessages() as $message) {
                $this->flash->error($message);
            }

//            $this->dispatcher->forward([
//                'controller' => "departments",
//                'action' => 'edit',
//                'params' => [$dept->ID]
//            ]);

            return;
        }

        $this->flashSession->success("Main Department was Added successfully");
		return $this->response->redirect($_SERVER['HTTP_REFERER']);



    }

    public function saveAction()
    {

        if (!$this->request->isPost()) {
            die("Not Allowed");

            return;
        }

        $ID = $this->request->getPost("ID");
        $dept = DataCmsDepts::findFirst($ID);
        if (!$dept) {
            $this->flash->error("Department does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "Departments",
                'action' => 'index'
            ]);

            return;
        }

        //handling translated content
        if (isset($_GET['lang_id'])) {
            $lang_id = $_GET['lang_id'];
            $data_cms_lang = \DataCmsDeptsLang::findFirst("core_dept_id={$ID} AND lang_id={$lang_id}");
            if ($data_cms_lang) {
                $data_cms_lang->title = $this->request->getPost("Title");
                $data_cms_lang->des = $this->request->getPost("Des");
                $data_cms_lang->save();
            } else {
                $data_cms_lang = new \DataCmsDeptsLang();
                $data_cms_lang->lang_id = $lang_id;
                $data_cms_lang->title = $this->request->getPost("Title") ?: "";
                $data_cms_lang->des = $this->request->getPost("Des") ?: "";
                $data_cms_lang->core_dept_id=$ID;
                if(!$data_cms_lang->save()){
                    foreach($data_cms_lang->getMessages() as $message){
                        $this->flashSession->error($message);
                    }
                }

            }


        } else {
            $dept->Title = $this->request->getPost("Title");
            $dept->Des = $this->request->getPost("Des");
        }
        if ($this->request->hasFiles() == true) {
            //die("islam");
            foreach ($this->request->getUploadedFiles() as $file) {
                $random= new Random();
                $random_name = $random->uuid().".".$file->getExtension ();
                if($file->getName() != "") {
                    $dept->Img = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION . $random_name );
                }
            }
        }

        $dept->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $dept->Module_ID = $this->request->getPost("Module_ID");
        $dept->Target_Layout_ID = $this->request->getPost("Target_Layout_ID");
        $dept->Target_Action_ID = $this->request->getPost("Target_Action_ID");
        if (!$dept->save()) {

            foreach ($dept->getMessages() as $message) {
                $this->flash->error($message);
            }

//            $this->dispatcher->forward([
//                'controller' => "departments",
//                'action' => 'edit',
//                'params' => [$dept->ID]
//            ]);

            return;
        }

        $this->flashSession->success("Department was updated successfully");
		return $this->response->redirect($_SERVER['HTTP_REFERER']);

//        $this->dispatcher->forward([
//            'controller' => "content",
//            'action' => 'index',
//            'params' => [$content->ID]
//        ]);
    }

    public function deleteAction($ID){
        $dept = DataCmsDepts::findFirstByID($ID);
        if(!$dept){
            $this->flash->error("Department does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "Departments",
                'action' => 'index'
            ]);

            return;
        }
        $dept->delete();
        $this->flash->success("Department was deleted successfully");
    }



}