<?php
//namespace Models;
use Phalcon\Mvc\Model;
use Vokuro\Models\Behaviors\Loggable;
use Vokuro\Polls\Models\Polls;
use Vokuro\Discounts\Models\Discounts;

class DataCmsDeptsRel extends Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=10, nullable=false)
     */
    public $ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Title;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Parent_Depts_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=750, nullable=false)
     */
    public $Des;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Img;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $Active;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Orders;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Core_Depts_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Lang_ID;

    public $is_public;
    public $created_at;
    public $created_by;
    public $subject_to_maintenance;
    public $show_in_homepage;
    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function initialize(){
        $this->addBehavior(new Loggable());
        $this->hasMany(
            "ID",
            '\DataCmsDeptsRelItem',
            "Depts_ID",
            [
                'alias' => 'DeptsContent',
                'reusable' => true
            ]
        );
        $this->hasMany(
            "ID",
            '\DataKeyvalueUserdata',
            "Item_ID",
            [
                'alias' => 'DataKeyvalueUserdata',
                'reusable' => true
            ]
        );
        $this->allowEmptyStringValues(
            array(
                "Title",
                "Des",
            )
        );
        $this->belongsTo(
            "ID",
            '\DataCmsDeptsRelLang',
            "dept_id",
            [
                'alias' => 'DeptRelLang',
                'reusable' => true
            ]
        );

        $this->belongsTo(
            "Parent_Depts_ID",
            '\DataCmsDeptsRel',
            "ID",
            [
                'alias' => 'Parent',
                'reusable' => true
            ]
        );

        $this->hasManyToMany(
            "id",
            "\DataCmsDeptsRelUsers",
            "data_cms_depts_rel_id", "user_id",
            "\Models\UsersMobile",
            "ID",
            [
                "alias" => "users"
            ]
            );

        $this->hasMany(
            "ID",
            Polls::class,
            "data_cms_depts_rel_id",
            [
                'alias' => 'polls',
                'reusable' => true
            ]
        );

        $this->hasMany(
            "ID",
            \Models\SeoSettings::class,
            "dept_id",
            [
                'alias' => 'seoSettings'
            ]
        );

        $this->hasOne(
            "ID",
            \Models\SeoSettings::class,
            "dept_id",
            [
                'alias' => 'seo'
            ]
        );

        $this->hasManyToMany(
            "ID",
            \DataCmsDeptsRelItem::class,
            "Depts_ID", "Item_ID",
            \Models\Content::class,
            "ID",
            [
                'alias' => 'items'
            ]
        );

        $this->hasOne(
            "ID",
            \DataCmsDeptsRelLang::class,
            "dept_id",
            [
                "alias" => "ar",
                "params" => [
                    "conditions" => \DataCmsDeptsRelLang::class . ".lang_id = 1"
                ]
            ]
        );

        $this->hasOne(
            "ID",
            \DataCmsDeptsRelLang::class,
            "dept_id",
            [
                "alias" => "en",
                "params" => [
                    "conditions" => \DataCmsDeptsRelLang::class . ".lang_id = 2"
                ]
            ]
        );

        $this->hasMany(
            "ID",
            \DataCmsMedia::class,
            "dept_id",
            [
                'alias' => 'images',
                'params' => [
                    'conditions' => \DataCmsMedia::class . ".Type = 'Img'"
                ]
            ]
        );

        $this->hasMany(
            "ID",
            \DataCmsMedia::class,
            "dept_id",
            [
                "alias" => "videos",
                "params" => [
                    "conditions" => \DataCmsMedia::class . ".Type = 'Video'"
                ]
            ]
        );

        $this->hasMany(
            "ID",
            \DataCmsMedia::class,
            "dept_id",
            [
                'alias' => 'media'
            ]
        );

        $this->hasMany(
            "ID",
            Discounts::class,
            "category_id",
            [
                'alias' => 'discounts'
            ]
        );

        $this->hasManyToMany(
            'ID',
            \DataKeyvalueDeptCms::class,
            'dept_id', 'dkv_id',
            \DataKeyvalue::class,
            'ID',
            [
                'alias'  => 'categoryFields',
                'params' => [
                    'conditions' => DataKeyvalueDeptCms::class . '.subject_to_maintenance = 0'
                ]
            ]
        );
    }
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'title' => 'Title',
            'des' => 'Des',
            'parent_depts_id' => 'Parent_Depts_ID',
            'application_id' => 'Application_ID',
            'module_id' => 'Module_ID',
            'img' => 'Img',
            'active' => 'Active',
            'orders' => 'Orders',
            'core_depts_id' => 'Core_Depts_ID',
            'lang_id' => 'Lang_ID',
            'is_public'=>'is_public',
            'created_at'=>'created_at',
            'created_by'=>'created_by',
            'subject_to_maintenance'=>'subject_to_maintenance',
            'show_in_homepage' => 'show_in_homepage'
        );


    }

    public function getSource()
    {
        return 'data_cms_depts_rel';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsDeptsRel[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }


    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsDeptsRel
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }



    public static function getTree($parent_id)
    {
        return parent::find(
            [
                "Parent_Depts_ID = " . $parent_id,
            ]
        );
    }

    public function getTiltleByID($ID)
    {
        $Title = parent::findFirst(["ID =" . $ID]);
        return $Title->Title;
    }



    public function deptsKeyvalueEditTags($DKV_ID, $type_id, $value = "", $kv_id)
    {
        switch ($type_id) {
            case 1 :
                $DKV = \DataKeyvalueOption::find(array("DKV_ID={$DKV_ID}"));
                $kv_option_array = array();
                $value_array = explode(',', $value);
                $checkboxes = array();
                foreach ($DKV as $kv_option) {
                    if (in_array($kv_option->DataKeyvalueOptionLang->Option_ID, $value_array)) {
                        $kv_option_array[] = array(
                            "Value" => $kv_option->DataKeyvalueOptionLang->Option_ID,
                            "Title" => $kv_option->DataKeyvalueOptionLang->Title,
                            "selected" => 'selected="selected"',
                        );
                    } else {
                        $kv_option_array[] = array(
                            "Value" => $kv_option->DataKeyvalueOptionLang->Option_ID,
                            "Title" => $kv_option->DataKeyvalueOptionLang->Title,
                            "selected" => '',
                        );
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
                    return \Phalcon\Tag::textField(["keyvalue{$kv_id}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$kv_id}"]);
                }
                return \Phalcon\Tag::textField(["keyvalue{$kv_id}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$kv_id}", "value" => $value]);
            case 3 :
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
                    $output .= "
                 <div><span>{$options["Title"]}</span><input type='checkbox' name='kvCheck{$kv_id}[]' value='{$options["Option_ID"]}' {$options["checked"]}></div>
                ";
                }

                return $output;
            case 4:
                return \Phalcon\Tag::fileField(["kvUpload{$kv_id}", "size" => 30, "class" => "form-control", "id" => ""]);

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
                return ("DB");
            default:
                return "The Default Text Box";
        }
    }

    public function deptsKeyvalueAddTags($type_id, $value = "", $DKV)
    {
        switch ($type_id) {
            case 1 :
                $DKV_ID = \DataKeyvalueOption::find(array("DKV_ID={$DKV}"));
                $kv_option_array = array();
                $value_array = explode(',', $value);
                $checkboxes = array();
                foreach ($DKV_ID as $kv_option) {

                    $kv_option_array[] = array(
                        "Value" => $kv_option->DataKeyvalueOptionLang->Option_ID,
                        "Title" => $kv_option->DataKeyvalueOptionLang->Title,
                        "selected" => '"',
                    );


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
                    return \Phalcon\Tag::textField(["keyvalueAdd{$DKV}", "type" => "text", "class" => "form-control", "id" => "fieldkeyvalueAdd{$DKV}"]);
                }
                return \Phalcon\Tag::textField(["keyvalueAdd{$DKV}", "type" => "text", "class" => "form-control", "id" => "fieldkeyvalueAdd{$DKV}"]);
            case 3 :
                $DKV_find = \DataKeyvalueOption::find(array("DKV_ID={$DKV}"));
                $kv_option_array = array();
                foreach ($DKV_find as $kv_option) {
                    $kv_option_array[] = array(
                        "Option_ID" => $kv_option->DataKeyvalueOptionLang->Option_ID,
                        "Title" => $kv_option->DataKeyvalueOptionLang->Title,
                        "checked" => "",
                    );
                }
                // die(print_r($kv_option_array));
                $output = "";
                foreach ($kv_option_array as $options) {
                    $output .= "
                 <div><span>{$options["Title"]}</span><input type='checkbox' name='kvAddCheck" . $DKV . "[]' value='{$options["Option_ID"]}'></div>
                ";
                }
                return $output;
            case 4:
                return \Phalcon\Tag::fileField(["kvAddUpload{$DKV}", "size" => 30, "class" => "form-control", "id" => ""]);

            case 5 :

                return \Phalcon\Tag::textField(["keyvalueAdd{$DKV}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$DKV}"]);


            case 6 :

                return \Phalcon\Tag::textField(["keyvalueAdd{$DKV}", "type" => "number", "class" => "form-control", "id" => "fieldkeyvalue{$DKV}"]);

            case 7 :
                return ("DB");
            default:
                return "The Default Text Box";
        }

    }

    //Try To handle the language
    public static function findWithLang($Module_ID){
        $depts=self::find(["Module_ID={$Module_ID}"])->toArray();
        if(isset($_GET['lang_id'])){
            $depts_array=[];
            foreach ($depts as $dept){
                $row=[];
                $row['ID']=$dept['ID'];
                $get_lang=\DataCmsDeptsRelLang::findFirst("dept_id={$dept['ID']} AND lang_id={$_GET['lang_id']}");
                if(!$get_lang){
                    $row['Title']=$dept['Title'];
                }else{
                    $row['Title']= $get_lang->title;
                }
                $depts_array[]=$row;
            }
            return $depts_array;


        }else{
            return $depts;
        }
    }

    public function formattedDate()
    {
        return (isset($this->created_at) && strlen($this->created_at) > 0)
                ?date('d/m/Y', strtotime($this->created_at)):'';
    }

}
