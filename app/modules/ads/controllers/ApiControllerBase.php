<?php

namespace Vokuro\Ads\Controllers;

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
class ApiControllerBase extends Controller
{


    public function initialize() {

		
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
