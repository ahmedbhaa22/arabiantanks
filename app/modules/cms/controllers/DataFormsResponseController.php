<?php
namespace Vokuro\Cms\Controllers; use Vokuro\Controllers\ControllerBase;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Models\DataFormsResponse;


class DataFormsResponseController extends ControllerBase
{
    /**
     * Index action
     */
    public function indexAction($Form_ID)
    {
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataFormsResponse', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";

        $content = DataFormsResponse::find([
            "Form_ID =".$Form_ID,"order" => "ID Desc"
        ]);
        if (count($content) == 0) {
            $this->flash->notice("The search did not find any Forms");

            $this->dispatcher->forward([
                "controller" => "Data_Forms_Response",
                "action" => "index"
            ]);

            return;
        }


        $paginator = new Paginator([
            'data' => $content,
            'limit' => 20,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
        //$this->view->Module_ID= $Module_ID;
        $this->view->Form_ID = $Form_ID;
        //get form fields in json by slecting any record for the the same form
        $fields = DataFormsResponse::findFirst(array("Form_ID ={$Form_ID}"));
        $this->view->fields = $fields;

    }

    /**
     * Searches for data_forms_response
     */
    public function searchAction()
    {
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataFormsResponse', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";

        $data_forms_response = DataFormsResponse::find($parameters);
        if (count($data_forms_response) == 0) {
            $this->flash->notice("The search did not find any data_forms_response");

            $this->dispatcher->forward([
                "controller" => "data_forms_response",
                "action" => "index"
            ]);

            return;
        }

        $paginator = new Paginator([
            'data' => $data_forms_response,
            'limit'=> 10,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
    }

    /**
     * Displays the creation form
     */
    public function newAction()
    {

    }

    /**
     * Edits a data_forms_response
     *
     * @param string $ID
     */
    public function editAction($ID)
    {
        if (!$this->request->isPost()) {

            $data_forms_response = DataFormsResponse::findFirstByID($ID);
            if (!$data_forms_response) {
                $this->flash->error("data_forms_response was not found");

                $this->dispatcher->forward([
                    'controller' => "data_forms_response",
                    'action' => 'index'
                ]);

                return;
            }

            $this->view->ID = $data_forms_response->ID;

            $this->tag->setDefault("ID", $data_forms_response->ID);
            $this->tag->setDefault("Form_ID", $data_forms_response->Form_ID);
            $this->tag->setDefault("Response", $data_forms_response->Response);
            $this->tag->setDefault("IP", $data_forms_response->IP);
            $this->tag->setDefault("User_ID", $data_forms_response->User_ID);
            $this->tag->setDefault("Date", $data_forms_response->Date);


        }
    }

    /**
     * Creates a new data_forms_response
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "data_forms_response",
                'action' => 'index'
            ]);

            return;
        }

        $data_forms_response = new DataFormsResponse();
        $data_forms_response->Form_ID = $this->request->getPost("Form_ID");
        $data_forms_response->Response = $this->request->getPost("Response");
        $data_forms_response->IP = $this->request->getPost("IP");
        $data_forms_response->User_ID = $this->request->getPost("User_ID");
        $data_forms_response->Date = $this->request->getPost("Date");


        if (!$data_forms_response->save()) {
            foreach ($data_forms_response->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms_response",
                'action' => 'new'
            ]);

            return;
        }

        $this->flash->success("data_forms_response was created successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms_response",
            'action' => 'index'
        ]);
    }

    /**
     * Saves a data_forms_response edited
     *
     */
    public function saveAction()
    {

        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "data_forms_response",
                'action' => 'index'
            ]);

            return;
        }

        $ID = $this->request->getPost("ID");
        $data_forms_response = DataFormsResponse::findFirstByID($ID);

        if (!$data_forms_response) {
            $this->flash->error("data_forms_response does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "data_forms_response",
                'action' => 'index'
            ]);

            return;
        }

        $data_forms_response->Form_ID = $this->request->getPost("Form_ID");
        $data_forms_response->Response = $this->request->getPost("Response");
        $data_forms_response->IP = $this->request->getPost("IP");
        $data_forms_response->User_ID = $this->request->getPost("User_ID");
        $data_forms_response->Date = $this->request->getPost("Date");


        if (!$data_forms_response->save()) {

            foreach ($data_forms_response->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms_response",
                'action' => 'edit',
                'params' => [$data_forms_response->ID]
            ]);

            return;
        }

        $this->flash->success("data_forms_response was updated successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms_response",
            'action' => 'index'
        ]);
    }

    /**
     * Deletes a data_forms_response
     *
     * @param string $ID
     */
    public function deleteAction($ID)
    {
        $data_forms_response = DataFormsResponse::findFirstByID($ID);
        if (!$data_forms_response) {
            $this->flash->error("data_forms_response was not found");

            $this->dispatcher->forward([
                'controller' => "data_forms_response",
                'action' => 'index'
            ]);

            return;
        }

        if (!$data_forms_response->delete()) {

            foreach ($data_forms_response->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms_response",
                'action' => 'search'
            ]);

            return;
        }

        $this->flash->success("data_forms_response was deleted successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms_response",
            'action' => "index"
        ]);
    }

    public function viewAction($ID)
    {
        if (!$this->request->isPost()) {

            $data_forms_response = DataFormsResponse::findFirstByID($ID);
            if (!$data_forms_response) {
                $this->flash->error("data_forms_response was not found");

                $this->dispatcher->forward([
                    'controller' => "data_forms_response",
                    'action' => 'index'
                ]);

                return;
            }

            $this->view->ID = $data_forms_response->ID;
            $this->view->Form_ID = $data_forms_response->Form_ID;
            $this->view->Response = json_decode($data_forms_response->Response);
            $message = json_decode($data_forms_response->Response);
            $this->view->mail_send=$message->email;
//            foreach(json_decode($data_forms_response->Response) as $key=>$value){
//            	if($key=='mail' || $key=='email'){
//            		$this->view->mail_send=$value;
//            	}else{
//                    $this->view->mail_send="";
//                }
//            }
            $this->view->IP = $data_forms_response->IP;
            $this->view->User_ID = $data_forms_response->Date;
            $this->tag->setDefault("ID", $data_forms_response->ID);
            //$this->assets->addJs("js/form_response_replay.js");



        }


    }
    public function replayformAction(){
        $this->view->disable();
        if ($this->request->isPost()) {
            $Application = \UsersApplication::findFirst(array("ID={$this->session->get('auth-identity')['Application_ID']}"));


            if($this->getDI()->getMail()->send(
                array(
                    $this->request->getPost('Email')
                ),
                "Penta Value",
                'replayform',
                array(
                    "Application_Name"=>$Application->Title,
                    "reply"=>$this->request->getPost("Replay")
                )
            )){

                $this->flashSession->success("E-Mail has been sent");
                $cp_forms_replies = new \CpFormsReplies();
                $cp_forms_replies->Date = date('Y-m-d H:i:s',time());
                $cp_forms_replies->Replay = $this->request->getPost("Replay");
                $cp_forms_replies->Forms_Response = $this->request->getPost("ID");
                $cp_forms_replies->User_ID = 0;
                if($cp_forms_replies->save()){
                    //$this->flashSession->success("E-Mail has been stored in DB");
                }
                return  "E-Mail has been sent";


            }



        }

    }



}
