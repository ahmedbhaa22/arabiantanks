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


class KeyvalueOld extends Component


{


    const UPLOAD_LOCATION = 'uploads/';


    const UPLOAD_TEMP = 'uploads/temp/';


    public function keyvalueEditTags($DKV_ID, $type_id, $value = "", $kv_id)


    {

        $kv_validation_settings = DataKeyvalueValidationSettings::findFirst(["dkv_id=$DKV_ID"]);

        $req = "";

        $validation_class = "";

        if ($kv_validation_settings) {

            if ($kv_validation_settings->req == 1) {

                $req = "KvRequired";

            }

        }

        switch ($kv_validation_settings->kv_type) {

            case 1 :

                $validation_class = "KvNumber";

                break;

            case 2 :

                $validation_class = "KvMobile";

                break;

            case 3 :

                $validation_class = "KvTime";

                break;

            case 4 :

                $validation_class = "KvDateTime";

                break;

            case 5 :

                $validation_class = "KvLink";

                break;

            case 6 :

                $validation_class = "KvDate";

                break;

        }


        switch ($type_id) {


            case 1 :


                $value_array = explode(',', $value);

                $kv_option_array = array();

                $lang = 1;

                $GetOptions = \DataKeyvalueOption::find(array("DKV_ID={$DKV_ID}"));

                foreach ($GetOptions as $option) {

                    foreach ($option->getDataKeyvalueOptionLang(["Lang_ID={$lang}"]) as $kv_option_lang) {

                        if (in_array($kv_option_lang->Option_ID, $value_array)) {

                            $kv_option_array[] = array(

                                "Value" => $kv_option_lang->Option_ID,


                                "Title" => $kv_option_lang->Title,


                                "selected" => 'selected="selected"',


                            );

                        } else {

                            $kv_option_array[] = array(

                                "Value" => $kv_option_lang->Option_ID,


                                "Title" => $kv_option_lang->Title,


                                "selected" => '',


                            );

                        }


                    }

                }


                $output = "<div><span></span><select id=\"fieldActive\" name=\"keyvalue{$kv_id}\" class=\"form-control\">";


                foreach ($kv_option_array as $options) {


                    $output .= "



                 <option value='{$options["Value"]}' {$options['selected']}>{$options['Title']}</option>



                ";


                }


                $output .= "</select></div>";


                return $output;


            case 2 :


                if ($value == "") {


                    return \Phalcon\Tag::textField(["keyvalue{$kv_id}", "type" => "number", "class" => "form-control {$validation_class}", "id" => "fieldkeyvalue{$kv_id}"]);


                }


                return \Phalcon\Tag::textField(["keyvalue{$kv_id}", "type" => "number", "class" => "form-control {$validation_class}", "id" => "fieldkeyvalue{$kv_id}", "value" => $value]);


            case 3 :


                $value_array = explode(',', $value);

                $kv_option_array = array();

                $lang = 1;

                $GetOptions = \DataKeyvalueOption::find(array("DKV_ID={$DKV_ID}"));
                $calss = "";
                if ($DKV_ID == 97) {
                    $class = "checkMoodLength";
                } elseif ($DKV_ID == 100) {
                    $class = "checkOutInLength";
                } elseif ($DKV_ID == 101) {
                    $class = "checkTypeLength";
                }
                foreach ($GetOptions as $option) {

                    foreach ($option->getDataKeyvalueOptionLang(["Lang_ID={$lang}"]) as $kv_option_lang) {

                        if (in_array($kv_option_lang->Option_ID, $value_array)) {

                            $kv_option_array[] = array(

                                "Value" => $kv_option_lang->Option_ID,


                                "Title" => $kv_option_lang->Title,


                                "checked" => 'checked',


                            );

                        } else {

                            $kv_option_array[] = array(

                                "Value" => $kv_option_lang->Option_ID,


                                "Title" => $kv_option_lang->Title,


                                "checked" => '',


                            );

                        }


                    }

                }


                // die(print_r($kv_option_array));


                $output = "";


                foreach ($kv_option_array as $options) {


                    $output .= "



                 <div><span>{$options["Title"]}</span><input type='checkbox' name='kvCheck{$kv_id}[]' class='{$class}' value='{$options["Value"]}' {$options["checked"]}></div>



                ";


                }


                return $output;


            case 4:


                return \Phalcon\Tag::fileField(["kvUpload{$kv_id}", "size" => 30, "class" => "form-control", "value" => "{$value}"]);


            case 5 :


                if ($value == "") {


                    return \Phalcon\Tag::textField(["keyvalue{$kv_id}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$kv_id}"]);


                }


                return \Phalcon\Tag::textField(["keyvalue{$kv_id}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$kv_id}", "value" => $value]);


            case 6 :


                if ($value == "") {


                    return \Phalcon\Tag::textField(["keyvalue{$kv_id}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$kv_id}"]);


                }


                return \Phalcon\Tag::textField(["keyvalue{$kv_id}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$kv_id}", "value" => $value]);


            case 7 :


                $data_kv_db = \Models\DataKeyvalueDb::findFirst(["DKV_ID={$DKV_ID}"]);

                foreach ($data_kv_db->Depts as $dept) {


                }

                \Phalcon\Tag::setDefault("keyvalue{$kv_id}", "$value");

                //die($value);

                return \Phalcon\Tag::select(

                    [

                        "keyvalue{$kv_id}",

                        $data_kv_db->Depts,

                        "using" => [

                            "ID",

                            "Title",

                        ],

                        "useEmpty" => true,

                        "emptyText" => "",

                        "emptyValue" => "0",

                    ]);


            default:


                return "The Default Text Box";


        }


    }


