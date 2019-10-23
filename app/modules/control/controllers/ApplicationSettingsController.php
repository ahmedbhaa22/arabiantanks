<?php
namespace Vokuro\Control\Controllers;

use Models\Content;
use Models\DataCmsMenus;
use Models\UsersMobile;
use \UsersApplicationModule;
use Vokuro\Models\Menus;
use Phalcon\Security;
use Phalcon\Security\Random;
use Models\DataKeyvalueDb;

class ApplicationSettingsController extends ModuleBase
{
	const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';
		
	public function indexAction(){
		$application= \UsersApplication::findFirst(["ID={$this->session->get('auth-identity')['Application_ID']}"]);
		$this->view->application=$application;
        $application_menus = DataCmsMenus::find(["application_id={$application->ID}"]);
        if(count($application_menus)==0){
            $application_menu = new DataCmsMenus();
            $application_menu->application_id =$application->ID;
            $application_menu->menu_name = "MainMenu";
            $application_menu->is_main = 1;
            $application_menu->save();
            $items = Menus::find(["app_id={$application->ID}"]);
            foreach ($items as $item){
                $item->menu_cms_id=$application_menu->id;
                $item->save();
            }
            $application_menus = DataCmsMenus::find(["application_id={$application->ID}"]);

        }
        $this->view->application_menus = $application_menus;
		
	}
	public function saveAction(){
		if(!$this->request->isPost()){
			die();
		}
		$settings= \CpApplicationSettings::findFirst(["Application_ID={$this->request->getPost('Application_ID')}"]);
		if(!$settings){
			$settings = new \CpApplicationSettings();
			$settings->Application_ID=$this->request->getPost('Application_ID');
		}
		foreach ($this->request->getUploadedFiles() as $file) {
                    if($file->getName() != "") {
                        if($file->getKey()=="App_Banner"){
                            $random= new Random();
                            $random_name = $random->uuid().".".$file->getExtension ();
                            $settings->App_Banner = $random_name;
                            $file->moveTo(static::UPLOAD_LOCATION.'modules_pics/' . $random_name );
                        }
					}
		}
		if(!$settings->save()){
			$this->flashSession->error(implode(",",$settings->getMessages()));
			return $this->response->redirect("application_settings");
		}

		$main_menu = $this->request->getPost("MainMenu");
        $application_menus = DataCmsMenus::find(["application_id={$settings->Application_ID}"]);
        foreach ($application_menus as $application_menu){
            $application_menu->is_main=0;
            $application_menu->save();
        }
        $is_main = DataCmsMenus::findFirst(["id={$main_menu}"]);
        $is_main->is_main = 1;
        $is_main->save();
		$this->flashSession->success("Settings Saved");
		return $this->response->redirect("application_settings");
		
	}
	public function deleteApplicationAction(){
		/// security
		die();
        $application= \UsersApplication::findFirst(["ID={$this->session->get('auth-identity')['Application_ID']}"]);
        //delete Content
        $content = Content::find(["Application_ID={$application->ID}"]);
        if(count($content)>0){
            $content->delete();
        }
        //delete departments
        $main_depts= \DataCmsDepts::find(["Application_ID={$application->ID}"]);
        if(count($main_depts)>0){
            foreach($main_depts as $main_dept){
                $main_dept_langs = \DataCmsDeptsLang::find(["core_dept_id={$main_dept->ID}"]);
                if(count($main_dept_langs)>0){
                    $main_dept_langs->delete();
                }
            }
            $main_depts->delete();
        }

        // delete sub depts
        $sub_depts= \DataCmsDeptsRel::find(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        if(count($sub_depts)>0){
            foreach ($sub_depts as $sub_dept){
                $sub_depts_lang = \DataCmsDeptsRelLang::find(["$sub_depts={$sub_dept->ID}"]);
                if(count($sub_depts_lang)>0){
                    $sub_depts_lang->delete();
                }
            }
            $sub_depts->delete();
        }
        //cms depts relations
        $depts_rel_items = \DataCmsDeptsRelItem::find(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        if(count($depts_rel_items)>0){
            $depts_rel_items->delete();
        }

        //KeyValue

        $groups = \DataKeyvalueGroup::find(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        foreach($groups as $group){
            $lang = \DataKeyvalueGroupLang::find(["Group_ID={$group->ID}"]);
            $kvs = \DataKeyvalue::find(["Group_ID={$group->ID}"]);
            foreach ($kvs as $kv){

                if ($kv->CKV_ID == 1 || $kv->CKV_ID == 3) {
                    $kv_options = \DataKeyvalueOption::find(["DKV_ID={$kv->ID}"]);
                    foreach ($kv_options as $kv_option) {
                        foreach ($kv_option->DataKeyvalueOptionLang as $lang) {
                            $lang->delete();
                        }
                        $kv_option->delete();
                    }
                }
                if($kv->CKV_ID == 7){
                    $kv_db_dept = DataKeyvalueDb::findFirst(["dkv_id={$kv->ID}"]);
                    $kv_db_dept->delete();
                }
                $user_data = \DataKeyvalueUserdata::find(["DKV_ID={$kv->ID}"]);
                foreach ($user_data as $value) {
                    $value->delete();
                }
                $show_settings = \DataKeyvalueShowSettings::findFirst(["dkv_id={$kv->ID}"]);
                if($show_settings){
                    $show_settings->delete();
                }
                $kv->DataKeyvalueLang->delete();
                $kv->delete();
            }
            $group->delete();
            $lang->delete();
        }
        $app_settings = \CpApplicationSettings::findFirst(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        if($app_settings){
            $app_settings->delete();
        }
        // Modules And Settings
         $modules = UsersApplicationModule::find(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        foreach($modules as $module){
            $module_settings = \CpModulesSettings::findFirst(["Module_ID={$module->ID}"]);
            if($module_settings){
                $module_settings->delete();
            }
            $module_translation = \CpModulesTranslation::find(["module_id={$module->ID}"]);
            if(count($module_translation)>0){
                $module_translation->delete();
            }
            $module_lang = \UsersApplicationModuleLang::findFirst(["module_id={$module->ID}"]);
            if($module_lang){
                $module_lang->delete();
            }

            if(count($modules) > 0){
               $modules->delete();
            }

        }
        $app_langs = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        if(count($app_langs)>0){
            $app_langs->delete();
        }
        $users = UsersMobile::find(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        $users->delete();
        $application->delete();
        return $this->response->redirect('session/login');
//        $this->flashSession->success("Deleted With Success");
//        return $this->response->redirect($_SERVER['HTTP_REFERER']);
        
    }

	public function deleteOtherApplicationsAction(){
        	$all_apps = \UsersApplication::find(["ID != 593"]);
        foreach($all_apps as $one_app){
        	if($one_app->ID==593){continue;}
			
        	$application= \UsersApplication::findFirst(["ID={$one_app->ID}"]);
        //delete Content
        $content = Content::find(["Application_ID={$application->ID}"]);
        if(count($content)>0){
            $content->delete();
        }
        //delete departments
        $main_depts= \DataCmsDepts::find(["Application_ID={$application->ID}"]);
        if(count($main_depts)>0){
            foreach($main_depts as $main_dept){
                $main_dept_langs = \DataCmsDeptsLang::find(["core_dept_id={$main_dept->ID}"]);
                if(count($main_dept_langs)>0){
                    $main_dept_langs->delete();
                }
            }
            $main_depts->delete();
        }

        // delete sub depts
        $sub_depts= \DataCmsDeptsRel::find(["Application_ID={$application->ID}"]);
        if(count($sub_depts)>0){
            foreach ($sub_depts as $sub_dept){
                $sub_depts_lang = \DataCmsDeptsRelLang::find(["dept_id={$sub_dept->ID}"]);
                if(count($sub_depts_lang)>0){
                    $sub_depts_lang->delete();
                }
            }
            $sub_depts->delete();
        }
        //cms depts relations
        $depts_rel_items = \DataCmsDeptsRelItem::find(["Application_ID={$application->ID}"]);
        if(count($depts_rel_items)>0){
            $depts_rel_items->delete();
        }

        //KeyValue

        $groups = \DataKeyvalueGroup::find(["Application_ID={$application->ID}"]);
        foreach($groups as $group){
            $lang = \DataKeyvalueGroupLang::find(["Group_ID={$group->ID}"]);
            $kvs = \DataKeyvalue::find(["Group_ID={$group->ID}"]);
            foreach ($kvs as $kv){

                if ($kv->CKV_ID == 1 || $kv->CKV_ID == 3) {
                    $kv_options = \DataKeyvalueOption::find(["DKV_ID={$kv->ID}"]);
                    foreach ($kv_options as $kv_option) {
                        foreach ($kv_option->DataKeyvalueOptionLang as $lang) {
                            $lang->delete();
                        }
                        $kv_option->delete();
                    }
                }
                if($kv->CKV_ID == 7){
                    $kv_db_dept = DataKeyvalueDb::findFirst(["DKV_ID={$kv->ID}"]); 
                    if($kv_db_dept){
                    	$kv_db_dept->delete();
                    }
                    
                }
                $user_data = \DataKeyvalueUserdata::find(["DKV_ID={$kv->ID}"]);
                foreach ($user_data as $value) {
                    $value->delete();
                }
                $show_settings = \DataKeyvalueShowSettings::findFirst(["dkv_id={$kv->ID}"]);
                if($show_settings){
                    $show_settings->delete();
                }
                $kv->DataKeyvalueLang->delete();
                $kv->delete();
            }
            $group->delete();
            $lang->delete();
        }
        $app_settings = \CpApplicationSettings::findFirst(["Application_ID={$application->ID}"]);
        if($app_settings){
            $app_settings->delete();
        }
        // Modules And Settings
         $modules = UsersApplicationModule::find(["Application_ID={$application->ID}"]);
        foreach($modules as $module){
            $module_settings = \CpModulesSettings::findFirst(["Module_ID={$module->ID}"]);
            if($module_settings){
                $module_settings->delete();
            }
            $module_translation = \CpModulesTranslation::find(["module_id={$module->ID}"]);
            if(count($module_translation)>0){
                $module_translation->delete();
            }
            $module_lang = \UsersApplicationModuleLang::findFirst(["module_id={$module->ID}"]);
            if($module_lang){
                $module_lang->delete();
            }

            if(count($modules) > 0){
               $modules->delete();
            }

        }
        $app_langs = \ApplicationCmsLang::find(["application_id={$application->ID}"]);
        if(count($app_langs)>0){
            $app_langs->delete();
        }
        $users = UsersMobile::find(["Application_ID={$application->ID}"]);
        $users->delete();
        $application->delete();
        }
        return $this->response->redirect('session/login');
//        $this->flashSession->success("Deleted With Success");
//        return $this->response->redirect($_SERVER['HTTP_REFERER']);
        
    }
}