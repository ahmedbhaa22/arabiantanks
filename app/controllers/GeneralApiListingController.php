<?php

namespace Vokuro\Controllers;
use Phalcon\Http\Request;
use Phalcon\Mvc\Router\Group;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Mvc\Url;
use Vokuro\Forms\AdvancedSearchForm;
use Vokuro\Models\Projects;
use Vokuro\Pentavalue\Keyvalue;
use Phalcon\Mvc\Model\Query\Builder;
use DataTables\DataTable;
use \Api;
use \Screen;
use \ScreenMedia;
use Phalcon\Mvc\View;
use Models\Content;
use Models\DataForms;
use Models\DataFormsResponse;
use \UsersApplication;
use \UsersApplicationModule;
class GeneralApiListingController extends ControllerApiBase
{
    public function indexAction(){
        $apps=UsersApplication::find();
        $Applications =[];
        foreach ($apps as $app){
            $Application['App_ID']=$app->ID;
            $Application['App_Name']=$app->Title;
            $Application['Modules']=[];
            if(count($app->Modules)==0){
                continue;
            }
            foreach ($app->Modules as $module){
                $modules['Module_ID']=$module->ID;
                $modules['Module_Title']=$module->Title;
                $Application['Modules'][]=$modules;
            }
            $Applications[]=$Application;
        }
        $this->view->Applications = $Applications;
    }
    public function switchlistAction(){
        $Application_ID= $this->request->getQuery("app");
        $Module_ID= $this->request->getQuery("id");
        $this->view->Application_ID= $Application_ID;
        $this->view->Module_ID= $Module_ID;
		$content=Content::findFirst(["Module_ID={$Module_ID}"]);
		$this->view->content_id= $content->ID;
		$Dept = \DataCmsDeptsRel::findFirst(["Module_ID={$Module_ID}"]);
		$this->view->Depts_ID= $Dept->ID; 
		$Main_Dept = \DataCmsDepts::findFirst(["Module_ID={$Module_ID}"]);
		$this->view->Main_Dept = $Main_Dept->ID;
		$Form = DataForms::findFirst(["Application_ID={$Application_ID}"]);
		$this->view->form_id = $Form->ID;
		if(!$Form){
			$this->view->form_id = 0;
		} ;
		$this->view->Key_ID= 0;
		$this->view->Token = "54564asdqeqwe";
	}
}