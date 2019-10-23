<?php


/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 12/11/2016
 * Time: 4:50 PM
 */


namespace Vokuro\Pentavalue;


use Phalcon\Mvc\User\Component;


use Phalcon\Security\Random;


use \DataKeyvalueValidationSettings;

use Phalcon\Validation;

use Phalcon\Validation\Validator\Digit as DigitValidator;

use Phalcon\Validation\Validator\Url as UrlValidator;

use Phalcon\Validation\Validator\Numericality as NumericalityValidator;
use Vokuro\Models\DataKeyvalueEntity;


class Keyvalue extends Component


{


    const UPLOAD_LOCATION = 'uploads/';


    const UPLOAD_TEMP = 'uploads/temp/';



    public function showKvCheck($DKV_ID)

    {


        $settings = \DataKeyvalueShowSettings::findFirst(["dkv_id={$DKV_ID}"]);


        if (!$settings) {


            return ["Title" => "1", "Des" => "1", "Img" => "1"];


        }


        return ["Title" => $settings->title, "Des" => $settings->des, "Img" => $settings->img];


    }


    public function validateKeyvalue($validation_arr, $kv_type)
    {

        $validator = new Validation();
        $result = true;

        switch ($kv_type) {
            case 0 :
                return true;
            case 7 :
                return true;
                break;
            case 1 :
                return true; //number
                // $validator->add(
                // $validation_arr['key'],
                // new NumericalityValidator([
                // 'message' => 'not a valid number'
                // ])
                // );
//
                // $messages = $validator->validate($validation_arr);
                // if(count($messages))
                // {
                // $this->flashSession->error($messages[0]);
                // $result = false;
                // }
                break;

            case 2 : // mobile
                return true;
                // $validator->add(
                // $validation_arr['key'],
                // new DigitValidator([
                // 'message' => 'mobile not valid'
                // ])
                // );
                // $messages = $validator->validate($validation_arr);
                // if(count($messages))
                // {
                // $this->flashSession->error($messages[0]);
                // $result = false;
                // }
                // $result = preg_match('/^[0-9]{11}+$/', $validation_arr['key']);
                // $result = ($result == 0)?false:true;
                break;

            case 3 : //time
                $result = (\DateTime::createFromFormat('H:i', $validation_arr['key']) !== false);
                break;

            case 4 : //datetime
                $result = (\DateTime::createFromFormat('Y-m-d H:i:s', $validation_arr['key']) !== false);
                break;

            case 5 : //link
                $validator->add(
                    $validation_arr['key'],
                    new UrlValidator([
                        'message' => 'not valid url'
                    ])
                );
                $messages = $validator->validate($validation_arr);
                if (count($messages)) {
                    $this->flashSession->error($messages[0]);
                    $result = false;
                }
                break;

            case 6 : //date
                $result = (\DateTime::createFromFormat('Y-m-d', $validation_arr['key']) !== false);
                break;

            default:
                $result = false;
                break;
        }

        return $result;
    }

    public function getKeyvalues($module_id,$is_dept=null,$main_dept_id=null,$dept_id=null,$lang_id=2){
        if($is_dept==null){
            $groups = \DataKeyvalueGroup::find(["Module_ID={$module_id} and Is_Dept=0"]);
        }elseif($is_dept==1){
            $groups = \DataKeyvalueGroup::find(["Module_ID={$module_id} and Is_Dept=1 and Depts_ID={$main_dept_id}"]);
        }elseif($is_dept==2 && $main_dept_id!=null){
            $groups = \DataKeyvalueGroup::find(["Is_Dept=2 and Depts_ID={$main_dept_id}"]);
        }

        $result =[];
        foreach ($groups as $group){
            $row=[];
            $row["group_id"]= $group->ID;
            $group_title =$group->GroupLang->Title;
            $group_title_find = $group->getGroupLang(["Lang_ID={$lang_id}"]);
            if($group_title_find){
                $group_title= $group_title_find->Title;
            }
            $row["group_name"]= $group_title;
            $row["keyvalues"] =[];
            foreach ($group->KeyValue as $keyvalue){
                if($group->Is_Dept == 2 && $module_id!=0){
                    if(!$keyvalue->getDept(["dept_id={$dept_id}"])){
                        $result =[];
                        continue;
                    }
                }
                //check subject to maintenance if any
                $show_maintenance = $keyvalue->getDept();
                if($show_maintenance){
                    if($keyvalue->getDept()->subject_to_maintenance ==1){
                        continue;
                    }

                }
                $kv["kv_id"]= $keyvalue->ID;
                $kv["kv_type_id"] =$keyvalue->CKV_ID;
                $kv["kv_type"] =$this->getKeyvalueType($keyvalue->CKV_ID);
                $kv_title =$keyvalue->DataKeyvalueLang->Title;
                $kv_title_find = $keyvalue->getDataKeyvalueLang("Lang_ID={$lang_id}");
                if($kv_title_find){
                    $kv_title= $kv_title_find->Title;
                }
                $kv["title"] =$kv_title;
                $kv['showSettings']= $this->getKeyvalueShowSettings($kv['kv_id']);
                $kv['multi_options']=$this->getKeyvalueMultiOptions($keyvalue->CKV_ID,$keyvalue->ID);
                $kv['validation_classes']=$this->getKeyvalueValidateClasses($keyvalue->ID);
                $kv['has_langs']=$keyvalue->has_langs;
                $row["keyvalues"][]=$kv;
            }
            $result[]=$row;
        }
        return $result;
    }

