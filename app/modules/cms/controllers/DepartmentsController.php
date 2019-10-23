<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 11/10/2016
 * Time: 2:50 PM
 */
namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;

use \DataCmsDeptsRel;
use \DataCmsDepts;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Vokuro\Pentavalue\Keyvalue;
use \DataTables\DataTable;
use Vokuro\Pentavalue\KeyvalueOld;

class DepartmentsController extends ControllerBase
{

    const UPLOAD_LOCATION = 'uploads/';

    public function indexAction($main_dept)
    {
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataCmsDeptsRel', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        //$parameters["order"] = "ID";
        $Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $departments = DataCmsDeptsRel::find(array(
            "Core_Depts_ID = {$main_dept} AND Application_ID={$Application_ID}",
            "order" => "ID Desc"
        ));
        $x = array();
        foreach ($departments as $department) {
            $x[] = $department->ID;
        }


//        if (count($departments) == 0) {
//            $this->flash->notice("The search did not find any data_cms");
//
//            $this->dispatcher->forward([
//                "controller" => "departments",
//                "action" => "index"
//            ]);
//
//            return;
//        }


        $paginator = new Paginator([
            'data' => $departments,
            'limit' => 2,
            'page' => $numberPage,
        ]);

        $this->view->page = $paginator->getPaginate();
        $this->tag->setDefault("Core_Depts_ID", $main_dept);
        $this->view->main_dept = $main_dept;
        $this->tag->setDefault("Module_ID", $this->request->getQuery("Module_ID"));
        $this->view->Module_ID = $this->request->getQuery("Module_ID");
        $Module_ID = $this->request->getQuery("Module_ID");
        //keyvalue
        $keyvalueempty = \DataKeyvalue::find(array(
            "Module_ID={$this->request->getQuery("Module_ID")} AND Depts_ID={$main_dept}"

        ));
        $this->view->keyvalueempty = $keyvalueempty;

        $big_array = array();
        $groups = \DataKeyvalueGroup::find(array(
            "Module_ID={$this->request->getQuery('Module_ID')} AND Is_Dept=1 AND Core='no'"
        ));
        foreach ($groups as $group) {
            //echo $group->GroupLang->Title."<br>";
            $dkvs = \DataKeyvalue::find(
                array("Group_ID={$group->ID} AND Depts_ID={$main_dept}")
            );
            foreach ($dkvs as $dkv) {

                $ad_kv = new KeyvalueOld();
                $big_array[] = array(
                    "GroupName" => "{$group->GroupLang->Title}",
                    "KeyValueTitle" => $dkv->DataKeyvalueLang->Title,
                    "ControlValue" => $ad_kv->keyvalueAddTags($dkv->CoreKeyvalueType->ID, "", $dkv->ID),
                    "Title" => $this->tag->textField(["KVAdd{$dkv->ID}Title", "type" => "text", "class" => "form-control", "id" => "fieldKVTitle"]),
                    "Des" => $this->tag->textField(["KVAdd{$dkv->ID}Des", "type" => "text", "class" => "form-control", "id" => "fieldKVDes"]),
                    "Img" => $this->tag->fileField(["KVAdd{$dkv->ID}Img", "type" => "text", "class" => "form-control", "id" => "fieldKVImg"]),
                    "Add" => "1",
                    "KV_ID" => $dkv->ID
                );
                unset($ad_kv);
            }
        }

        $this->view->keyValueData = $big_array;
        $module = \UsersApplicationModule::findFirst(["ID={$Module_ID}"]);
        $this->view->module = $module;
        $main_dept_obj = DataCmsDepts::findFirst("ID={$main_dept}");
        //////
        $language = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$language}'"]);
        $lang_id = $lang->id;
        $department = [];