    public function keyvalueAddTags($type_id, $value = "", $DKV)


    {


        $kv_validation_settings = DataKeyvalueValidationSettings::findFirst(["dkv_id=$DKV"]);

        $req = "";

        $validation_class = "";

        if ($kv_validation_settings) {

            if ($kv_validation_settings->req == 1) {

                $req = "KvRequired";

            }

        }

        switch ($kv_validation_settings->kv_type) {

            case 1 :

                $validation_class = "KvNumber";

                break;

            case 2 :

                $validation_class = "KvMobile";

                break;

            case 3 :

                $validation_class = "KvTime";

                break;

            case 4 :

                $validation_class = "KvDateTime";

                break;

            case 5 :

                $validation_class = "KvLink";

                break;

            case 6 :

                $validation_class = "KvDate";

                break;

            case 7 :

                $validation_class = "";


                break;

        }


        switch ($type_id) {


            case 1 :

                $kv_option_array = array();

                $lang = 1;

                $GetOptions = \DataKeyvalueOption::find(array("DKV_ID={$DKV}"));

                foreach ($GetOptions as $option) {

                    foreach ($option->getDataKeyvalueOptionLang(["Lang_ID={$lang}"]) as $kv_option_lang) {

                        $kv_option_array[] = array(


                            "Value" => $kv_option_lang->Option_ID,


                            "Title" => $kv_option_lang->Title,


                            "selected" => '"',


                        );

                    }

                }

                $output = "<div><span></span><select id=\"keyvalueAdd{$DKV}\" name=\"keyvalueAdd{$DKV}\" class=\"form-control\"><option value='0'></option>";

                foreach ($kv_option_array as $options) {

                    $output .= "



                 <option value='{$options["Value"]}' {$options['selected']}>{$options['Title']}</option>



                ";


                }


                $output .= "</select></div>";


                return $output;


            case 2 :


                if ($value == "") {

                    return \Phalcon\Tag::textField(["keyvalueAdd{$DKV}", "type" => "text", "class" => "form-control {$validation_class} {$req}", "id" => "fieldkeyvalueAdd{$DKV}"]);


                }


                return \Phalcon\Tag::textField(["keyvalueAdd{$DKV}", "type" => "text", "class" => "form-control {$validation_class} {$req}", "id" => "fieldkeyvalueAdd{$DKV}"]);


            case 3 :

                $kv_option_array = array();

                $lang = 1;

                $GetOptions = \DataKeyvalueOption::find(array("DKV_ID={$DKV}"));
                $class = "";
                if ($DKV == 97) {
                    $class = "checkMoodLength";
                } elseif ($DKV == 100) {
                    $class = "checkOutInLength";
                } elseif ($DKV == 101) {
                    $class = "checkTypeLength";
                }

                foreach ($GetOptions as $option) {

                    foreach ($option->getDataKeyvalueOptionLang(["Lang_ID={$lang}"]) as $kv_option_lang) {

                        $kv_option_array[] = array(


                            "Value" => $kv_option_lang->Option_ID,


                            "Title" => $kv_option_lang->Title,


                            "checked" => '',


                        );

                    }

                }

                $output = "";


                foreach ($kv_option_array as $options) {


                    $output .= "



                 <div><span>{$options["Title"]}</span><input type='checkbox' class='$class' name='kvAddCheck" . $DKV . "[]' value='{$options["Value"]}'></div>



                ";


                }


                return $output;


            case 4:


                return \Phalcon\Tag::fileField(["kvAddUpload{$DKV}", "size" => 30, "class" => "form-control", "id" => "fieldkeyvalue{$DKV}"]);


            case 5 :


                return \Phalcon\Tag::textField(["keyvalueAdd{$DKV}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$DKV}"]);


            case 6 :


                return \Phalcon\Tag::textField(["keyvalueAdd{$DKV}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$DKV}"]);


            case 7 :


                $data_kv_db = \Models\DataKeyvalueDb::findFirst(["DKV_ID={$DKV}"]);

                return \Phalcon\Tag::select(

                    [

                        "keyvalueAdd{$DKV}",

                        $data_kv_db->Depts,

                        "using" => [

                            "ID",

                            "Title",

                        ],

                        "useEmpty" => true,

                        "emptyText" => "",

                        "emptyValue" => "0",

                    ]);


            default:


                return "The Default Text Box";


        }


    }


