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


class ErrorController extends ControllerApiBase{
    public function initialize() {
        $_REQUEST = array_map(array($this, 'SecureInputs'), $_REQUEST);
        $_POST = array_map(array($this, 'SecureInputs'), $_POST);
        $_GET = array_map(array($this, 'SecureInputs'), $_GET);
        $this->view->setTemplateBefore('error_page');
        $this->view->translate  = $this->getTranslation();
    }
    public function indexAction(){
        $this->view->disable();
        var_dump($_SESSION);die;
            $this->view->BlockErrors=$_SESSION['BlockErrors'];
    }
}

