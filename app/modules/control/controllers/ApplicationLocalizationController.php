<?php
namespace Vokuro\Control\Controllers;

class ApplicationLocalizationController extends ModuleBase{
    public function indexAction(){
        $app_langs= \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        $this->view->app_langs = $app_langs;
        //get all strings
        $strings = \CpModulesTranslation::find("module_id=2002");
        $this->view->strings = $strings;
    }
    public function langEditAction($id){
        $app_lang= \ApplicationCmsLang::findFirst(["application_id={$this->session->get('auth-identity')['Application_ID']} AND id={$id}"]);
        $this->view->app_lang = $app_lang;
        //handling default checkbox
        if($app_lang->is_default==1){
            $this->view->default_checked="checked";
        }else{
            $this->view->default_checked="";
        }
        $this->tag->setDefault("id", $id);
    }
    public function langSaveAction(){
        if(!$this->request->isPost()){
            $this->flashSession->error("You are not allowed to do this action");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        if(isset($_POST['is_default'])){
            $id= $this->request->getPost("id");
            //check if there is other default
            $check=\ApplicationCmsLang::findFirst(["application_id={$this->session->get('auth-identity')['Application_ID']} AND is_default=1"]);
            if($check){
                $check->is_default=0;
                $check->save();
            }
            $app_lang=\ApplicationCmsLang::findFirst(["id={$id}"]);
            if($app_lang) {
                $app_lang->is_default = 1;
                $app_lang->save();
                $this->flashSession->success("Setting Updated !");
                return $this->response->redirect($_SERVER['HTTP_REFERER']);
            }
        }
    }

    public function newLangAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $this->view->langs= \Languages::find();
    }
    public function createLangSaveAction(){
        if(!$this->request->isPost()){
            $this->flashSession->error("You are not allowed to do this action");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        $lang= $this->request->getPost("Langs");
        //check if its already assigned
        $app_cms_lang=\ApplicationCmsLang::findFirst(["application_id={$this->session->get('auth-identity')['Application_ID']} and lang_id={$lang}"]);
        if($app_cms_lang){
            $this->flashSession->error("This Language is already assigned for this application");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }else{
            $app_lang=new \ApplicationCmsLang();
            $app_lang->application_id=$this->session->get('auth-identity')['Application_ID'];
            $app_lang->lang_id=$lang;
            $app_lang->save();
            $this->flashSession->success("View Language Created !");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
    }

}