    public function getKeyvalueUserdata($item_id){
        $keyvalue_userdata= \DataKeyvalueUserdata::find(["Item_ID={$item_id}"]);
        $result=[];
        foreach ($keyvalue_userdata as $value){
            $row=[];
            $row['id']= $value->ID;
            $row['kv_id']= $value->DKV_ID;
            $row['kv_type_id'] = $value->DataKeyvalue->CKV_ID;
            $row['has_langs'] = $value->DataKeyvalue->has_langs;
            $row['title']=$value->Title;
            $row['des']=$value->Des;
            $row['value']=$value->Value;
            //$row['showSettings']= $this->getKeyvalueShowSettings($row['kv_id']);
            $row['langs']=[];
            foreach($value->Langs as $item){
                $lang=[];
                $lang["lang_id"]=$item->lang_id;
                $lang["value"]=$item->value;
                $lang["des"]=$item->des;
                $lang["title"]=$item->title;
                $row['langs'][]= $lang;
            }
            $row['img']=$value->Img;
            $result[]= $row;
        }
        return $result;
    }

    public function setKeyvalueUserdata($item_id,$module_id){
        $module_keyvalues = \DataKeyvalue::find(["Module_ID={$module_id}"]);
        foreach ($module_keyvalues as $keyvalue){
            if($keyvalue->CKV_ID==4){
                $keyvalue_userdata= \DataKeyvalueUserdata::findFirst(["DKV_ID={$keyvalue->ID} AND Item_ID={$item_id}"]);
                if(!$keyvalue_userdata){
                    $keyvalue_userdata = new \DataKeyvalueUserdata();
                    $keyvalue_userdata->Time = time();
                    $keyvalue_userdata->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                    $keyvalue_userdata->Module_ID = $module_id;
                    $keyvalue_userdata->DKV_ID = $keyvalue->ID;
                    $keyvalue_userdata->Item_ID = $item_id;
                    $keyvalue_userdata->Lang_ID = 0;
                }
                $keyvalue_userdata->Title = $this->request->getPost("keyvalue_title_default{$keyvalue->ID}") ?:  "";
                $keyvalue_userdata->Des = $this->request->getPost("keyvalue_des_default{$keyvalue->ID}")?: "";
                $keyvalue_userdata->Value = $this->setKeyvalueValue($keyvalue->CKV_ID,$this->request->getPost("keyvalue_value_default{$keyvalue->ID}"),"keyvalue_value_default{$keyvalue->ID}");
                if(!$keyvalue_userdata->save()){
                    foreach($keyvalue_userdata->getMessages() as $message){
                        $this->flashSession->error($message);
                    }
                }
            };
            if($this->request->getPost("keyvalue_value_default{$keyvalue->ID}")){
                $keyvalue_userdata= \DataKeyvalueUserdata::findFirst(["DKV_ID={$keyvalue->ID} AND Item_ID={$item_id}"]);
                if(!$keyvalue_userdata){
                    $keyvalue_userdata = new \DataKeyvalueUserdata();
                    $keyvalue_userdata->Time = time();
                    $keyvalue_userdata->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                    $keyvalue_userdata->Module_ID = $module_id;
                    $keyvalue_userdata->DKV_ID = $keyvalue->ID;
                    $keyvalue_userdata->Item_ID = $item_id;
                    $keyvalue_userdata->Lang_ID = 0;
                }
                $keyvalue_userdata->Title = $this->request->getPost("keyvalue_title_default{$keyvalue->ID}") ?:  "";
                $keyvalue_userdata->Des = $this->request->getPost("keyvalue_des_default{$keyvalue->ID}")?: "";
                $keyvalue_userdata->Value = $this->setKeyvalueValue($keyvalue->CKV_ID,$this->request->getPost("keyvalue_value_default{$keyvalue->ID}"),"keyvalue_value_default{$keyvalue->ID}");
                if(!$keyvalue_userdata->save()){
                    foreach($keyvalue_userdata->getMessages() as $message){
                        $this->flashSession->error($message);
                    }
                }
                //save langs if applicable
                if($keyvalue_userdata->DataKeyvalue->has_langs == 1){
                    $application_languages = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND is_default=0"]);
                    foreach ($application_languages as $app_lang){
                        if(!$this->request->getPost("keyvalue_value_lang{$keyvalue->ID}_{$app_lang->lang_id}")){
                            continue;
                        }
                        $keyvalue_userdata_lang = \DataKeyvalueUserdataLang::findFirst(["kv_userdata_id={$keyvalue_userdata->ID}"]);
                        if(!$keyvalue_userdata_lang){
                            $keyvalue_userdata_lang = new \DataKeyvalueUserdataLang();
                            $keyvalue_userdata_lang->kv_userdata_id= $keyvalue_userdata->ID;
                            $keyvalue_userdata_lang->lang_id=$app_lang->lang_id;
                            $keyvalue_userdata_lang->dkv_id=$keyvalue->ID;
                            $keyvalue_userdata_lang->item_id=$keyvalue_userdata->Item_ID;
                            $keyvalue_userdata_lang->module_id=$keyvalue_userdata->Module_ID;
                            $keyvalue_userdata_lang->application_id=$keyvalue_userdata->Application_ID;

                        }
                        $keyvalue_userdata_lang->value = $this->request->getPost("keyvalue_value_lang{$keyvalue->ID}_{$app_lang->lang_id}");
                        $keyvalue_userdata_lang->title = $this->request->getPost("keyvalue_title_lang{$keyvalue->ID}_{$app_lang->lang_id}");
                        $keyvalue_userdata_lang->des = $this->request->getPost("keyvalue_des_lang{$keyvalue->ID}_{$app_lang->lang_id}");
                        if(!$keyvalue_userdata_lang->save()){
                            foreach ($keyvalue_userdata_lang->getMessages() as $e){
                                $this->flashSession->error($e);
                            }

                        };
                    }

                }

            }

        }
        return true;

    }