    public function returnAddValidation($DKV)


    {


        switch ($DKV) {


            case 1:


                $datakeyvalue = \DataKeyvalue::findFirst(array("ID = {$DKV}"));


                //die($datakeyvalue->ID."  ".$datakeyvalue->CKV_ID);


                if ($datakeyvalue->DataKeyvalueLang->ID == "1") {


                    return "                    



                keyvalueAdd{$DKV}: {



                    url: true,



                },        



                {$this->returnValidateAddCommon($DKV)}



                    ";


                }


                return "";


            case 2:


                $datakeyvalue = \DataKeyvalue::findFirst(array("ID = {$DKV}"));


                //die($datakeyvalue->ID."  ".$datakeyvalue->CKV_ID);


                if ($datakeyvalue->DataKeyvalueLang->ID == "2") {


                    return "



                    



                keyvalueAdd{$DKV}: {



                    email: true,



                },



                {$this->returnValidateAddCommon($DKV)}



                    ";


                }


                return "";


            case 3:


                $datakeyvalue = \DataKeyvalue::findFirst(array("ID = {$DKV}"));


                //die($datakeyvalue->ID."  ".$datakeyvalue->CKV_ID);


                if ($datakeyvalue->DataKeyvalueLang->ID == "3") {


                    return "



                    



                keyvalueAdd{$DKV}: {



                    url: true,



                },



                {$this->returnValidateAddCommon($DKV)}



                    ";


                }


                return "";


            default:


                return "";


            case 4:


                $datakeyvalue = \DataKeyvalue::findFirst(array("ID = {$DKV}"));


                //die($datakeyvalue->ID."  ".$datakeyvalue->CKV_ID);


                return "                    



                keyvalueAdd{$DKV}: {



                    digits: true,



                },



                 {$this->returnValidateAddCommon($DKV)}



                ";


            case 6:


                return "



                  {$this->returnValidateAddCommon($DKV)}  



                ";


            case 7:


                return "



                  {$this->returnValidateAddCommon($DKV)}  



                ";


            case 9:


                return "



                  {$this->returnValidateAddCommon($DKV)}  



                ";


            case 10:


                return "



                  {$this->returnValidateAddCommon($DKV)}  



                ";


            case 11:


                return "



                  {$this->returnValidateAddCommon($DKV)}  



                ";


            case 12:


                return "



                  {$this->returnValidateAddCommon($DKV)}  



                ";


            case 13:


                return "



                  {$this->returnValidateAddCommon($DKV)}  



                ";


            case 14:


                return "



                  {$this->returnValidateAddCommon($DKV)}  



                ";


        }


    }


    public function returnValidateAddCommon($DKV)

    {


        return "



        KVAdd{$DKV}Title: {



                    



                },



        KVAdd{$DKV}Des: {



                    



                },



        ";


    }


    public function returnEditValidation($DKV, $data_id)


