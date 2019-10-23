<?php
namespace Vokuro\Control\Controllers;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;
use \UsersApplicationModule;
use Vokuro\Pentavalue\Keyvalue;
use Phalcon\Security;
use Phalcon\Security\Random;


class UsersApplicationModuleController extends ModuleBase
{
    /**
     * Index action
     */
    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';

    public function indexAction()
    {
        $this->mustLogin();
        $this->persistent->parameters = null;
        $modules = UsersApplicationModule::find(
            array(
                "Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
            )
        );
        $this->view->Modules = $modules;

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

    /**
     * Displays the creation form
     */
    public function newAction()
    {

    }

    /**
     * Edits a users_application_module
     *
     * @param string $ID
     */
    public function editAction($ID)
    {
        if (!$this->request->isPost()) {

            $users_application_module = UsersApplicationModule::findFirstByID($ID);
            if (!$users_application_module) {
                $this->flashSession->error("users_application_module was not found");

                return $this->response->redirect($_SERVER['HTTP_REFERER']);
                
            }

            $this->view->ID = $users_application_module->ID;

            $this->tag->setDefault("ID", $users_application_module->ID);
            $this->tag->setDefault("Title", $users_application_module->Title);
			//manage languages
			$app_langs= \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
			$title_langs=[];
			foreach ($app_langs as $app_lang) {
				$lang=\UsersApplicationModuleLang::findFirst(["module_id={$users_application_module->ID} AND lang_id={$app_lang->lang_id}"]);
				$row['lang_id']=$app_lang->lang_id;
				$row['lang_title']=$app_lang->LangDetails->title;
				$row['title']="";
				if($lang){
					$row['title']=$lang->title;
				}				
				$title_langs[]=$row;
			}
			$this->view->title_langs = $title_langs;
			

       }
    }

    /**
     * Creates a new users_application_module
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "users_application_module",
                'action' => 'index'
            ]);

            return;
        }

        $users_application_module = new UsersApplicationModule();
        $users_application_module->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $users_application_module->Package_ID = 0;
        $users_application_module->Original_ID = 2;
        $users_application_module->Copy_Module_ID = 0;
        $users_application_module->Title = $this->request->getPost("Title");
        $users_application_module->Login = 0;
        $users_application_module->Setting = 'a:15:{i:2;s:1:"1";i:6;s:1:"1";i:3;s:1:"1";i:24;s:1:"1";i:25;s:1:"1";i:26;s:1:"1";i:27;s:1:"1";i:28;s:1:"1";i:29;s:1:"1";i:30;s:1:"1";i:43;s:1:"1";i:1;s:1:"1";i:7;s:1:"1";i:5;s:1:"1";i:4;s:1:"1";}';
        $users_application_module->Auth_Setting = 'a:3:{s:7:"webview";i:0;s:5:"login";i:0;s:8:"showtime";i:0;}';
        $users_application_module->BG_Iphone = ' ';
        $users_application_module->BG_Ipad = ' ';
        $users_application_module->BG_Android = ' ';
        $users_application_module->Base_URL = ' ';
        $users_application_module->Get_Orders_Setting = ' ';
        $users_application_module->Color = ' ';
        $users_application_module->With_Key_Value = 0;
        $users_application_module->Mapping_Api = 0;
        $users_application_module->Plugin_Api = 0;
        $users_application_module->Active = $this->request->getPost("Active");


        if (!$users_application_module->save()) {
            foreach ($users_application_module->getMessages() as $message) {
                $this->flashSession->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "users_application_module",
                'action' => 'new'
            ]);

            return;
        }

        $this->flash->success("users_application_module was created successfully");
        $module_settings= new \CpModuleContentSetting();
        $module_settings->Module_ID=$users_application_module->ID;
        $module_settings->Title=1;
        $module_settings->Des=1;
        $module_settings->Content=1;
        $module_settings->Order=1;
        $module_settings->Img=1;
        $module_settings->Visit_Num=1;
        $module_settings->DateTime=1;
        $module_settings->Active=1;
        $module_settings->Depts=1;
        $module_settings->MediaImg=1;
        $module_settings->MediaVideo=1;
        $module_settings->KvInfo=1;
        $module_settings->Application_ID=$this->session->get('auth-identity')['Application_ID'];
        $module_settings->save();

        $settings = new \CpModulesSettings();
        $settings->Module_ID =$users_application_module->ID;
        $settings->Toggle_Grid=0;
        $settings->Has_Orders=0;
        $settings->Content_Img="default_content.png";
        $settings->Content_Stat_Img="default_content_stat.png";
        $settings->Content_Banner="default_content_banner.png";
        $settings->Content_Edit_Banner="default_content_edit_banner.png";
        $settings->Img = "default_module_img.png";
        $settings->Module_Banner="default_module_banner.png";
        $settings->save();
        return $this->response->redirect("users_application_module/index");

    }

    /**
     * Saves a users_application_module edited
     *
     */
    public function saveAction()
    {

        if (!$this->request->isPost()) {
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }

        $ID = $this->request->getPost("ID");
        $users_application_module = UsersApplicationModule::findFirstByID($ID);

        if (!$users_application_module) {
            $this->flashSession->error("users_application_module does not exist " . $ID);

            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        $users_application_module->Title = $this->request->getPost("Title");
		$users_application_module->BG_Iphone = ' ';
        $users_application_module->BG_Ipad = ' ';
        $users_application_module->BG_Android = ' ';
        $users_application_module->Base_URL = ' ';
        $users_application_module->Get_Orders_Setting = ' ';
        $users_application_module->Color = ' ';


        if (!$users_application_module->save()) {

            foreach ($users_application_module->getMessages() as $message) {
                $this->flashSession->error("UsersApplicationModule: ".$message);
				
            }

            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
		
		$app_langs= \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
			
			foreach ($app_langs as $app_lang) {
				$lang=\UsersApplicationModuleLang::findFirst(["module_id={$users_application_module->ID} AND lang_id={$app_lang->lang_id}"]);
				if($lang){
					$lang->title = $this->request->getPost("Lang{$app_lang->lang_id}");					
				}else{
					$lang=new \UsersApplicationModuleLang();
					$lang->title=$this->request->getPost("Lang{$app_lang->lang_id}");
					$lang->lang_id=$app_lang->lang_id;
					$lang->module_id=$users_application_module->ID;
				}
				$lang->save();
			}

        $this->flashSession->success("Updated Successfully");
		return $this->response->redirect($_SERVER['HTTP_REFERER']);
       
    }

    /**
     * Deletes a users_application_module
     *
     * @param string $ID
     */
    public function deleteAction($ID)
    {
        $users_application_module = UsersApplicationModule::findFirstByID($ID);
        if (!$users_application_module) {
            $this->flash->error("users_application_module was not found");

            $this->dispatcher->forward([
                'controller' => "users_application_module",
                'action' => 'index'
            ]);

            return;
        }

        if (!$users_application_module->delete()) {

            foreach ($users_application_module->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "users_application_module",
                'action' => 'search'
            ]);

            return;
        }

        $this->flash->success("users_application_module was deleted successfully");

        $this->dispatcher->forward([
            'controller' => "users_application_module",
            'action' => "index"
        ]);
    }

    public function settingsAction($ModuleID){
//        if($this->request->isPost()){
//            $settings = \CpModulesSettings::findFirstByID($this->request->getPost("ID"));
//            $settings->Toggle_Grid = $this->request->getPost("Toggle_Grid");
//            if($settings->save()){
//                $this->flash->success("Module Settings Updated");
//            }
//        }

        $settings = \CpModulesSettings::findFirst(array("Module_ID={$ModuleID}"));
        if (!$settings){
            $settings= new \CpModulesSettings();
            $settings->Module_ID=$ModuleID;
            $settings->save();
        }
        //module picture update 10/4/2017
        $this->view->settings = $settings;
        $module=UsersApplicationModule::findFirst("ID={$ModuleID}");
        $this->view->Module=$module;
        ///////////
        $this->tag->setDefault("ID", $settings->ID);
        $this->tag->setDefault("Module_ID", $settings->Module_ID);
        if($settings->Toggle_Grid==1){
            $this->tag->setDefault("Toggle_Grid","Y");
        }
        if($settings->Has_Orders==1){
            $this->tag->setDefault("Has_Orders","Y");
        }
        if($settings->extra_fields!=0){
            $this->tag->setDefault("is_product","Y");
        }
        if($settings->has_tags==1){
            $this->tag->setDefault("has_tags","Y");
        }

        $content_settings= \CpModuleContentSetting::findFirst(array("Module_ID={$ModuleID} AND Application_ID={$this->session->get('auth-identity')['Application_ID']}"));
        if (!$content_settings){
            $content_settings = new \CpModuleContentSetting();
            $content_settings->Application_ID = $this->session->get('auth-identity')['Application_ID'];
            $content_settings->Module_ID = $settings->Module_ID;
            $content_settings->save();
        }
        if($content_settings->Title==1){
            $this->tag->setDefault("Title","Y");
        }
        if($content_settings->Des==1){
            $this->tag->setDefault("Des","Y");
        }
        if($content_settings->Title==1){
            $this->tag->setDefault("Title","Y");
        }
        if($content_settings->Content==1){
            $this->tag->setDefault("Content","Y");
        }
        if($content_settings->Img==1){
            $this->tag->setDefault("Img","Y");
        }
        if($content_settings->Visit_Num==1){
            $this->tag->setDefault("Visit_Num","Y");
        }
        if($content_settings->DateTime==1){
            $this->tag->setDefault("DateTime","Y");
        }
        if($content_settings->Active==1){
            $this->tag->setDefault("Active","Y");
        }
        if($content_settings->Depts==1){
            $this->tag->setDefault("Depts","Y");
        }
        if($content_settings->MediaImg==1){
            $this->tag->setDefault("MediaImg","Y");
        }
        if($content_settings->MediaVideo==1){
            $this->tag->setDefault("MediaVideo","Y");
        }
        if($content_settings->KvInfo==1){
            $this->tag->setDefault("KvInfo","Y");
        }
        if($content_settings->Add==1){
            $this->tag->setDefault("Add","Y");
        }
        if($content_settings->Del==1){
            $this->tag->setDefault("Del","Y");
        }
		if($content_settings->Import==1){
            $this->tag->setDefault("Import","Y");
        }
        $this->view->ModulesList=UsersApplicationModule::find(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        $relation = \DataModuleRelations::findFirst(["module_one={$ModuleID}"]);
        if(!$relation){
            $this->view->hasRel= 0;

        }
		elseif($relation->model_two==0){
			$this->view->hasRel= 0;
		}
        else{
            $this->view->hasRel= 1;
            $this->view->moduleRelated = $relation->model_two;
            $this->tag->setDefault("RelatedModule",$relation->model_two);
        }

        // List Settings 15/4/2017

        $list_settings= \DataCmsListSettings::findFirst(["Module_ID={$ModuleID}"]);
        if (!$list_settings){
            $list_settings = new \DataCmsListSettings();
            $list_settings->Application_ID = $this->session->get('auth-identity')['Application_ID'];
            $list_settings->Module_ID = $settings->Module_ID;
            $list_settings->save();
        }
        if($list_settings->Title==1){
            $this->tag->setDefault("ListTitle","Y");
        }
        if($list_settings->Des==1){
            $this->tag->setDefault("ListDes","Y");
        }
        if($list_settings->Title==1){
            $this->tag->setDefault("ListTitle","Y");
        }
        if($list_settings->Content==1){
            $this->tag->setDefault("ListContent","Y");
        }
        if($list_settings->Img==1){
            $this->tag->setDefault("ListImg","Y");
        }
        if($list_settings->Visit_Num==1){
            $this->tag->setDefault("ListVisit_Num","Y");
        }
        if($list_settings->DateTime==1){
            $this->tag->setDefault("ListDateTime","Y");
        }
        if($list_settings->Active==1){
            $this->tag->setDefault("ListActive","Y");
        }
        if($list_settings->Depts==1){
            $this->tag->setDefault("ListDepts","Y");
        }
        if($list_settings->Order==1){
            $this->tag->setDefault("ListOrder","Y");
        }




    }
    public function settingssaveAction(){
        if($this->request->isPost()){

            $settings = \CpModulesSettings::findFirstByID($this->request->getPost("ID"));

            $impexp_enabled = ($this->request->getPost('impexp_enabled') && $this->request->getPost('impexp_enabled') == 'on')?1:0;

            $settings->import_export_enabled = $impexp_enabled;

            if($this->request->getPost("Toggle_Grid")!=null){
                $settings->Toggle_Grid = 1;
            }
            if($this->request->getPost("Has_Orders")!=null){
                $settings->Has_Orders = 1;
            }
            if($this->request->getPost("is_product")!=null){
                $settings->extra_fields = 8;
            }
            if($this->request->getPost("has_tags")!=null){
                $settings->has_tags = 1;
            }
            if ($this->request->hasFiles() == true) {
                //die("islam");
                foreach ($this->request->getUploadedFiles() as $file) {
                    if($file->getName() != "") {
                        if($file->getKey()=="ModulePic"){
                            $random= new Random();
                            $random_name = $random->uuid().".".$file->getExtension ();
                            $settings->Img = $random_name;
                            $file->moveTo(static::UPLOAD_LOCATION.'modules_pics/' . $random_name );
                        }
                        elseif($file->getKey()=="Content_Img"){
                            $random= new Random();
                            $random_name = $random->uuid().".".$file->getExtension ();
                            $settings->Content_Img = $random_name;
                            $file->moveTo(static::UPLOAD_LOCATION.'modules_pics/' . $random_name );
                        }
                        elseif($file->getKey()=="Content_Stat_Img"){
                            $random= new Random();
                            $random_name = $random->uuid().".".$file->getExtension ();
                            $settings->Content_Stat_Img = $random_name;
                            $file->moveTo(static::UPLOAD_LOCATION.'modules_pics/' . $random_name );
                        }
                        elseif($file->getKey()=="Content_Banner"){
                            $random= new Random();
                            $random_name = $random->uuid().".".$file->getExtension ();
                            $settings->Content_Banner = $random_name;
                            $file->moveTo(static::UPLOAD_LOCATION.'modules_pics/' . $random_name );
                        }
                        elseif($file->getKey()=="Module_Banner"){
                            $random= new Random();
                            $random_name = $random->uuid().".".$file->getExtension ();
                            $settings->Module_Banner = $random_name;
                            $file->moveTo(static::UPLOAD_LOCATION.'modules_pics/' . $random_name );
                        }
						elseif($file->getKey()=="Content_Edit_Banner"){
                            $random= new Random();
                            $random_name = $random->uuid().".".$file->getExtension ();
                            $settings->Content_Edit_Banner = $random_name;
                            $file->moveTo(static::UPLOAD_LOCATION.'modules_pics/' . $random_name );
                        }
                    }
                }
            }
            $settings->save();
            $content_settings= \CpModuleContentSetting::findFirst(array("Module_ID={$settings->Module_ID} AND Application_ID={$this->session->get('auth-identity')['Application_ID']}"));
            if($this->request->getPost("Title")!=null){
                $content_settings->Title = 1;
            }else{
                $content_settings->Title = 0;
            };
            if($this->request->getPost("Des")!=null){
                $content_settings->Des = 1;
            }else{
                $content_settings->Des = 0;
            };
            if($this->request->getPost("Content")!=null){
                $content_settings->Content = 1;
            }else{
                $content_settings->Content = 0;
            };
            if($this->request->getPost("Order")!=null){
                $content_settings->Order = 1;
            }else{
                $content_settings->Order = 0;
            };
            if($this->request->getPost("Img")!=null){
                $content_settings->Img = 1;
            }else{
                $content_settings->Img = 0;
            };
            if($this->request->getPost("DateTime")!=null){
                $content_settings->DateTime = 1;
            }else{
                $content_settings->DateTime = 0;
            };
            if($this->request->getPost("Active")!=null){
                $content_settings->Active = 1;
            }else{
                $content_settings->Active = 0;
            }
            if($this->request->getPost("Depts")!=null){
                $content_settings->Depts = 1;
            }else{
                $content_settings->Depts = 0;
            };
            if($this->request->getPost("MediaImg")!=null){
                $content_settings->MediaImg = 1;
            }else{
                $content_settings->MediaImg = 0;
            };
            if($this->request->getPost("MediaVideo")!=null){
                $content_settings->MediaVideo = 1;
            }else{
                $content_settings->MediaVideo = 0;
            };
            if($this->request->getPost("KvInfo")!=null){
                $content_settings->KvInfo = 1;
            }else{
                $content_settings->KvInfo = 0;
            };
            if($this->request->getPost("Add")!=null){
                $content_settings->Add = 1;
            }else{
                $content_settings->Add = 0;
            };
            if($this->request->getPost("Del")!=null){
                $content_settings->Del = 1;
            }else{
                $content_settings->Del = 0;
            };
			if($this->request->getPost("Import")!=null){
                $content_settings->Import = 1;
            }else{
                $content_settings->Import = 0;
            };
            if (!$content_settings->save()){
                $this->flashSession->error("Error");
                return;
            }
            $has_relation=$this->request->getPost("RelatedModule");
            if($has_relation!==null){
                //if relation exists
                $relation=\DataModuleRelations::findFirst(["module_one={$this->request->getPost('Module_ID')}"]);
                if($relation){
                    $relation->delete();
                }
                $create_relation = new \DataModuleRelations();
                $create_relation->module_one=$this->request->getPost('Module_ID');
                $create_relation->model_two=$has_relation;
                $create_relation->application_id=$this->session->get('auth-identity')['Application_ID'];
                if (!$create_relation->save()){
                    $this->flashSession->error("Error in creating relation");
                }

            }

            // List View Settings 15-4-2017
            $list_settings=\DataCmsListSettings::findFirst(["Module_ID={$settings->Module_ID}"]);
            if(!$list_settings){
                $list_settings = new \DataCmsListSettings();
                $list_settings->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $list_settings->Module_ID = $settings->Module_ID;
                $list_settings->save();
            }
            if($this->request->getPost("ListTitle")!=null){
                $list_settings->Title = 1;
            }else{
                $list_settings->Title = 0;
            };
            if($this->request->getPost("ListDes")!=null){
                $list_settings->Des = 1;
            }else{
                $list_settings->Des = 0;
            };
            if($this->request->getPost("ListContent")!=null){
                $list_settings->Content = 1;
            }else{
                $list_settings->Content = 0;
            };
            if($this->request->getPost("ListOrder")!=null){
                $list_settings->Order = 1;
            }else{
                $list_settings->Order = 0;
            };
            if($this->request->getPost("ListImg")!=null){
                $list_settings->Img = 1;
            }else{
                $list_settings->Img = 0;
            };
            if($this->request->getPost("ListDateTime")!=null){
                $list_settings->DateTime = 1;
            }else{
                $list_settings->DateTime = 0;
            };
            if($this->request->getPost("ListActive")!=null){
                $list_settings->Active = 1;
            }
            else{
                $list_settings->Active = 0;
            };
            if($this->request->getPost("ListDepts")!=null){
                $list_settings->Depts = 1;
            }else{
                $list_settings->Depts = 0;
            };
            if($this->request->getPost("ListVisit_Num")!=null){
                $list_settings->Visit_Num = 1;
            }else{
                $list_settings->Visit_Num = 0;
            };
            if(!$list_settings->save()){
                foreach ($list_settings->getMessages() as $message){
                    $this->flashSession->error("ListSettings: ".$message);
                }
            }

            $this->flashSession->success($this->getTranslation()->_("Module settings has been updated"));

            return $this->response->redirect("users_application_module/settings/{$content_settings->Module_ID}");



        }

    }

    public function additionalSettingsAction($Module_ID){
        $data_kv = \DataKeyvalue::find(array("Module_ID={$Module_ID}"));
        $this->view->data_kv = $data_kv;
        foreach ($data_kv as $show){
            $this->tag->setDefault("KV{$show->ID}",$show->Show);
        }
        $this->tag->setDefault("Module_ID", $Module_ID);
        $this->view->Module_ID= $Module_ID;
    }
    public function additionalSaveAction(){
        if(!$this->request->isPost()){
            die();
        }
        $Module_ID = $this->request->getPost("Module_ID");
        foreach ($this->request->getPost("ID") as $ID){
            $data_kv = \DataKeyvalue::findFirst(array("ID={$ID}"));
            $data_kv->Show = $this->request->getPost("KV{$ID}");
            if(!$data_kv->save()){
                foreach ($data_kv->getMessages() as $message) {
                    $this->flash->error($message);
                }
                die();
            };
            unset($data_kv);
        }
        $this->flashSession->success($this->getTranslation()->_("Module settings has been updated"));
        return $this->response->redirect("users_application_module/additionalSettings/{$Module_ID}");

    }
    public function additionalDefaultAction($Module_ID){
        $big_array = array();
        $groups = \DataKeyvalueGroup::find(array(
            "Module_ID={$Module_ID} AND Is_Dept=0 AND Core='no'"
        ));
        foreach ($groups as $group) {
            //echo $group->GroupLang->Title."<br>";
            $dkvs = \DataKeyvalue::find(
                array("Group_ID={$group->ID}")
            );
            foreach ($dkvs as $dkv) {
                //Skip Two keyvalue Types
                if ($dkv->CoreKeyvalueType->ID == 4 || $dkv->CoreKeyvalueType->ID == 7) {
                    continue;
                };
                $ad_kv = new Keyvalue();
                $big_array[] = array(
                    "GroupName" => "{$group->GroupLang->Title}",
                    "KeyValueTitle" => $dkv->DataKeyvalueLang->Title,
                    "ControlValue" => $ad_kv->keyvalueAddTags($dkv->CoreKeyvalueType->ID, "", $dkv->ID),
                    "Title" => $this->tag->textField(["KVAdd{$dkv->ID}Title", "type" => "text", "class" => "form-control", "id" => "fieldKVTitle"]),
                    "Des" => $this->tag->textField(["KVAdd{$dkv->ID}Des", "type" => "text", "class" => "form-control", "id" => "fieldKVDes"]),
                    //"Img" => $this->tag->fileField(["KVAdd{$dkv->ID}Img", "type" => "text", "class" => "form-control", "id" => "fieldKVImg"]),
                    "Add" => "1",
                    "KV_ID" => $dkv->ID
                );
                unset($ad_kv);
            }
        }

        $this->view->keyValueData = $big_array;
        $this->view->Module_ID = $Module_ID;
    }

    public function additionalDefaultSaveAction(){
        if (!$this->request->isPost()){
            die();
        }
        foreach ($this->request->getPost("kvAddIDs") as $KV_ID){
            //check if keyvalue exists in the default values table
            $kv_default= \DataKeyvalueDefaultValues::findFirst(array("DKV_ID={$KV_ID}"));
            if(!$kv_default){
                // create the kv with its default values
                $kv_default = new \DataKeyvalueDefaultValues();
                $kv_default->Module_ID = $this->request->getPost("Module_ID");
                $kv_default->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $kv_default->DKV_ID = $KV_ID;
                $kv_default->Des = $this->request->getPost("KVAdd{$KV_ID}Des");
                $kv_default->Title = $this->request->getPost("KVAdd{$KV_ID}Title");
                $kv_default->Value = $this->request->getPost("keyvalueAdd{$KV_ID}");
                $kv_default->Show = $this->request->getPost("keyvalueAdd{$KV_ID}");

            }
        }
    }

    public function moduleTranslationAction($module_id){
        $translation = \CpModulesTranslation::find();
        $this->view->translation = $translation;
    }

    public function moduleHomeAction($Module_ID){
        $this->view->Module_ID= $Module_ID;
        $this->view->Module = UsersApplicationModule::findFirst(["ID=$Module_ID"]);
    }
    public function realationsAction($Module_ID){


    }
    public function realationsSaveAction(){

    }

    public function stringsAction($Module_ID){
        $app_langs= \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        $this->view->app_langs = $app_langs;
        //get all strings
        $strings = \CpModulesTranslation::find("module_id={$Module_ID} Group BY word_key");
        $main_depts = \DataCmsDepts::find("Module_ID={$Module_ID}");
        $this->view->main_depts= $main_depts;
        $this->view->Module_ID= $Module_ID;
        $this->view->strings = $strings;
    }
    public function stringEditAction($Module_ID){
    	$this->view->Module_ID= $Module_ID;
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $word_key = $this->request->getQuery("word");
        $app_langs= \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        $this->view->app_langs = $app_langs;
        //get all strings
        $strings = \CpModulesTranslation::find("word_key='{$word_key}'");
        $this->view->strings = $strings;
        $this->view->word_key = $word_key;
    }

    public function stringCreateAction(){
        if(!$this->request->isPost()){
            die;
        }
        $this->view->disable();
        if(!$this->request->isPost()){
            die();
        }
        $word_key= $this->request->getPost("word_key");
        $core_dept_id= $this->request->getPost("core_dept_id");
        $app_langs= \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        $module_id= $this->request->getPost("Module_ID");
        foreach($app_langs as $app_lang){
            if($this->request->getPost("Lang{$app_lang->lang_id}")==""){continue;};
            $trans = \CpModulesTranslation::findFirst(["word_key='{$word_key}' AND lang_id={$app_lang->lang_id} AND core_dept_id={$core_dept_id}"]);
            if(!$trans){
                $trans = new \CpModulesTranslation();
                $trans->word_key=$word_key;
                $trans->lang_id=$app_lang->lang_id;
                $trans->module_id=$module_id;
				$trans->core_dept_id=$core_dept_id;
                $trans->value=$this->request->getPost("Lang{$app_lang->lang_id}");
                if(!$trans->save()){
                   foreach($trans->getMessages() as $msg){
                       echo $msg;
                   };
                }
                continue;
            }

        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }
    public function saveStringAction(){
        $this->view->disable();
        if(!$this->request->isPost()){
            die();
        }
        $word_key= $this->request->getPost("word_key");
        $app_langs= \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        $module_id= $this->request->getPost("Module_ID");
        foreach($app_langs as $app_lang){
            if($this->request->getPost("Value{$app_lang->lang_id}")==""){continue;};
            $trans = \CpModulesTranslation::findFirst(["word_key='{$word_key}' AND lang_id={$app_lang->lang_id} AND module_id={$module_id}"]);
            if(!$trans){
                $trans = new \CpModulesTranslation();
                $trans->word_key=$word_key;
                $trans->lang_id=$app_lang->lang_id;
                $trans->module_id=$module_id;
                $trans->value=$this->request->getPost("Value{$app_lang->lang_id}");
                $trans->save();
                continue;
            }
            $trans->value=$this->request->getPost("Value{$app_lang->lang_id}");
            $trans->save();
        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }

    public function stringDeleteAction($module_id){
        $word_key = $this->request->get("word_key");
        $trans = \CpModulesTranslation::findFirst(["word_key='{$word_key}' AND module_id={$module_id}"]);
        $trans->delete();
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    private function mustLogin(){
        if(!isset($_SESSION['auth-identity']['Application_ID'])){
            die("You Must Be Logged in into Robo App");
            return false;
        }
    }

}
