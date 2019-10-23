<?php
 
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;


class DataFormsLangController extends ControllerBase
{
    /**
     * Index action
     */
    public function indexAction()
    {
        $this->persistent->parameters = null;
    }

    /**
     * Searches for data_forms_lang
     */
    public function searchAction()
    {
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataFormsLang', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";

        $data_forms_lang = DataFormsLang::find($parameters);
        if (count($data_forms_lang) == 0) {
            $this->flash->notice("The search did not find any data_forms_lang");

            $this->dispatcher->forward([
                "controller" => "data_forms_lang",
                "action" => "index"
            ]);

            return;
        }

        $paginator = new Paginator([
            'data' => $data_forms_lang,
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
     * Edits a data_forms_lang
     *
     * @param string $ID
     */
    public function editAction($ID)
    {
        if (!$this->request->isPost()) {

            $data_forms_lang = DataFormsLang::findFirstByID($ID);
            if (!$data_forms_lang) {
                $this->flash->error("data_forms_lang was not found");

                $this->dispatcher->forward([
                    'controller' => "data_forms_lang",
                    'action' => 'index'
                ]);

                return;
            }

            $this->view->ID = $data_forms_lang->ID;

            $this->tag->setDefault("ID", $data_forms_lang->ID);
            $this->tag->setDefault("Title", $data_forms_lang->Title);
            $this->tag->setDefault("Form_ID", $data_forms_lang->Form_ID);
            $this->tag->setDefault("Lang_ID", $data_forms_lang->Lang_ID);
            
        }
    }

    /**
     * Creates a new data_forms_lang
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "data_forms_lang",
                'action' => 'index'
            ]);

            return;
        }

        $data_forms_lang = new DataFormsLang();
        $data_forms_lang->Title = $this->request->getPost("Title");
        $data_forms_lang->Form_ID = $this->request->getPost("Form_ID");
        $data_forms_lang->Lang_ID = $this->request->getPost("Lang_ID");
        

        if (!$data_forms_lang->save()) {
            foreach ($data_forms_lang->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms_lang",
                'action' => 'new'
            ]);

            return;
        }

        $this->flash->success("data_forms_lang was created successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms_lang",
            'action' => 'index'
        ]);
    }

    /**
     * Saves a data_forms_lang edited
     *
     */
    public function saveAction()
    {

        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "data_forms_lang",
                'action' => 'index'
            ]);

            return;
        }

        $ID = $this->request->getPost("ID");
        $data_forms_lang = DataFormsLang::findFirstByID($ID);

        if (!$data_forms_lang) {
            $this->flash->error("data_forms_lang does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "data_forms_lang",
                'action' => 'index'
            ]);

            return;
        }

        $data_forms_lang->Title = $this->request->getPost("Title");
        $data_forms_lang->Form_ID = $this->request->getPost("Form_ID");
        $data_forms_lang->Lang_ID = $this->request->getPost("Lang_ID");
        

        if (!$data_forms_lang->save()) {

            foreach ($data_forms_lang->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms_lang",
                'action' => 'edit',
                'params' => [$data_forms_lang->ID]
            ]);

            return;
        }

        $this->flash->success("data_forms_lang was updated successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms_lang",
            'action' => 'index'
        ]);
    }

    /**
     * Deletes a data_forms_lang
     *
     * @param string $ID
     */
    public function deleteAction($ID)
    {
        $data_forms_lang = DataFormsLang::findFirstByID($ID);
        if (!$data_forms_lang) {
            $this->flash->error("data_forms_lang was not found");

            $this->dispatcher->forward([
                'controller' => "data_forms_lang",
                'action' => 'index'
            ]);

            return;
        }

        if (!$data_forms_lang->delete()) {

            foreach ($data_forms_lang->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "data_forms_lang",
                'action' => 'search'
            ]);

            return;
        }

        $this->flash->success("data_forms_lang was deleted successfully");

        $this->dispatcher->forward([
            'controller' => "data_forms_lang",
            'action' => "index"
        ]);
    }

}
