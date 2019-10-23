<?php
namespace Vokuro\Controllers;

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Db;
use Phalcon\Translate\Adapter\NativeArray;
use Phalcon\Http\Response;
use Models\GeneralNotifications;

/**
 * ControllerBase
 * This is the base controller for all controllers in the application
 */
class ControllerBase extends Controller
{
    protected $dispatcher;
    public $schemes=['scheme_1','scheme_2','scheme_3','scheme_4','scheme_5','scheme_6','scheme_7'];
    public function initialize() {
        $_REQUEST = array_map(array($this, 'SecureInputs'), $_REQUEST);
        $_POST = array_map(array($this, 'SecureInputs'), $_POST);
        $_GET = array_map(array($this, 'SecureInputs'), $_GET);
        $this->view->setTemplateBefore('main');
        $this->view->translate  = $this->getTranslation();
        $external_requests ="(1,3)";
        $notifications = GeneralNotifications::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND external_type_id IN {$external_requests} AND is_read=0 ORDER BY id desc"]);
        $this->view->not_unread = $notifications;
        $this->view->not_unread_count = count($notifications);

        //Check Module And Apply Directories Based in Permissions
        if(array_key_exists(1,$this->session->get('auth-identity')['rules'])){
            $module = $this->router->getModuleName();
            switch($module){
                case "maintenance":
                    $this->view->setLayoutsDir(APP_PATH.'/views/layouts/');
                    break;
                case "polls":
                    $this->view->setLayoutsDir(APP_PATH.'/views/layouts/');
                    break;
                case "sales_visits":
                    $this->view->setLayoutsDir(APP_PATH.'/views/layouts/');
                    break;

            }
        }


		
    }

    /**
     * Execute before the router so we can determine if this is a private controller, and must be authenticated, or a
     * public controller that is open to all.
     *
     * @param Dispatcher $dispatcher
     * @return boolean
     */
    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        //Get the current identity
        $this->dispatcher = $dispatcher;
        $identity = $this->auth->getIdentity();
        
        // If there is no identity available the user is redirected
        if (!is_array($identity)) {
            //die("islam");
            // die();

            $this->response->redirect($this->url_shared->get("session/login"));
            return false;
        }

//        $controllerName = $dispatcher->getControllerName();
//
//        // Only check permissions on private controllers
//        if ($this->acl->isPrivate($controllerName)) {
//
//            // Get the current identity
//            $identity = $this->auth->getIdentity();
//
//            // If there is no identity available the user is redirected to index/index
//            if (!is_array($identity)) {
//
//                $this->flash->notice('You don\'t have access to this module : Please Login');
//
//
//
//            }
//
//            // Check if the user have permission to the current option
//            $actionName = $dispatcher->getActionName();
//            if (!$this->acl->isAllowed($identity['profile'], $controllerName, $actionName)) {
//
//                $this->flash->notice('You don\'t have access to this module: ' . $controllerName . ':' . $actionName);
//
//                if ($this->acl->isAllowed($identity['profile'], $controllerName, 'index')) {
//                    $dispatcher->forward([
//                        'controller' => $controllerName,
//                        'action' => 'index'
//                    ]);
//                } else {
//                    $dispatcher->forward([
//                        'controller' => 'home',
//                        'action' => 'index'
//                    ]);
//                }
//
//                return false;
//            }
//        }
    }

    // TODO : move to a separate class or scrap

    protected function flashMsg($status, $msg) {

        $this->flash->{$status}(
                $msg
        );
    }

    /**
     * sets the response for json
     * @param mixed $data
     * @return Phalcon\Http\Response
     */
    public function sendJson($data, $status_code = 200) {
        $this->view->disable();
        $this->response->setContentType('application/json', 'UTF-8');
        $this->response->setStatusCode($status_code);
        $this->response->setContent(json_encode($data));
        return $this->response;
    }

    /**
     * redirects back to previous page
     */
    protected function redirectBack() {
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    public function getModules(){
        $Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $modules = \UsersApplicationModule::find([
            'Application_ID = '.$Application_ID
        ]);
        $modules_array = array();
        foreach ($modules as $module){
            $modules_array[]= $module->ID;
        }
        return $modules_array;
    }

    protected function getTranslation()
    {
        if(isset($this->session->get('auth-identity')['Lang'])){
            $language = $this->session->get('auth-identity')['Lang'];
        }else{
            $language = "ar";
        }
		$lang=\Languages::findFirst(["code='{$language}'"]);
        $lang_id=$lang->id;
		
		$system_translation= \CpSystemTranslation::find("lang_id={$lang_id}");
		$messages=[];
		foreach ($system_translation as $key => $value) {
			$messages[$value->word_key]= $value->value;
		}	 

        // Return a translation object
                return new NativeArray(
            [
                "content" => $messages,
            ]
        );
    }

    public function getAdvancedTranslation($module,$string,$dept_id=0)
    {
        if(isset($this->session->get('auth-identity')['Lang'])){
        	
            if($this->session->get('auth-identity')['Lang']==""){
                $cp_profile = new \CpUserProfile();
                $cp_profile->User_ID = $this->session->get('auth-identity')['id'];
                $cp_profile->Profile_ID = 1;
                $cp_profile->banned= "N";
                $cp_profile->suspended= "N";
                $cp_profile->active= "Y";
                $cp_profile->Cp_Lang= "en";
                $cp_profile->Scheme_File= "scheme_6";
                if(!$cp_profile->save()){print_r($cp_user->getMessages());die;};
                $language = $cp_profile->Cp_Lang;
                $lang=\Languages::findFirst(["code='{$language}'"]);
                $lang_id=$lang->id;
        	}else{
                $language = $this->session->get('auth-identity')['Lang'];
                $lang=\Languages::findFirst(["code='{$language}'"]);
                $lang_id=$lang->id;
            }

        }else{
            $lang_id = "2";
        }
		if($dept_id==0){
		//get string translation
        $translation= \CpModulesTranslation::findFirst(["word_key='{$string}' AND module_id={$module} AND lang_id={$lang_id} and core_dept_id=0"]);
        if(!$translation){
            return $this->getTranslation()->_($string);
        }
        return $translation->value;
		}else{
			$translation= \CpModulesTranslation::findFirst(["word_key='{$string}' AND module_id={$module} AND lang_id={$lang_id} AND core_dept_id={$dept_id}"]);
        if(!$translation){
            return $this->getTranslation()->_($string); 
        }
        return $translation->value;
		}
        
    }

    public function SecureInputs($value){
        if(! is_numeric($value)){
            if(is_array($value)){
                foreach($value AS $key=>$v){
                    if(is_array($v)) $value[$key] = $this->SecureInputs($v);
                    else{
                        if(get_magic_quotes_gpc())
                            $value[$key] = htmlspecialchars(trim($v));
                        else
                            $value[$key] = htmlspecialchars(addslashes(trim($v)));
                    }
                }
            }
            else{
                if(get_magic_quotes_gpc())
                    $value = htmlspecialchars(trim($value));
                else
                    $value = htmlspecialchars(addslashes(trim($value)));
            }
        }
        return $value;
    }




}