        $department['ID'] = $main_dept_obj->ID;
        $get_title = \DataCmsDeptsLang::findFirst(["core_dept_id={$main_dept_obj->ID} AND lang_id={$lang_id}"]);
        if (!$get_title) {
            $title = $main_dept_obj->Title;
        } else {
            $title = $get_title->title;
        }
        $department['Title'] = $title;

        $this->view->department = $department;
        //////
        $this->view->main_department = $main_dept_obj;
        //get static translation
        $trans = [];
        $trans['Add Department'] = $this->getAdvancedTranslation($main_dept_obj->Module_ID, "Add Department", $main_dept_obj->ID);
        $this->view->static_trans = $trans;

        //language id for view language
        $lang_code = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$lang_code}'"]);

        //New Keyvalue Type
        $keyvalue = new Keyvalue();
        $category_attributes = $keyvalue->getKeyvalues(0, 2, $main_dept,null,$lang->id);
        $this->view->category_attributes = $category_attributes;

    }

    public function editAction($ID)
    {

        if (!$this->request->isPost()) {

            $dept = DataCmsDeptsRel::findFirstByID($ID);
            if (!$dept) {
                $this->flash->error("Department was not found");

                $this->dispatcher->forward([
                    'controller' => "Departments",
                    'action' => 'index'
                ]);

                return;
            }
            $Application = \UsersApplication::findFirst(["ID= {$this->session->get('auth-identity')['Application_ID']}"]);
            if (count($Application->Langs) == 0) {
                $this->view->has_langs = 0;
            } else {
                $this->view->has_langs = 1;

                $this->view->langs = $Application->getLangs(["is_default=0"]);

            }

            $this->view->dept = $dept;
            $this->view->ID = $dept->ID;
            $this->view->Module_ID = $dept->Module_ID;
            $this->tag->setDefault("ID", $dept->ID);
            $this->tag->setDefault("Title", $dept->Title);
            $this->tag->setDefault("Des", $dept->Des);
            $this->tag->setDefault("Img", $dept->Img);
            $this->tag->setDefault("Active", $dept->Active);
            $this->tag->setDefault("Orders", $dept->Orders);
            $this->tag->setDefault("Core_Depts_ID", $dept->Core_Depts_ID);
            $this->tag->setDefault("Application_ID", $dept->Application_ID);
            $this->tag->setDefault("Module_ID", $dept->Module_ID);
            $this->tag->setDefault("Lang_ID", $dept->Lang_ID);
            $this->view->Parent_ID = 0;
            if ($dept->Parent_Depts_ID == 0) {
                $this->tag->setDefault("Has_Parent", 'no');
            } else {
                $this->tag->setDefault("Has_Parent", 'yes');
                $this->tag->setDefault("Parent_Depts_ID", $dept->Parent_Depts_ID);
                $this->view->Parent_ID = $dept->Parent_Depts_ID;
            }
            if($dept->subject_to_maintenance == 1){
                $this->tag->setDefault("maintenance", 'yes');
            }else{
                $this->tag->setDefault("maintenance", 'no');
            }
            //Keyvalue
            $kv_data = \DataKeyvalue::find(array(
                "Depts_ID ={$dept->Core_Depts_ID}"
            ));
            $keyvalueitemdata = array();
            $keyvalueempty = array();
            foreach ($kv_data as $kv) {

                $kv_userdata = \DataKeyvalueUserdata::find(
                    array(
                        "DKV_ID = {$kv->ID} AND Item_ID={$dept->ID}"
                    )
                );
                if (count($kv_userdata) != 0) {
                    foreach ($kv_userdata as $kv_itemdata) {
                        $keyvalueitemdata[] = $kv_itemdata;
                    }
                } else {
                    $keyvalueempty[] = $kv;
                }
            }
            $this->view->kv_data = $kv_data;
            $this->view->keyvalueitemdata = $keyvalueitemdata;
            $this->view->keyvalueempty = $keyvalueempty;

            // Populate KeyValue Big Array
            $big_array = array();
            $groups = \DataKeyvalueGroup::find(array(
                "Module_ID={$dept->Module_ID} AND Is_Dept=1 AND Core='no'"
            ));
            foreach ($groups as $group) {
                //echo $group->GroupLang->Title."<br>";
                $dkvs = \DataKeyvalue::find(
                    array("Group_ID={$group->ID} AND Depts_ID={$dept->Core_Depts_ID}")
                );
                foreach ($dkvs as $dkv) {

                    $get_kv_data = \DataKeyvalueUserdata::find(
                        array("DKV_ID = {$dkv->ID} AND Item_ID={$ID} AND Module_ID={$dept->Module_ID} AND Application_ID={$dept->Application_ID}")
                    );
                    //die(var_dump($get_kv_data));
                    if (count($get_kv_data) == 0) {
                        $ad_kv = new KeyvalueOld();
                        $big_array[] = array(
                            "GroupName" => "{$group->GroupLang->Title}",
                            "KeyValueTitle" => $dkv->DataKeyvalueLang->Title,
                            "ControlValue" => $ad_kv->keyvalueAddTags($dkv->CoreKeyvalueType->ID, "", $dkv->ID),
                            "Title" => $this->tag->textField(["KVAdd{$dkv->ID}Title", "type" => "text", "class" => "form-control", "id" => "fieldKVTitle"]),
                            "Des" => $this->tag->textField(["KVAdd{$dkv->ID}Des", "type" => "text", "class" => "form-control", "id" => "fieldKVDes"]),
                            "Img" => $this->tag->fileField(["KVAdd{$dkv->ID}Img", "type" => "text", "class" => "form-control", "id" => "fieldKVImg"]),
                            "Add" => "1",
                            "KV_ID" => $dkv->ID
                        );
                        unset($ad_kv);
                    } elseif ($get_kv_data) {
                        $ad_kv = new KeyvalueOld();
                        foreach ($get_kv_data as $get_kv_data_value) {
                            $big_array[] = array(
                                "GroupName" => "{$group->GroupLang->Title}",
                                "KeyValueTitle" => $get_kv_data_value->DataKeyvalue->DataKeyvalueLang->Title,
                                "ControlValue" => $ad_kv->keyvalueEditTags($get_kv_data_value->DKV_ID, $get_kv_data_value->Datakeyvalue->CoreKeyvalueType->ID, $get_kv_data_value->Value, $get_kv_data_value->ID),
                                "Title" => $this->tag->textField(["KV{$get_kv_data_value->ID}Title", "type" => "text", "class" => "form-control", "id" => "fieldKVTitle", "value" => "{$get_kv_data_value->Title}"]),
                                "Des" => $this->tag->textField(["KV{$get_kv_data_value->ID}Des", "type" => "text", "class" => "form-control", "id" => "fieldKVDes", "value" => "{$get_kv_data_value->Des}"]),
                                "Img" => $this->tag->fileField(["KV{$get_kv_data_value->ID}Img", "type" => "text", "class" => "form-control", "id" => "fieldKVImg", "value" => "{$get_kv_data_value->Img}"]),
                                "Add" => 0
                            );
                            unset($ad_kv);
                        }
                    }
                }
            }
            $this->view->keyValueData = $big_array;
            if (isset($_GET['lang_id'])) {
                $lang_id = $_GET['lang_id'];
                $data_cms_lang = \DataCmsDeptsRelLang::findFirst(["dept_id={$ID} AND lang_id={$lang_id}"]);
                $this->tag->setDefault("Title", $data_cms_lang->title);
                $this->tag->setDefault("Des", $data_cms_lang->des);
            }
            $module = \UsersApplicationModule::findFirst(["ID={$dept->Module_ID}"]);
            $this->view->module = $module;
            $main_dept_obj = DataCmsDepts::findFirst("ID={$dept->Core_Depts_ID}");
            $this->view->main_department = $main_dept_obj;

            //language id for view language
                             $lang_code = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$lang_code}'"]);
        $this->view->lang = $lang->id;
            //New Keyvalue Type
            $keyvalue = new Keyvalue();
            $category_attributes = $keyvalue->getKeyvalues(0, 2, $dept->Core_Depts_ID,null,$lang->id);
            $this->view->category_attributes = $category_attributes;
            //Set Default Keyvalues Type 2
            $data_kv_dept_cms=\DataKeyvalueDeptCms::find(["dept_id={$dept->ID}"]);
            foreach ($data_kv_dept_cms as $v){
                $this->tag->setDefault("keyvalue_attribute{$v->dkv_id}", $v->dkv_id);
            }


        }

    }

    public function newAction($Module_ID)
    {
        $this->tag->setDefault("Module_ID", $Module_ID);


    }

    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward(
                [
                    "controller" => "departments",
                    "action" => "index",
                ]
            );
        }

        $dept = new DataCmsDeptsRel();
        $dept->created_at = time();
        $dept->Title = $this->request->getPost("Title");
        $dept->Des = $this->request->getPost("Des");
        $dept->Active = $this->request->getPost("Active");
        $dept->Orders = $this->request->getPost("Orders");
        $dept->Core_Depts_ID = $this->request->getPost("Core_Depts_ID");
        if ($this->request->hasFiles() == true) {
            //die("islam");
            foreach ($this->request->getUploadedFiles() as $file) {
                $random = new Random();
                $random_name = $random->uuid() . "." . $file->getExtension();
                if ($file->getName() != "") {
                    $dept->Img = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                }
            }
        }
        if ($this->request->getPost("Has_Parent") == "no") {
            $dept->Parent_Depts_ID = 0;
        } else {
            $dept->Parent_Depts_ID = $this->request->getPost("Parent_Depts_ID");
        }
        if ($this->request->getPost("maintenance") == "no") {
            $dept->subject_to_maintenance = 0;
        } else {
            $dept->subject_to_maintenance = 1;
        }

        $dept->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $dept->Module_ID = $this->request->getPost("Module_ID");
        $dept->Lang_ID = 1;
        if (!$dept->save()) {

            foreach ($dept->getMessages() as $message) {
                $this->flash->error($message);
            }

//            $this->dispatcher->forward([
//                'controller' => "departments",
//                'action' => 'edit',
//                'params' => [$dept->ID]
//            ]);

            return;
        }

        $keyvalue = new KeyvalueOld();
        $keyvalue->saveKeyvalue($dept->ID);

        //check for attributes
        $keyvalue = new Keyvalue();
        $category_attributes = $keyvalue->getKeyvalues(0, 2, $dept->Core_Depts_ID);
        foreach ($category_attributes as $group) {
            foreach ($group['keyvalues'] as $attribute) {
                if ($this->request->getPost("keyvalue_attribute{$attribute['kv_id']}")) {
                    $data_keyvalue_dept_cms = \DataKeyvalueDeptCms::findFirst(["dkv_id={$attribute['kv_id']} and dept_id={$dept->ID}"]);
                    if (!$data_keyvalue_dept_cms) {
                        $data_keyvalue_dept_cms = new \DataKeyvalueDeptCms();
                        $data_keyvalue_dept_cms->dkv_id = $attribute['kv_id'];
                        $data_keyvalue_dept_cms->dept_id = $dept->ID;
                        $data_keyvalue_dept_cms->application_id = $dept->Application_ID;
                        if (!$data_keyvalue_dept_cms->save()) {
                            foreach ($data_keyvalue_dept_cms->getMessages() as $msg) {
                                $this->falshSession->error($msg);
                            }
                        };
                    }
                }
            }
        }
        $this->flashSession->success("Department was Added successfully");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);


    }

    public function saveAction()
    {

        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "departments",
                'action' => 'index'
            ]);

            return;
        }

        $ID = $this->request->getPost("ID");
        $dept = DataCmsDeptsRel::findFirst($ID);
        if (!$dept) {
            $this->flash->error("Department does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "Departments",
                'action' => 'index'
            ]);

            return;
        }
        //handling translated content
        if (isset($_GET['lang_id'])) {
            $lang_id = $_GET['lang_id'];
            $data_cms_lang = \DataCmsDeptsRelLang::findFirst("dept_id={$ID} AND lang_id={$lang_id}");
            if ($data_cms_lang) {
                $data_cms_lang->title = $this->request->getPost("Title");
                $data_cms_lang->des = $this->request->getPost("Des");
                $data_cms_lang->save();
            } else {
                $data_cms_lang = new \DataCmsDeptsRelLang();
                $data_cms_lang->lang_id = $lang_id;
                $data_cms_lang->title = $this->request->getPost("Title") ?: "";
                $data_cms_lang->des = $this->request->getPost("Des") ?: "";
                $data_cms_lang->dept_id = $ID;
                if (!$data_cms_lang->save()) {
                    foreach ($data_cms_lang->getMessages() as $message) {
                        $this->flashSession->error($message);
                    }
                }

            }


        } else {
            $dept->Title = $this->request->getPost("Title");
            $dept->Des = $this->request->getPost("Des");
        }

        $dept->Active = $this->request->getPost("Active");
        $dept->Orders = $this->request->getPost("Orders");
        $dept->Core_Depts_ID = $this->request->getPost("Core_Depts_ID");
        if ($this->request->hasFiles() == true) {
            //die("islam");
            foreach ($this->request->getUploadedFiles() as $file) {
                $random = new Random();
                $random_name = $random->uuid() . "." . $file->getExtension();
                if ($file->getName() != "") {
                    $dept->Img = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                }
            }
        }
        if ($this->request->getPost("Has_Parent") == 'no') {
            $dept->Parent_Depts_ID = 0;
        } else {
            $dept->Parent_Depts_ID = $this->request->getPost("Parent_Depts_ID");
        }
        if ($this->request->getPost("maintenance") == "no") {
            $dept->subject_to_maintenance = 0;
        } else {
            $dept->subject_to_maintenance = 1;
        }
        $dept->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $dept->Module_ID = $this->request->getPost("Module_ID");
        $dept->Lang_ID = 1;
        if (!$dept->save()) {

            foreach ($dept->getMessages() as $message) {
                $this->flash->error($message);
            }

//            $this->dispatcher->forward([
//                'controller' => "departments",
//                'action' => 'edit',
//                'params' => [$dept->ID]
//            ]);

            return;
        }

        $keyvalue = new KeyvalueOld();
        $keyvalue->saveKeyvalue($ID);

        //check for attributes
        $data_kv_dept_cms=\DataKeyvalueDeptCms::find(["dept_id={$dept->ID}"]);
        foreach ($data_kv_dept_cms as $v){
            $v->delete();
        }
        $keyvalue = new Keyvalue();
        $category_attributes = $keyvalue->getKeyvalues(0, 2, $dept->Core_Depts_ID);
        foreach ($category_attributes as $group) {
            foreach ($group['keyvalues'] as $attribute) {
                if ($this->request->getPost("keyvalue_attribute{$attribute['kv_id']}")) {
                    $data_keyvalue_dept_cms = \DataKeyvalueDeptCms::findFirst(["dkv_id={$attribute['kv_id']} and dept_id={$dept->ID}"]);
                    if (!$data_keyvalue_dept_cms) {
                        $data_keyvalue_dept_cms = new \DataKeyvalueDeptCms();
                        $data_keyvalue_dept_cms->dkv_id = $attribute['kv_id'];
                        $data_keyvalue_dept_cms->dept_id = $dept->ID;
                        $data_keyvalue_dept_cms->application_id = $dept->Application_ID;
                        if (!$data_keyvalue_dept_cms->save()) {
                            foreach ($data_keyvalue_dept_cms->getMessages() as $msg) {
                                $this->falshSession->error($msg);
                            }
                        };
                    }
                }
            }
        }


        $this->flashSession->success("Department was updated successfully");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);

