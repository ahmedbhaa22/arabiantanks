<?php
namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Models\DataForms;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Security;

class DataFormsController extends ControllerBase
{
    /**
     * Index action
     */
    public function indexAction()
    {
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataForms', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";



        $content = DataForms::find(array(
            "Application_ID={$this->session->get('auth-identity')['Application_ID']}",
            "order" =>"ID Desc"
        ));

        if (count($content) == 0) {
            $this->flash->notice("The search did not find any data_cms");

            $this->dispatcher->forward([
                "controller" => "content",
                "action" => "index"
            ]);

            return;
        }


        $paginator = new Paginator([
            'data' => $content,
            'limit' => 2,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
        $this->view->Modules = \UsersApplicationModule::find();
       // $this->view->Module_ID= $Module_ID;
    }

    /**
     * Searches for data_forms
     */


    /**
     * Displays the creation form
     */
    public function newAction()
    {

    }

    /**
     * Edits a data_form
     *
     * @param string $ID
     */
    public function editAction($ID)
    {
        if (!$this->request->isPost()) {

            $data_form = DataForms::findFirstByID($ID);
            if (!$data_form) {
                $this->flash->error("data_form was not found");

                $this->dispatcher->forward([
                    'controller' => "data_forms",
                    'action' => 'index'
                ]);

                return;
            }

            $this->view->ID = $data_form->ID;

            $this->tag->setDefault("ID", $data_form->ID);
            $this->tag->setDefault("Application_ID", $data_form->Application_ID);
            $this->tag->setDefault("Type", $data_form->Type);
            $this->tag->setDefault("Module_ID", $data_form->Module_ID);
            $this->tag->setDefault("Target_Module_ID", $data_form->Target_Module_ID);
            $this->tag->setDefault("Target_Action_ID", $data_form->Target_Action_ID);
            $this->tag->setDefault("Target_Layout_ID", $data_form->Target_Layout_ID);
            $this->tag->setDefault("Login", $data_form->Login);
            $this->tag->setDefault("Api", $data_form->Api);
            $this->tag->setDefault("Notifications", $data_form->Notifications);
            $this->tag->setDefault("See_Responses", $data_form->See_Responses);

        }
    }

    /**
     * Creates a new data_form
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "data_forms",
                'action' => 'index'
            ]);

            return;
        }

        $data_form = new DataForms();
        $data_form->Application_ID = $this->request->getPost("Application_ID");
        $data_form->Type = $this->request->getPost("Type");
        $data_form->Module_ID = $this->request->getPost("Module_ID");
        $data_form->Target_Module_ID = $this->request->getPost("Target_Module_ID");
        $data_form->Target_Action_ID = $this->request->getPost("Target_Action_ID");
        $data_form->Target_Layout_ID = $this->request->getPost("Target_Layout_ID");
        $data_form->Login = $this->request->getPost("Login");
        $data_form->Api = $this->request->getPost("Api");
        $data_form->Notifications = $this->request->getPost("Notifications");
        $data_form->See_Responses = $this->request->getPost("See_Responses");
        

        if (!$data_form->save()) {
            foreach ($data_form->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms",
                'action' => 'new'
            ]);

            return;
        }

        $this->flash->success("data_form was created successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms",
            'action' => 'index'
        ]);
    }

    /**
     * Saves a data_form edited
     *
     */
    public function saveAction()
    {

        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "data_forms",
                'action' => 'index'
            ]);

            return;
        }

        $ID = $this->request->getPost("ID");
        $data_form = DataForms::findFirstByID($ID);

        if (!$data_form) {
            $this->flash->error("data_form does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "data_forms",
                'action' => 'index'
            ]);

            return;
        }

        $data_form->Application_ID = $this->request->getPost("Application_ID");
        $data_form->Type = $this->request->getPost("Type");
        $data_form->Module_ID = $this->request->getPost("Module_ID");
        $data_form->Target_Module_ID = $this->request->getPost("Target_Module_ID");
        $data_form->Target_Action_ID = $this->request->getPost("Target_Action_ID");
        $data_form->Target_Layout_ID = $this->request->getPost("Target_Layout_ID");
        $data_form->Login = $this->request->getPost("Login");
        $data_form->Api = $this->request->getPost("Api");
        $data_form->Notifications = $this->request->getPost("Notifications");
        $data_form->See_Responses = $this->request->getPost("See_Responses");
        

        if (!$data_form->save()) {

            foreach ($data_form->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms",
                'action' => 'edit',
                'params' => [$data_form->ID]
            ]);

            return;
        }

        $this->flash->success("data_form was updated successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms",
            'action' => 'index'
        ]);
    }

    /**
     * Deletes a data_form
     *
     * @param string $ID
     */
    public function deleteAction($ID)
    {
        $data_form = DataForms::findFirstByID($ID);
        if (!$data_form) {
            $this->flash->error("data_form was not found");

            $this->dispatcher->forward([
                'controller' => "data_forms",
                'action' => 'index'
            ]);

            return;
        }

        if (!$data_form->delete()) {

            foreach ($data_form->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms",
                'action' => 'search'
            ]);

            return;
        }

        $this->flash->success("data_form was deleted successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms",
            'action' => "index"
        ]);
    }

    public function searchAction(){
        if ($this->request->isPost()) {
            $numberPage = 1;
            $Title=$this->request->getPost("Title");
            $Type=$this->request->getPost("Type");
            $Module=$this->request->getPost("Module");
            $search = new DataForms();
            $content=$this->modelsManager->createQuery("SELECT Forms.*,Lang.* FROM Models\DataForms AS Forms
        INNER JOIN \DataFormsLang AS Lang ON Lang.Form_ID = Forms.ID
        WHERE Lang.Title LIKE '%" . $Title . "%' AND Forms.Module_ID={$Module} AND Forms.Type LIKE '%" . $Type . "%'
        ")->execute();

            $paginator = new Paginator([
                'data' => $content,
                'limit'=> 2,
                'page' => $numberPage,
            ]);
            $this->view->page = $paginator->getPaginate();
            $this->view->Modules = \UsersApplicationModule::find();
            $this->view->Title = $Title;
            $this->view->Type = $Type;
            $this->view->Module = $Module;
            return;
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }
        $Title=$this->request->getQuery("Title");
        $Type=$this->request->getQuery("Type");
        $Module=$this->request->getQuery("Module","int");
        $search = new DataForms();
        $content=$this->modelsManager->createQuery("SELECT Forms.*,Lang.* FROM Models\DataForms AS Forms
        INNER JOIN \DataFormsLang AS Lang ON Lang.Form_ID = Forms.ID
        WHERE Lang.Title LIKE '%" . $Title . "%' AND Forms.Module_ID={$Module} AND Forms.Type LIKE '%" . $Type . "%'
        ")->execute();
//        $test = $this->modelsManager->createBuilder()
//            ->from('Models\DataForms')
//            ->leftJoin('DataFormsLang', 'DataFormsLang.Form_ID = Models\DataForms.ID')
//            ->where('TABLE1.id = :id:', array('id' => $id))
//            ->getQuery()
//            ->execute();
        $paginator = new Paginator([
            'data' => $content,
            'limit'=> 2,
            'page' => $numberPage,
        ]);
        $this->view->Title = $Title;
        $this->view->Type = $Type;
        $this->view->Module = $Module;
        $this->view->page = $paginator->getPaginate();
        $this->view->Modules = \UsersApplicationModule::find();
    }

}
