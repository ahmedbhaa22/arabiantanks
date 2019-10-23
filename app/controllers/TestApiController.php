<?php


namespace Vokuro\Controllers;


use Models\UsersMobile;

use Models\Content;

use Phalcon\Builder\Controller;

use Phalcon\Http\Request;

use Phalcon\Paginator\Adapter\Model as Paginator;

use Phalcon\Mvc\Model\Criteria;

use Phalcon\Security;

use Phalcon\Security\Random;

use Phalcon\Mvc\Url;

use Vokuro\Forms\AdvancedSearchForm;

use Vokuro\Pentavalue\Keyvalue;

use Phalcon\Mvc\Model\QueryBuilder;

use DataTables\DataTable;
use Vokuro\Models\ResetPasswords;


class TestApiController extends ControllerApiBase{
    public function indexAction(){
        $this->view->disable();
        //$filter = json_decode(file_get_contents("php://input"),true);
        $this->response->setContentType('application/json', 'UTF-8');
        //echo json_encode($this->ApiFactory->getDataCmsKeyValues(387));
        echo json_encode($this->CmsSearch->search());
        // echo json_encode($this->CmsSearch->searchInAction('allCmsFollowed'));

        //echo json_encode($this->CmsSearch->switchSearchAction('content_search',$search_param));
    }
    public function testAction(){
        $this->view->disable();
        $keyvalue = new Keyvalue();
        print_r($keyvalue->getKeyvalueEntityOptions(80));

    }
    public function testQueryAction(){
        $this->view->disable();
        $content= Content::find(["Module_ID=8"]);
        die();
    }
}