    {


        switch ($DKV) {


            case 1:


                $datakeyvalue = \DataKeyvalue::findFirst(array("ID = {$DKV}"));


                //die($datakeyvalue->ID."  ".$datakeyvalue->CKV_ID);


                if ($datakeyvalue->DataKeyvalueLang->ID == "1") {


                    return "                    



                keyvalue{$data_id}: {



                    url: true,



                },        



                {$this->returnValidateEditCommon($data_id)}



                    ";


                }


                return "";


            case 2:


                $datakeyvalue = \DataKeyvalue::findFirst(array("ID = {$DKV}"));


                //die($datakeyvalue->ID."  ".$datakeyvalue->CKV_ID);


                if ($datakeyvalue->DataKeyvalueLang->ID == "2") {


                    return "



                    



                keyvalue{$data_id}: {



                    email: true,



                },



                {$this->returnValidateEditCommon($DKV)}



                    ";


                }


                return "";


            case 3:


                $datakeyvalue = \DataKeyvalue::findFirst(array("ID = {$DKV}"));


                //die($datakeyvalue->ID."  ".$datakeyvalue->CKV_ID);


                if ($datakeyvalue->DataKeyvalueLang->ID == "3") {


                    return "



                    



                keyvalue{$data_id}: {



                    url: true,



                },



                {$this->returnValidateEditCommon($data_id)}



                    ";


                }


                return "";


            default:


                return "";


            case 4:


                $datakeyvalue = \DataKeyvalue::findFirst(array("ID = {$DKV}"));


                //die($datakeyvalue->ID."  ".$datakeyvalue->CKV_ID);


                return "                    



                keyvalue{$data_id}: {



                   



                },



                 {$this->returnValidateEditCommon($data_id)}



                ";


            case 6:


                return "



                  {$this->returnValidateEditCommon($data_id)}  



                ";


            case 7:


                return "



                  {$this->returnValidateEditCommon($data_id)}  



                ";


            case 9:


                return "



                  {$this->returnValidateEditCommon($data_id)}  



                ";


            case 10:


                return "



                  {$this->returnValidateEditCommon($data_id)}  



                ";


            case 11:


                return "



                  {$this->returnValidateEditCommon($data_id)}  



                ";


            case 12:


                return "



                  {$this->returnValidateEditCommon($data_id)}  



                ";


            case 13:


                return "



                  {$this->returnValidateEditCommon($data_id)}  



                ";


            case 14:


                return "



                  {$this->returnValidateEditCommon($data_id)}  



                ";


        }


    }


    public function returnValidateEditCommon($data_id)

    {


        return "



        KV{$data_id}Title: {



                    



                },



        KV{$data_id}Des: {



                    



                },



        ";


    }


    public static function getKeyvalue($type_id, $DKV_ID, $value)


    {


        switch ($type_id) {


            case 1 :


                //selectbox value


                $DKV = \DataKeyvalueOption::findFirst(array("DKV_ID={$DKV_ID} AND ID={$value}"));


                return $DKV->DataKeyvalueOptionLang->Title;


            case 2 :


                //Textbox value


                return $value;


            case 3 :


                //Checkbox


                $DKV = \DataKeyvalueOption::find(array("DKV_ID={$DKV_ID}"));


                $kv_option_array = array();


                $value_array = explode(',', $value);


                $checkboxes = array();


                foreach ($DKV as $kv_option) {


                    if (in_array($kv_option->DataKeyvalueOptionLang->Option_ID, $value_array)) {


                        $kv_option_array[] = array(


                            "Option_ID" => $kv_option->DataKeyvalueOptionLang->Option_ID,


                            "Title" => $kv_option->DataKeyvalueOptionLang->Title,


                            "checked" => "checked",


                        );


                    } else {


                        $kv_option_array[] = array(


                            "Option_ID" => $kv_option->DataKeyvalueOptionLang->Option_ID,


                            "Title" => $kv_option->DataKeyvalueOptionLang->Title,


                            "checked" => "",


                        );


                    }


                }


                // die(print_r($kv_option_array));


                $output = "";


                foreach ($kv_option_array as $options) {


                    if ($options["checked"] !== "") {


                        $output .= "



                 {$options["Title"]},



                ";


                    }


                }


                return $output;


            case 5:


                return $value;


            case 6:


                return $value;


            default:


                return $value;


        }


    }


    public function saveKeyvalue($Item_ID)


