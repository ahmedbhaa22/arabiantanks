<?php
namespace Vokuro\Control\Controllers;

use \DataKeyvalueGroup;
use \DataKeyvalueGroupLang;
use \DataKeyvalueOption;
use \DataKeyvalueOptionLang;
use Models\DataKeyvalueDb;
use Vokuro\Models\DataKeyvalueEntity;
use Vokuro\Models\SetupEntities;

class KeyvalueController extends ModuleBase
{
    public function indexAction($module_id)
    {
        $groups = \DataKeyvalueGroup::find(["Module_ID={$module_id}"]);
//        $groups = \DataKeyvalueGroup::query()
//            ->join("DataKeyvalueGroupLang")
//            ->where("DataKeyvalueGroup.Module_ID={$module_id}")
//            ->andWhere("DataKeyvalueGroupLang.Lang_ID=1");
        $this->view->groups = $groups;
        $this->view->Module_ID = $module_id;
    }


    public function newGroupAction($Module_ID)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $application_modules = \UsersApplicationModule::find(["Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        $this->view->modules = $application_modules;
        $this->view->Module_ID = $Module_ID;
        //get main depts
        $main_depts = \DataCmsDepts::find(["Module_ID={$Module_ID}"]);
        $this->view->main_depts = $main_depts;
    }

    public function createGroupAction()
    {
        $group = new \DataKeyvalueGroup();
        $group->Paramter = $this->request->getPost("Paramter");
        $group->Img = " ";
        $group->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $group->Module_ID = $this->request->getPost('Module_ID');
        $group->Key_Value_Layout_ID = 1;
        $group->Cell_Press = 0;
        $group->Depts_ID = 0;
        $group->Core = "no";
        $group->Is_Dept = $this->request->getPost("is_Dept");

        if ($this->request->getPost("is_Dept") == 1) {
            $group->Depts_ID = $this->request->getPost("Core_Depts_ID") ?: 0;
        }
        if (!$group->save()) {
            foreach ($group->getMessages() as $message) {
                $this->flash->error($message);
            }
            return;
        }
        $group_lang = new \DataKeyvalueGroupLang();
        $group_lang->Title = $this->request->getPost('Title');
        $group_lang->Lang_ID = 1;
        $group_lang->Group_ID = $group->ID;
        $group_lang->Module_ID = $this->request->getPost('Module_ID');
        $group_lang->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        if (!$group_lang->save()) {
            foreach ($group_lang->getMessages() as $message) {
                $this->flash->error($message);
            }
            return;
        }
        $this->flashSession->success("Keyvalue Created Successfully");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    public function newKeyvalueAction($Group_ID)
    {
        $this->view->setup_entities = SetupEntities::find(['load_as_keyvalue = 1']);
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $group = DataKeyvalueGroup::findFirst(["ID=" . $Group_ID]);
        $this->view->group = $group;
        //get main depts
        $main_depts = \DataCmsDepts::find(["Module_ID={$group->Module_ID}"]);
        $this->view->main_depts = $main_depts;
        $kv_types = \DataKeyvalueTypes::find();
        $this->view->kv_types = $kv_types;
        // non default languages
        $application_languages = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND is_default=0"]);
        $this->view->langs = $application_languages;
    }

    public function createKeyvalueAction()
    {
        //print_r($_POST);exit;
        $keyvalue = new \DataKeyvalue();
        $keyvalue->Paramter = $this->request->getPost('Paramter');
        if($this->request->getPost("from_external_table")){
            $keyvalue->CKV_ID = 8;
        }else{
            $keyvalue->CKV_ID = $this->request->getPost('CKV_ID');
        }

        $keyvalue->Depts_ID = 0;
        $keyvalue->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $keyvalue->Module_ID = $this->request->getPost('Module_ID');
        $keyvalue->Group_ID = $this->request->getPost('Group_ID');
        //check if kv group is for dept
        $group = \DataKeyvalueGroup::findFirst(["ID={$this->request->getPost('Group_ID')}"]);
        if ($group->Depts_ID != 0) {
            $keyvalue->Depts_ID = $group->Depts_ID;
        }
        if ($this->request->getPost("Show_menu") != null) {
            $keyvalue->Show = 1;
        } else {
            $keyvalue->Show = 0;
        };
        $keyvalue->CKVT_ID = 0;
        if (!$keyvalue->save()) {
            foreach ($keyvalue->getMessages() as $message) {
                $this->flash->error($message);
            }
            return;
        }
        $keyvalue_lang = new \DataKeyvalueLang();
        $keyvalue_lang->DKV_ID = $keyvalue->ID;
        $keyvalue_lang->Lang_ID = 1;
        $keyvalue_lang->Title = $this->request->getPost('Title');
        if (!$keyvalue_lang->save()) {
            foreach ($keyvalue_lang->getMessages() as $message) {
                $this->flash->error($message);
            }
            return;
        }
        //other langs
        $application_languages = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND is_default=0"]);
        if(count($application_languages)>0){
            foreach ($application_languages as $lang){
                if(isset($_POST["Title{$lang->lang_id}"])){
                    $keyvalue_lang = new \DataKeyvalueLang();
                    $keyvalue_lang->DKV_ID = $keyvalue->ID;
                    $keyvalue_lang->Lang_ID = $lang->lang_id;
                    $keyvalue_lang->Title = $_POST["Title{$lang->lang_id}"];
                    $keyvalue_lang->save();
                }
            }
        }
        //Manage Options if Keyvlue type has some options
        $types = [1, 3];
        if (in_array($keyvalue->CKV_ID, $types)) {
            foreach ($this->request->getPost("seletcTitleDefault") as $title) {
                $option = new DataKeyvalueOption();
                $option->Application_ID = $keyvalue->Application_ID;
                $option->DKV_ID = $keyvalue->ID;
                $option->Module_ID = $keyvalue->Module_ID;
                if (!$option->save()) {
                    die("Error In Saving");
                }
                //manage Languages
                $option_lang = new DataKeyvalueOptionLang();
                $option_lang->Option_ID = $option->ID;
                $option_lang->Title = $title;
                $option_lang->Lang_ID = 1;
                if (!$option_lang->save()) {
                    die("Error In Saving Option Lang");
                }
            }

        }
        //if keyvalue is DB
        if ($keyvalue->CKV_ID == 7) {
            $kv_db = new DataKeyvalueDb();
            $kv_db->Module_ID = $keyvalue->Module_ID;
            $kv_db->Application_ID = $keyvalue->Application_ID;
            $kv_db->DKV_ID = $keyvalue->ID;
            $kv_db->Core_Dept_ID = $this->request->getPost("Core_Depts_ID");
            if (!$kv_db->save()) {
                foreach ($keyvalue->getMessages() as $msg) {
                    echo $msg;
                };
                die;
            };
            $keyvalue->Depts_ID = $keyvalue->DataKeyvalueGroup->Depts_ID;
            $keyvalue->save();
        }

        //if keyvalue is Entity
        if ($keyvalue->CKV_ID == 8) {
            $kv_entity = new DataKeyvalueEntity();
            $kv_entity->entity_id = $this->request->getPost("external_table");
            $kv_entity->dkv_id = $keyvalue->ID;
            if (!$kv_entity->save()) {
                foreach ($kv_entity->getMessages() as $msg) {
                    echo $msg;
                };
                die;
            };
        }

        //Keyvalue validation settings
        $kv_validation = new \DataKeyvalueValidationSettings();
        $kv_validation->application_id = $keyvalue->Application_ID;
        $kv_validation->dkv_id = $keyvalue->ID;
        if ($this->request->getPost("required_kv") != null) {
            $kv_validation->req=1;
        } else {
            $kv_validation->req=0;
        };
        if(isset($_POST["kv_type"])){
            $kv_validation->kv_type = $this->request->getPost("kv_type");
        }else{
            $kv_validation->kv_type = 0;
        }

        $kv_validation->module_id = $keyvalue->Module_ID;
        $kv_validation->save();

        $this->flashSession->success("Keyvalue Created Successfully");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    public function editKeyvalueAction($kv_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $kv = \DataKeyvalueLang::find(["DKV_ID={$kv_id}"]);
        $this->view->kv = $kv;
        $this->view->kv_id = $kv_id;
        $get_module = \DataKeyvalue::findFirst(["ID={$kv_id}"]);
        $this->view->Module_ID = $get_module->Module_ID;
        $this->view->keyvalue = $get_module;
        $this->view->dkv_id = $kv_id;
        $kv_content_settings = \DataKeyvalueShowSettings::findFirst(["dkv_id={$kv_id}"]);
        if (!$kv_content_settings) {
            $kv_content_settings = new \DataKeyvalueShowSettings();
            $kv_content_settings->dkv_id = $kv_id;
            $kv_content_settings->title = 1;
            $kv_content_settings->des = 1;
            $kv_content_settings->img = 1;
            $kv_content_settings->save();
        }
        if ($kv_content_settings->title == 1) {
            $this->tag->setDefault("Title", "Y");
        }
        if ($kv_content_settings->des == 1) {
            $this->tag->setDefault("Des", "Y");
        }
        if ($kv_content_settings->img == 1) {
            $this->tag->setDefault("Img", "Y");
        }
        if ($kv_content_settings->des == 1) {
            $this->tag->setDefault("Des", "Y");
        }
        if ($kv->Show == 1) {
            $this->tag->setDefault("showMenu", "Y");
        }
        //return kv type
        $this->view->kv_type = $get_module->CKV_ID;
        //if keyvalue has options return options
        $types = [1, 3];
        if (in_array($get_module->CKV_ID, $types)) {
            $options = DataKeyvalueOption::find("DKV_ID={$get_module->ID}");
            $this->view->options = $options;
        }
        $application_Languages = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);

        $this->view->app_langs = $application_Languages;
    }

    public function editKeyvalueSaveAction($kv_id)
    {
        $this->view->disable();
        $kv_content_settings = \DataKeyvalueShowSettings::findFirst(["dkv_id={$kv_id}"]);
        if(!$kv_content_settings){
            $kv_content_settings = new \DataKeyvalueShowSettings();
            $kv_content_settings->dkv_id=$kv_id;
        }
        //check application default language
        $application_lang_default = \ApplicationCmsLang::findFirst(["is_default=1 AND application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        $kv_lang = \DataKeyvalueLang::findFirst(["DKV_ID={$kv_id} AND Lang_ID={$application_lang_default->lang_id}"]);
        if(!$kv_lang){
            $kv_lang = new \DataKeyvalueLang();
            $kv_lang->DKV_ID = $kv_id;
            $kv_lang->Lang_ID = $application_lang_default->lang_id;
        }
        $kv_lang->Title = $this->request->getPost("TitleDefault") ?: $kv_lang->Title;
        $kv = \DataKeyvalue::findFirst(["ID={$kv_id}"]);
        if ($this->request->getPost("showMenu") != null) {
            $kv->Show = 1;
            $kv->save();
        } else {
            $kv->Show = 0;
            $kv->save();
        }

        if(!$kv_lang->save()){
            print_r($kv_lang->getMessages());
            die;
        };

        //Manage Other languages Other than default
        $application_Languages = \ApplicationCmsLang::find(["application_id=" . $kv->Application_ID]);
        foreach ($application_Languages as $app_lang) {
            if ($app_lang->lang_id == $application_lang_default->lang_id) {
                continue;
            }
            $lang = $kv->getDataKeyvalueLang(["Lang_ID=" . $app_lang->lang_id]);
            if ($lang) {
                $lang->Title = $this->request->getPost("Title" . $app_lang->lang_id);
                $lang->save();
            } else {
                $lang = new \DataKeyvalueLang();
                $lang->DKV_ID = $kv->ID;
                $lang->Title = $this->request->getPost("Title" . $app_lang->lang_id);
                $lang->Lang_ID = $app_lang->lang_id;
                $lang->save();
            }
        }
        if ($this->request->getPost("Title") != null) {
            $kv_content_settings->title = 1;
        } else {
            $kv_content_settings->title = 0;
        };
        if ($this->request->getPost("Des") != null) {
            $kv_content_settings->des = 1;
        } else {
            $kv_content_settings->des = 0;
        };
        if ($this->request->getPost("Img") != null) {
            $kv_content_settings->img = 1;
        } else {
            $kv_content_settings->img = 0;
        };
        $kv_content_settings->save();
        // Check if kv type has options
        $types = [1, 3];
        if (in_array($kv->CKV_ID, $types)) {
            $options = DataKeyvalueOption::find("DKV_ID={$kv->ID}");
            $application_Languages = \ApplicationCmsLang::find(["application_id=" . $kv->Application_ID]);
            foreach ($options as $option) {
                //Default Options With Lang=1
                if (count($option->getDataKeyvalueOptionLang(["Lang_ID=1"])) > 0) {
                    foreach ($option->getDataKeyvalueOptionLang(["Lang_ID=1"]) as $option_lang) {
                        $option_lang->Title = $this->request->getPost("option{$option->ID}lang1") ?: $option_lang->Title;
                        $option_lang->save();
                    }
                } else {
                    $option_lang = new DataKeyvalueOptionLang();
                    $option_lang->Option_ID = $option->ID;
                    $option_lang->Title = $this->request->getPost("option{$option->ID}lang1") ?: " ";
                    $option_lang->Lang_ID = 1;
                    $option_lang->save();
                }
                //Set Other Languages

                foreach ($application_Languages as $application_Language) {
                    if ($application_Language->lang_id == 1) {
                        continue;
                    }

                    if (count($option->getDataKeyvalueOptionLang(["Lang_ID={$application_Language->lang_id}"])) > 0) {

                        foreach ($option->getDataKeyvalueOptionLang(["Lang_ID={$application_Language->lang_id}"]) as $option_lang) {

                            $option_lang->Title = $this->request->getPost("option{$option->ID}lang{$application_Language->lang_id}") ?: $option_lang->Title;
                            if ($this->request->getPost("option{$option->ID}lang{$application_Language->lang_id}") !== "") {
                                $option_lang->save();
                            }
                        }
                    } else {

                        $option_lang = new DataKeyvalueOptionLang();
                        $option_lang->Option_ID = $option->ID;
                        $option_lang->Title = $this->request->getPost("option{$option->ID}lang{$application_Language->lang_id}") ?: " ";
                        $option_lang->Lang_ID = $application_Language->lang_id;
                        if ($this->request->getPost("option{$option->ID}lang{$application_Language->lang_id}") !== "") {
                            if (!$option_lang->save()) {
                                print_r($option_lang->getMessages());
                                die();
                            };
                        }

                    }

                }
            }
            //if there are new options added
            //check the default value first

            foreach ($this->request->getPost("option_new1") as $option) {
                if (!empty($option)) {
                    $new_option = new DataKeyvalueOption();
                    $new_option->DKV_ID = $kv->ID;
                    $new_option->Application_ID = $kv->Application_ID;
                    $new_option->Module_ID = $kv->Module_ID;
                    if (!$new_option->save()) {
                        print_r($new_option->getMessages());
                        echo "option";
                        die();
                    };
                    $new_option->save();
                    //set the lang
                    $new_option_lang = new DataKeyvalueOptionLang();
                    $new_option_lang->Option_ID = $new_option->ID;
                    $new_option_lang->Title = $option;
                    $new_option_lang->Lang_ID = 1;
                    if (!$new_option_lang->save()) {
                        print_r($new_option_lang->getMessages());
                        echo "lang";
                        $new_option->delete();
                        die();
                    };
                }
            }


        }
        echo "تم الحفظ بنجاح";
        // return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }

    public function editGroupAction($group_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $group = DataKeyvalueGroup::findFirst(["ID={$group_id}"]);
        $group_langs = DataKeyvalueGroupLang::find(["Group_ID={$group->ID}"]);
        $this->view->group = $group;
        $this->view->group_langs = $group_langs;
        $application_Languages = \ApplicationCmsLang::find(["application_id=" . $group->Application_ID]);
        $this->view->app_langs = $application_Languages;
        $this->view->Module_ID = $group->Module_ID;

    }

    public function saveGroupAction($ID)
    {
        $this->view->disable();
        $group_lang = DataKeyvalueGroupLang::findFirst(["ID={$ID} AND Lang_ID=1"]);
        $group_lang->Title = $this->request->getPost("TitleDefault") ?: $group_lang->Title;
        $group_lang->save();
        $group = DataKeyvalueGroup::findFirst(["ID={$ID}"]);
        //Manage Other languages Other than default
        $application_Languages = \ApplicationCmsLang::find(["application_id=" . $group_lang->Application_ID]);
        foreach ($application_Languages as $app_lang) {
            if ($app_lang->lang_id == 1) {
                continue;
            }
            if (!$this->request->getPost("Title{$app_lang->lang_id}")) {
                continue;
            };
            $lang = $group->getGroupLang(["Lang_ID=" . $app_lang->lang_id]);
            if ($lang) {
                $lang->Title = $this->request->getPost("Title" . $app_lang->lang_id);
                $lang->save();
            } else {
                $lang = new DataKeyvalueGroupLang();
                $lang->Group_ID = $group->ID;
                $lang->Title = $this->request->getPost("Title{$app_lang->lang_id}");
                $lang->Lang_ID = $app_lang->lang_id;
                $lang->Module_ID = $group->Module_ID;
                $lang->Application_ID = $group->Application_ID;
                if (!$lang->save()) {
                    foreach ($lang->getMessages() as $message) {
                        echo $message;
                    }
                };
            }
        }
        echo "Saved With Success";
    }

    public function deleteGroupAction($group_id){
        $group = DataKeyvalueGroup::findFirst(["ID={$group_id}"]);
        $lang = DataKeyvalueGroupLang::find(["Group_ID={$group_id}"]);
        $kvs = \DataKeyvalue::find(["Group_ID={$group_id}"]);
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
        $this->flashSession->success("Deleted With Success");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }


    public function deleteKeyvalueAction($dkv_id)
    {
        $kv = \DataKeyvalue::findFirst(["ID={$dkv_id}"]);
        if ($kv->CKV_ID == 1 || $kv->CKV_ID == 3) {
            $kv_options = \DataKeyvalueOption::find(["DKV_ID={$dkv_id}"]);
            foreach ($kv_options as $kv_option) {
                foreach ($kv_option->DataKeyvalueOptionLang as $lang) {
                    $lang->delete();
                }
                $kv_option->delete();
            }
        }
        if($kv->CKV_ID == 7){
            $kv_db_dept = DataKeyvalueDb::findFirst(["dkv_id={$dkv_id}"]);
            $kv_db_dept->delete();
        }
        $user_data = \DataKeyvalueUserdata::find(["DKV_ID={$dkv_id}"]);
        foreach ($user_data as $value) {
            $value->delete();
        }
        $show_settings = \DataKeyvalueShowSettings::findFirst(["dkv_id={$dkv_id}"]);
        $show_settings->delete();
        $kv->DataKeyvalueLang->delete();
        $kv->delete();
        $this->flashSession->success("Deleted With Success");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    public function createKeyvalueTranAction()
    {
        $trans = \DataKeyvalueLang::findFirst(["Lang_ID={$this->request->getPost("lang_id")} AND DKV_ID={$this->request->getPost("dkv_id")}"]);
        if ($trans) {
            $this->flashSession->error("Cannot Add This Lang as it was already defined");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        $trans = new  \DataKeyvalueLang();
        $trans->Lang_ID = $this->request->getPost("lang_id");
        $trans->DKV_ID = $this->request->getPost("dkv_id");
        $trans->Title = $this->request->getPost("Title");
        if (!$trans->save()) {
            print_r($trans->getMessages());
            die;
        }
        $this->flashSession->success("Translation created successfully");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }

    public function saveKeyvalueTranAction()
    {
        $trans = \DataKeyvalueLang::findFirst(["ID={$this->request->getPost("ID")}"]);
        $trans->Title = $this->request->getPost("Title");
        if (!$trans->save()) {
            print_r($trans->getMessages());
            die;
        }
        $this->flashSession->success("Translation Saved successfully");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }

    protected function contentDefLang()
    {
        return 1;
    }


}