    public function getKeyvalueType($ckv_id){
        switch ($ckv_id){
            case 1:
                return "select";
                break;
            case 2:
                return "text";
                break;
            case 3:
                return "checkfield";
                break;
            case 4:
                return "file";
                break;
            case 5:
                break;
            case 6:
                break;
            case 7:
                return "db";
                break;
            case 8:
                return "entity";
            break;

        }
    }

    public function getKeyvalueMultiOptions($ckv_id,$kv_id){

        if($ckv_id!=1 && $ckv_id!=3 && $ckv_id!=8){
            return [];
        }
        elseif($ckv_id==8){
            return $this->getKeyvalueEntityOptions($kv_id);
        }
        $options = \DataKeyvalueOption::find(["DKV_ID={$kv_id}"]);
        $row=[];
        foreach ($options as $option){
            $row[$option->ID] = $option->OptionLang->Title;
        }
        return $row;
    }
    public function setKeyvalueValue($ckv_id,$value,$key){
        if($ckv_id==3){
            $str = implode (",", $value);
            return $str;
        }
        elseif($ckv_id==8){
            $str = implode (",", $value);
            return $str;
        }
        elseif($ckv_id==4){

            foreach ($this->request->getUploadedFiles() as $file) {

                if ($file->getKey() == $key) {

                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                        return $random_name;
                    }
                }
            }
            return $random_name;
        }
        return $value;
    }

    public function getKeyvalueEntityOptions($kv_id){
        $row=[];
        $data_keyvalue_entity = DataKeyvalueEntity::findFirst(["dkv_id={$kv_id}"]);
        if(!$data_keyvalue_entity){
           return $row;
        }
        $model_name= $data_keyvalue_entity->SetupEntities->model_name;
        $model= new $model_name();
        $options = $model->find();
        foreach ($options as $option){
            $row[$option->id] = $option->name;
        }
        return $row;

    }

    public function getKeyvalueShowSettings($kv_id)
    {
        $settings = \DataKeyvalueShowSettings::findFirst(["dkv_id={$kv_id}"]);
        if(!$settings){
            $settings = new \DataKeyvalueShowSettings();
            $settings->dkv_id = $kv_id;
            $settings->title=0;
            $settings->des=0;
            $settings->img=0;
            $settings->save();
        }
        $result['title']=$settings->title;
        $result['des']=$settings->des;
        $result['img']=$settings->img;
        return $result;
    }

    public function getKeyvalueValidateClasses($kv_id)
    {
        $kv_validation_settings = DataKeyvalueValidationSettings::findFirst(["dkv_id=$kv_id"]);
        $validation_class = " ";
        if ($kv_validation_settings) {
            if ($kv_validation_settings->req == 1) {
                $validation_class .= "KvRequired ";
            }
        }else{
            return $validation_class;
        }

        switch ($kv_validation_settings->kv_type) {
            case 1 :
                $validation_class = "KvNumber ";
                break;
            case 2 :
                $validation_class = "KvMobile ";
                break;
            case 3 :
                $validation_class = "KvTime ";
                break;
            case 4 :
                $validation_class = "KvDateTime ";
                break;
            case 5 :
                $validation_class = "KvLink ";
                break;
            case 6 :
                $validation_class = "KvDate ";
                break;
            case 7 :
                $validation_class = "";
                break;
        }

        return $validation_class;
    }

}