//        $this->dispatcher->forward([
//            'controller' => "content",
//            'action' => 'index',
//            'params' => [$content->ID]
//        ]);

    }

    public function deleteAction($ID)
    {
        $dept = DataCmsDeptsRel::findFirstByID($ID);
        if (!$dept) {
            $this->flash->error("Department does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "Departments",
                'action' => 'index'
            ]);

            return;
        }
        $dept->delete();
        if ($this->request->isAjax()) {
            return;
        }
        $this->flash->success("Department was deleted successfully");
    }

    public function departmentsviewAction()
    {

    }

    public function ajaxContentAction($main_dept)
    {
        $this->view->disable();
        if ($this->request->isAjax()) {

            $departments = DataCmsDeptsRel::find(array(
                "Core_Depts_ID = {$main_dept}",
                "order" => "ID Desc"
            ));
            $array = $this->modelsManager->createQuery("SELECT * FROM DataCmsDeptsRel WHERE Core_Depts_ID = {$main_dept}")
                ->execute()->toArray();
            foreach ($array as $k => $v) {
                if($this->session->get('auth-identity')['Lang_ID']==1){
                    $dept_lang = \DataCmsDeptsRelLang::findFirst(["dept_id={$v["ID"]} AND lang_id=1"]);
                    if($dept_lang){
                        $array[$k]["Title"] = $dept_lang->title;
                        $array[$k]["Des"] = $dept_lang->des;
                    }
                }

                //$array[$k]["Date"] = date('m/d/Y', $v["DateTime"]);
                //$array[$k]["Time"] = date('H:i:s', $v["DateTime"]);
            }

            $dataTables = new DataTable();
            $dataTables->fromArray($array)->sendResponse();

        }

    }

    public function ajaxDeleteAction()
    {
        if ($this->request->isAjax()) {
            //die(var_dump($_POST['deleteCheckbox']));
            if (isset($_POST['checkboxes'])) {
                foreach ($_POST['checkboxes'] as $ID) {
                    $this->deleteAction($ID);
                }
                return "1";
            } else {
                return "0";
            }

        }

    }

    public function ajaxActiveAction()
    {
        if ($this->request->isAjax()) {
            if (isset($_POST['checkboxes'])) {
                foreach ($this->request->getPost("checkboxes") as $ID) {
                    $content = DataCmsDeptsRel::findFirst(array("ID={$ID}"));
                    $content->Active = 1;
                    $content->save();
                }
                return "1";
            } else {
                return "0";
            }

        }

    }

    public function ajaxDeactiveAction()
    {
        if ($this->request->isAjax()) {
            if (isset($_POST['checkboxes'])) {
                foreach ($this->request->getPost("checkboxes") as $ID) {
                    $content = DataCmsDeptsRel::findFirst(array("ID={$ID}"));
                    $content->Active = 0;
                    $content->save();
                }
                return "1";
            } else {
                return "0";
            }

        }

    }

    public function searchAction($main_dept)
    {
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataCmsDeptsRel', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }
        $Title = $this->request->getQuery("Title");
        $active = $this->request->getQuery("active");
//        $main_dept = $main_dept;
        $search = DataCmsDeptsRel::find(array(
            "Title LIKE '%" . $Title . "%' AND Active={$active} AND Core_Depts_ID={$main_dept}"
        ));
        $paginator = new Paginator([
            'data' => $search,
            'limit' => 2,
            'page' => $numberPage,
        ]);

        $this->view->Title = $Title;
        $this->view->active = $active;
        $this->view->main_dept = $main_dept;
        $this->view->page = $paginator->getPaginate();
    }


}