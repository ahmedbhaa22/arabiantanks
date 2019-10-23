<?php
namespace Vokuro\Controllers;

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Db;
use Phalcon\Translate\Adapter\NativeArray;
use Phalcon\Http\Response;

/**
 * ControllerBase
 * This is the base controller for all controllers in the application
 */
class ControllerApiBase extends Controller
{


    public $schemes=['scheme_1','scheme_2','scheme_3','scheme_4','scheme_5','scheme_6'];
    public function initialize() {
        $_REQUEST = array_map(array($this, 'SecureInputs'), $_REQUEST);
        $_POST = array_map(array($this, 'SecureInputs'), $_POST);
        $_GET = array_map(array($this, 'SecureInputs'), $_GET);
        $this->view->setTemplateBefore('main');
        $this->view->translate  = $this->getTranslation();
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

        //$identity = $this->auth->getIdentity();

        // If there is no identity available the user is redirected
        // if (!is_array($identity)) {
            // //die("islam");
            // // die();
// 
            // $this->response->redirect($this->url_shared->get("session/login"));
            // return false;
        // }

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


        $translationFile = "../app/messages/" . $language . ".php";

        // Check if we have a translation file for that lang
        if (file_exists($translationFile)) {
            require $translationFile;
        } else {
            // Fallback to some default
            require "../app/messages/en.php";
        }

        // Return a translation object
        return new NativeArray(
            [
                "content" => $messages,
            ]
        );
    }

    public function getAdvancedTranslation($module,$string)
    {
        if(isset($this->session->get('auth-identity')['Lang'])){
            $language = $this->session->get('auth-identity')['Lang'];
            $lang=\Languages::findFirst(["code='{$language}'"]);
            $lang_id=$lang->id;
        }else{
            $lang_id = "2";
        }

        //get string translation
        $translation= \CpModulesTranslation::findFirst(["word_key='{$string}' AND module_id={$module} AND lang_id={$lang_id}"]);
        if(!$translation){
            return $this->getTranslation()->_($string);
        }
        return $translation->value;
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
