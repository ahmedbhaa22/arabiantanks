<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 11/24/2016
 * Time: 3:14 PM
 */
namespace Vokuro\Control\Controllers;

use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Mvc\Url;
use Vokuro\Models\Logs;

class LogController extends ModuleBase
{

    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';
    public function indexAction(){
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'Logs', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "id DESC";


        $logs = Logs::find(array(
            "Model='Content Details'",
            "order" => "id Desc"
        ));

        if (count($logs) == 0) {
            $this->flash->notice("The search did not find any Logs");

            $this->dispatcher->forward([
                "controller" => "content",
                "action" => "main"
            ]);

            return;
        }


        $paginator = new Paginator([
            'data' => $logs,
            'limit' => 30,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
       
    }

    public function userAction($user_id){
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'Logs', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "id DESC";


        $logs = Logs::find(array(
            "user_id={$user_id} AND Model='Content Details'",
            "order" => "id Desc"
        ));

        if (count($logs) == 0) {
            $this->flash->notice("The search did not find any Logs");

            $this->dispatcher->forward([
                "controller" => "content",
                "action" => "main"
            ]);

            return;
        }


        $paginator = new Paginator([
            'data' => $logs,
            'limit' => 30,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();

    }



}
