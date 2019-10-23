<?php
 
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;


class CpFormsRepliesController extends ControllerBase
{
    /**
     * Index action
     */
    public function indexAction()
    {
        $this->persistent->parameters = null;
    }

    /**
     * Searches for cp_forms_replies
     */
    public function searchAction()
    {
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'CpFormsReplies', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";

        $cp_forms_replies = CpFormsReplies::find($parameters);
        if (count($cp_forms_replies) == 0) {
            $this->flash->notice("The search did not find any cp_forms_replies");

            $this->dispatcher->forward([
                "controller" => "cp_forms_replies",
                "action" => "index"
            ]);

            return;
        }

        $paginator = new Paginator([
            'data' => $cp_forms_replies,
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
     * Edits a cp_forms_replie
     *
     * @param string $ID
     */
    public function editAction($ID)
    {
        if (!$this->request->isPost()) {

            $cp_forms_replie = CpFormsReplies::findFirstByID($ID);
            if (!$cp_forms_replie) {
                $this->flash->error("cp_forms_replie was not found");

                $this->dispatcher->forward([
                    'controller' => "cp_forms_replies",
                    'action' => 'index'
                ]);

                return;
            }

            $this->view->ID = $cp_forms_replie->ID;

            $this->tag->setDefault("ID", $cp_forms_replie->ID);
            $this->tag->setDefault("Forms_Response", $cp_forms_replie->Forms_Response);
            $this->tag->setDefault("Date", $cp_forms_replie->Date);
            $this->tag->setDefault("User_ID", $cp_forms_replie->User_ID);
            $this->tag->setDefault("Replay", $cp_forms_replie->Replay);
            
        }
    }

    /**
     * Creates a new cp_forms_replie
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "cp_forms_replies",
                'action' => 'index'
            ]);

            return;
        }

        $cp_forms_replie = new CpFormsReplies();
        $cp_forms_replie->Forms_Response = $this->request->getPost("Forms_Response");
        $cp_forms_replie->Date = $this->request->getPost("Date");
        $cp_forms_replie->User_ID = $this->request->getPost("User_ID");
        $cp_forms_replie->Replay = $this->request->getPost("Replay");
        

        if (!$cp_forms_replie->save()) {
            foreach ($cp_forms_replie->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "cp_forms_replies",
                'action' => 'new'
            ]);

            return;
        }

        $this->flash->success("cp_forms_replie was created successfully");

        $this->dispatcher->forward([
            'controller' => "cp_forms_replies",
            'action' => 'index'
        ]);
    }

    /**
     * Saves a cp_forms_replie edited
     *
     */
    public function saveAction()
    {

        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "cp_forms_replies",
                'action' => 'index'
            ]);

            return;
        }

        $ID = $this->request->getPost("ID");
        $cp_forms_replie = CpFormsReplies::findFirstByID($ID);

        if (!$cp_forms_replie) {
            $this->flash->error("cp_forms_replie does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "cp_forms_replies",
                'action' => 'index'
            ]);

            return;
        }

        $cp_forms_replie->Forms_Response = $this->request->getPost("Forms_Response");
        $cp_forms_replie->Date = $this->request->getPost("Date");
        $cp_forms_replie->User_ID = $this->request->getPost("User_ID");
        $cp_forms_replie->Replay = $this->request->getPost("Replay");
        

        if (!$cp_forms_replie->save()) {

            foreach ($cp_forms_replie->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "cp_forms_replies",
                'action' => 'edit',
                'params' => [$cp_forms_replie->ID]
            ]);

            return;
        }

        $this->flash->success("cp_forms_replie was updated successfully");

        $this->dispatcher->forward([
            'controller' => "cp_forms_replies",
            'action' => 'index'
        ]);
    }

    /**
     * Deletes a cp_forms_replie
     *
     * @param string $ID
     */
    public function deleteAction($ID)
    {
        $cp_forms_replie = CpFormsReplies::findFirstByID($ID);
        if (!$cp_forms_replie) {
            $this->flash->error("cp_forms_replie was not found");

            $this->dispatcher->forward([
                'controller' => "cp_forms_replies",
                'action' => 'index'
            ]);

            return;
        }

        if (!$cp_forms_replie->delete()) {

            foreach ($cp_forms_replie->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "cp_forms_replies",
                'action' => 'search'
            ]);

            return;
        }

        $this->flash->success("cp_forms_replie was deleted successfully");

        $this->dispatcher->forward([
            'controller' => "cp_forms_replies",
            'action' => "index"
        ]);
    }

}