    {


        $datakeyvalues = \DataKeyvalue::find();


        foreach ($datakeyvalues as $datakeyvalue) {


            $datakeyvalue_userdata = \DataKeyvalueUserdata::findFirst(


                array("DKV_ID={$datakeyvalue->ID} AND Item_ID={$Item_ID}")


            );


            if ($datakeyvalue_userdata) {


                // updating the existed values based on the Control Name And the keyvalueuserdata ID


                if (isset($_POST["keyvalue{$datakeyvalue_userdata->ID}"])) {

                    //Title And Descrition


                    $Title = $this->request->getPost("KV{$datakeyvalue_userdata->ID}Title") ?: "";


                    $Des = $this->request->getPost("KV{$datakeyvalue_userdata->ID}Des") ?: "";


                    if (isset($_POST["keyvalue{$datakeyvalue_userdata->ID}"])) {


                        $Value = $_POST["keyvalue{$datakeyvalue_userdata->ID}"];


                    } else {


                        $Value = " ";


                    }


                    //echo($_POST["keyvalue{$datakeyvalue_userdata->ID}"].var_dump($_POST["KV{$datakeyvalue_userdata->ID}"])).$datakeyvalue_userdata->Item_ID;


                    $DKV_Data = \DataKeyvalueUserdata::findFirstByID($datakeyvalue_userdata->ID);


                    //Validation 6//72017

                    $keyvalue_id = $DKV_Data->DKV_ID;

                    //get type

                    $kv_type_q = \DataKeyvalueValidationSettings::findFirst(["dkv_id={$keyvalue_id}"]);
                    $validation_arr = ["key" => $Value];

                    if (!$this->validateKeyvalue($validation_arr, $kv_type_q->kv_type)) {

                        continue;
                    }

                    $DKV_Data->Title = $Title;


                    $DKV_Data->Des = $Des;


                    $DKV_Data->Value = $Value;


                    $DKV_Data->Time = time();


                    if ($this->request->hasFiles() == true) {


                        foreach ($this->request->getUploadedFiles() as $file) {


                            if ($file->getKey() == "KV{$datakeyvalue_userdata->ID}Img") {


                                $random = new Random();


                                $random_name = $random->uuid() . "." . $file->getExtension();


                                if ($file->getName() != "") {


                                    $DKV_Data->Img = $random_name;


                                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);


                                }


                            }


                        }


                    }


                    if ($Value !== " ") {


                        if (!$DKV_Data->save()) {

                            print_r($DKV_Data->getMessages());

                            die();

                        };


                    }


                    unset($DKV_Data);


                }


                if (isset($_POST["kvCheck{$datakeyvalue_userdata->ID}"])) {


                    $checkbox = "";


                    //echo(var_dump($_POST["kvCheck{$datakeyvalue_userdata->ID}"])).$datakeyvalue_userdata->Item_ID;


                    foreach ($_POST["kvCheck{$datakeyvalue_userdata->ID}"] as $checkvalue) {


                        $checkbox .= $checkvalue . ",";


                    }


                    $DKV_Data = \DataKeyvalueUserdata::findFirstByID($datakeyvalue_userdata->ID);


                    $DKV_Data->Value = $checkbox;


                    $DKV_Data->Time = time();


                    if ($this->request->hasFiles() == true) {


                        foreach ($this->request->getUploadedFiles() as $file) {


                            if ($file->getKey() == "KV{$datakeyvalue_userdata->ID}Img") {


                                $random = new Random();


                                $random_name = $random->uuid() . "." . $file->getExtension();


                                if ($file->getName() != "") {


                                    $DKV_Data->Img = $random_name;


                                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);


                                }


                            }


                        }


                    }


                    $DKV_Data->save();


                    unset($DKV_Data);


                }


                if (isset($_FILES["kvUpload{$datakeyvalue_userdata->ID}"])) {


                    $DKV_Data = \DataKeyvalueUserdata::findFirstByID($datakeyvalue_userdata->ID);


                    $DKV_Data->Time = time();


                    if ($this->request->hasFiles() == true) {


                        foreach ($this->request->getUploadedFiles() as $file) {


                            if ($file->getKey() == "kvUpload{$datakeyvalue_userdata->ID}") {


                                $random = new Random();


                                $random_name = $random->uuid() . "." . $file->getExtension();


                                if ($file->getName() != "") {


                                    $DKV_Data->Value = $random_name;


                                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);


                                }


                            }


                        }


                    }


                    $DKV_Data->save();


                    unset($DKV_Data);


                }


            }


        }


        //Dealing With the newly assigned kvdata based on the Control Name And the keyvalueID


        $Lang_ID = "0";


        if (isset($_POST["kvAddIDs"])) {


            $array = $_POST["kvAddIDs"];


            //print_r($array);


            foreach ($array as $KV_ID) {


                if (isset($_POST["keyvalueAdd{$KV_ID}"])) {


                    $Title = $this->request->getPost("KVAdd{$KV_ID}Title") ?: "";


                    $Des = $this->request->getPost("KVAdd{$KV_ID}Des") ?: "";


                    $Value = $_POST["keyvalueAdd{$KV_ID}"];


                    $DKV_Data = new \DataKeyvalueUserdata();


                    $DKV_Data->Title = $Title;


                    $DKV_Data->Des = $Des;


                    $DKV_Data->Value = $Value;


                    $DKV_Data->Time = time();


                    $DKV_Data->Application_ID = $this->session->get('auth-identity')['Application_ID'];


                    $DKV_Data->Module_ID = $this->request->getPost("Module_ID");


                    $DKV_Data->DKV_ID = $KV_ID;


                    $DKV_Data->Item_ID = $Item_ID;


                    $DKV_Data->Lang_ID = $Lang_ID;


                    if ($this->request->hasFiles() == true) {


                        foreach ($this->request->getUploadedFiles() as $file) {


                            if ($file->getKey() == "KVAdd{$KV_ID}Img") {


                                $random = new Random();


                                $random_name = $random->uuid() . "." . $file->getExtension();


                                if ($file->getName() != "") {


                                    $DKV_Data->Img = $random_name;


                                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);


                                }


                            }


                        }


                    }


                    if (($Value) !== "") {


                        if (!$DKV_Data->save()) {


                            foreach ($DKV_Data->getMessages() as $message) {


                                $this->flash->error($message);


                            }


                            die();


                        }


                    }


                    unset($DKV_Data);


                }


                if (isset($_POST["kvAddCheck{$KV_ID}"])) {


                    $checkbox = "";


                    //echo(var_dump($_POST["kvCheck{$datakeyvalue_userdata->ID}"])).$datakeyvalue_userdata->Item_ID;


                    foreach ($_POST["kvAddCheck{$KV_ID}"] as $checkvalue) {


                        $checkbox .= $checkvalue . ",";


                    }


                    $DKV_Data = new \DataKeyvalueUserdata();


                    $DKV_Data->Value = $checkbox;


                    $DKV_Data->Time = time();


                    $DKV_Data->Title = $_POST["KVAdd{$KV_ID}Title"];


                    $DKV_Data->Des = $_POST["KVAdd{$KV_ID}Des"];


                    $DKV_Data->Application_ID = $this->session->get('auth-identity')['Application_ID'];


                    $DKV_Data->Module_ID = $this->request->getPost("Module_ID");


                    $DKV_Data->DKV_ID = $KV_ID;


                    $DKV_Data->Item_ID = $Item_ID;


                    $DKV_Data->Lang_ID = $Lang_ID;


                    if ($this->request->hasFiles() == true) {


                        foreach ($this->request->getUploadedFiles() as $file) {


                            if ($file->getKey() == "KVAdd{$KV_ID}Img") {


                                $random = new Random();


                                $random_name = $random->uuid() . "." . $file->getExtension();


                                if ($file->getName() != "") {


                                    $DKV_Data->Img = $random_name;


                                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);


                                }


                            }


                        }


                    }


                    $DKV_Data->save();


                    unset($DKV_Data);


                }


                if (isset($_FILES["kvAddUpload{$KV_ID}"])) {


                    //die(var_dump($_FILES["kvAddUpload{$KV_ID}"]));


                    $DKV_Data = new \DataKeyvalueUserdata();


                    $DKV_Data->Time = time();


                    $DKV_Data->Title = $_POST["KVAdd{$KV_ID}Title"];


                    $DKV_Data->Des = $_POST["KVAdd{$KV_ID}Des"];


                    $DKV_Data->Application_ID = $this->session->get('auth-identity')['Application_ID'];


                    $DKV_Data->Module_ID = $_POST['Module_ID'];


                    $DKV_Data->DKV_ID = $KV_ID;


                    $DKV_Data->Item_ID = $Item_ID;


                    $DKV_Data->Lang_ID = $Lang_ID;


                    if ($this->request->hasFiles() == true) {


                        foreach ($this->request->getUploadedFiles() as $file) {


                            if ($file->getKey() == "kvAddUpload{$KV_ID}") {


                                $random = new Random();


                                $random_name = $random->uuid() . "." . $file->getExtension();


                                if ($file->getName() != "") {


                                    $DKV_Data->Value = $random_name;


                                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);


                                }


                            }


                            if ($file->getKey() == "KVAdd{$KV_ID}Img") {


                                $random = new Random();


                                $random_name = $random->uuid() . "." . $file->getExtension();


                                if ($file->getName() != "") {


                                    $DKV_Data->Img = $random_name;


                                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);


                                }


                            }


                        }


                    }


                    if ($DKV_Data->Title !== "") {


                        $DKV_Data->save();


                    }


                    unset($DKV_Data);


                }


            }


        }


    }


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


}