<?php
namespace Vokuro\Cms\Controllers;
use Vokuro\Controllers\ControllerBase;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;
use \UsersApplicationModule;

class UsersApplicationModuleController extends ControllerBase {
    /**
     * Index action
     */
    public function indexAction() {
        $rule_ids = array();
        $rules = \Vokuro\Models\UsersUsersRules::find(array("user_id = {$this->session->get('auth-identity')['id']}"));
        foreach($rules as $rule) {
            $rule_ids[] = $rule->rule_id;
        }

        $this->persistent->parameters = null;

        $modules = UsersApplicationModule::find(
            array(
                "Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
            )
        );
        $language = $this->session->get('auth-identity')['Lang'];
        $lang=\Languages::findFirst(["code='{$language}'"]);
		$lang_id= $lang->id;
		$modules_array=[];
		foreach($modules as $module){
			$row['mod_id']=$module->ID;
			$get_title= \UsersApplicationModuleLang::findFirst(["lang_id={$lang_id} and module_id={$module->ID}"]);
			if($get_title){
				$row['mod_title']= $get_title->title;
			}else{
				$row['mod_title']= $module->Title;
            }
			$row['mod_img']= $module->Settings->Img;
            $modules_array[] = $row;
		}
		$this->view->modules_array=$modules_array;
        $this->view->Modules = $modules;

        //Application Settings 16/4/2017
		$settings= \CpApplicationSettings::findFirst(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
		if(!$settings){
			$settings = new \CpApplicationSettings();
			$settings->Application_ID=$this->session->get('auth-identity')['Application_ID'];
			$settings->save();
		}
		$this->view->application_settings= $settings;

        $clients_custom_module_data['name'] = 'العملاء';
        $clients_custom_module_data['image'] = $this->url->getStatic('images/clients/deal.png');
        $clients_custom_module_data['actions']['view'] = [
        'name' => "عرض العملاء",
        'link' => $this->url->get('clients/index')
        ];
        $this->view->custom_client = $clients_custom_module_data;

    }

    /**
     * Searches for users_application_module
     */
    public function searchAction()
    {
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'UsersApplicationModule', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";

        $users_application_module = UsersApplicationModule::find($parameters);
        if (count($users_application_module) == 0) {
            $this->flash->notice("The search did not find any users_application_module");

            $this->dispatcher->forward([
                "controller" => "users_application_module",
                "action" => "index"
            ]);

            return;
        }

        $paginator = new Paginator([
            'data' => $users_application_module,
            'limit'=> 10,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
    }

}
