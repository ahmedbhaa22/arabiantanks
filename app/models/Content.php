<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Discounts\Models\DiscountRelItems;
use Vokuro\Discounts\Models\Discounts;
use Vokuro\Models\Behaviors\Loggable;
use Phalcon\Mvc\Model\Behavior\Timestampable;
use DateTime;
use DateTimeZone;
use Vokuro\Models\ProductExtraFields;
use Vokuro\Models\ProductReviews;
use Vokuro\Maintenance\Models\Tickets;

class Content extends Model
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
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Des;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Content;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=true)
     */
    public $Order;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $User_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Img;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Visit_Num;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $DateTime;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Active;

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

    public $updated_at;

    /**
     *
     * @var string
     * @Column(type="string", length=250, nullable=false)
     */
//    public $Key_1;
//
//    /**
//     *
//     * @var string
//     * @Column(type="string", length=250, nullable=false)
//     */
//    public $Key_2;
//
//    /**
//     *
//     * @var string
//     * @Column(type="string", length=250, nullable=false)
//     */
//    public $Key_3;
//
//    /**
//     *
//     * @var string
//     * @Column(type="string", length=250, nullable=false)
//     */
//    public $Key_4;
//
//    /**
//     *
//     * @var string
//     * @Column(type="string", length=250, nullable=false)
//     */
//    public $Key_5;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function initialize()
    {
        $this->addBehavior(new Loggable());
//        $this->addBehavior(
//            new Timestampable(
//                [
//                    "beforeUpdate" => [
//                        "field"  => "updated_at",
//                        "format" => function () {
//                        $datetime = new Datetime(
//                            new DateTimeZone("Europe/Stockholm")
//                        );
//
//                        return $datetime->format("Y-m-d H:i:sP");
//                    }
//                    ]
//                ]
//            )
//        );
        $this->hasMany(
            "ID",
            '\DataKeyvalueUserdata',
            "Item_ID",
            [
                'alias' => 'DataKeyvalueUserdata',
                'reusable' => true
            ]
        );
        $this->hasMany(
            "ID",
            '\DataCmsDeptsRelItem',
            "Item_ID",
            [
                'alias' => 'Depts',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "Depts_ID",
            '\DataCmsDeptsRel',
            "ID",
            [
                'alias' => 'Details',
                'reusable' => true
            ]
        );
        $this->hasMany(
            "ID",
            '\DataCmsMedia',
            "Item_ID",
            [
                'alias' => 'ContentMedia',
                'reusable' => true
            ]
        );

        $this->hasMany(
            "ID",
            "\DataCmsMedia",
            "Item_ID",
            [
                "alias" => "images",
                "params" => [
                    "conditions" => "\DataCmsMedia.Type = Img"
                ]
            ]
        );

        $this->belongsTo(
            "ID",
            'Models\DataCmsImgThumb',
            "data_cms_id",
            [
                'alias' => 'Thumb',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "Module_ID",
            '\UsersApplicationModule',
            "ID",
            [
                'alias' => 'Module',
                'reusable' => true
            ]
        );


        $this->hasMany(
            "ID",
            '\DataCmsLang',
            "data_cms_id",
            [
                'alias' => 'Lang',
                'reusable' => true
            ]
        );

        $this->belongsTo(
            "ID",
            '\DataCmsLang',
            "data_cms_id",
            [
                'alias' => 'content_lang',
                'reusable' => true
            ]
        );

        $this->hasOne(
            "ID",
            ProductExtraFields::class,
            "item_id",
            [
                'alias' => 'extraFields',
                'params' => [
                    'conditions' => 'module_id = 8'
                ]
            ]
        );

        $this->hasManyToMany(
            "ID",
            \DataCmsDeptsRelItem::class,
            "Item_ID","Depts_ID",
            \DataCmsDeptsRel::class,
            "ID",
            [
                'alias' => 'categories',
                'params' => [
                    'conditions' => \DataCmsDeptsRel::class.'.Core_Depts_ID = 4'
                ]
            ]
        );

        $this->hasManyToMany(
            "ID",
            DiscountRelItems::class,
            "data_cms_id","discount_id",
            Discounts::class,
            "id",
            [
                'alias' => 'discounts',
                'params'=>[
                    'conditions' => Discounts::class.'.active = 1'
                ]
            ]
        );

        $this->allowEmptyStringValues(
            array(
                "Title",
                "Des",
                "Content",
            )
        );

        $this->hasMany(
            "ID",
            ProductReviews::class,
            "product_id",
            [
                "alias" => "reviews"
            ]
        );

        $this->hasManyToMany(
            "ID",
            \DataCmsDeptsRelItem::class,
            "Item_ID", "Depts_ID",
            \DataCmsDeptsRel::class,
            "ID",
            [
                "alias" => "manufacturers",
                "params" => [
                    "conditions" => \DataCmsDeptsRel::class.'.Core_Depts_ID = 5'
                ]
            ]
        );

        $this->hasMany(
            "ID",
            \Vokuro\Cart\Models\OrderItems::class,
            "item_id",
            [
                "alias" => "purchaseItems",
                "params" => [
                    "conditions" => \Vokuro\Cart\Models\OrderItems::class.".item_type_id = 1"
                ]
            ]
        );

        $this->hasManyToMany(
            "ID",
            \Models\EntityTags::class,
            "item_id", "tag_id",
            \Vokuro\Models\Tags::class,
            "id",
            [
                'alias' => 'tags',
                'params' => [
                'conditions' => \Models\EntityTags::class . '.entity_id = 1'
                ]
            ]
        );

        $this->hasManyToMany(
            "ID",
            \Vokuro\Discounts\Models\DiscountRelItems::class,
            "data_cms_id", "discount_id",
            Vokuro\Discounts\Models\Discounts::class,
            [
                'alias' => 'discounts'
            ]
        );

        $this->hasOne(
            'ID',
            SeoSettings::class,
            'data_cms_id',
            [
                'alias' => 'seoSettings'
            ]
        );

        $maintenance_tickets_statuses = "1,2,3,4,6";
        $this->hasMany(
            "ID",
            Tickets::class,
            "data_cms_id",
            [
                'alias' => 'maintenanceTickets',
                'params' => [
                    'conditions' => Tickets::class . '.ticket_status_id in ('.$maintenance_tickets_statuses.')'
                ]
            ]
        );

        $this->hasMany(
            "ID",
            Tickets::class,
            "data_cms_id",
            [
                'alias' => 'replaceTickets',
                'params' => [
                    'conditions' => Tickets::class . '.ticket_status_id = 8'
                ]
            ]
        );

        $this->hasOne(
            "ID",
            \DataCmsLang::class,
            "data_cms_id",
            [
                'alias' => 'ar',
                'params' => [
                    'conditions' => \DataCmsLang::class . '.lang_id = 1'
                ]
            ]
        );

        $this->hasOne(
            "ID",
            \DataCmsLang::class,
            "data_cms_id",
            [
                'alias' => 'en',
                'params' => [
                    'conditions' => \DataCmsLang::class . '.lang_id = 2'
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
            'content' => 'Content',
            'order' => 'Order',
            'user_id' => 'User_ID',
            'img' => 'Img',
            'visit_num' => 'Visit_Num',
            'datetime' => 'DateTime',
            'active' => 'Active',
            'application_id' => 'Application_ID',
            'module_id' => 'Module_ID',
            'lang_id' => 'Lang_ID',
            'key_1' => 'Key_1',
            'key_2' => 'Key_2',
            'key_3' => 'Key_3',
            'key_4' => 'Key_4',
            'key_5' => 'Key_5',
            'secured'=>'secured',
            'updated_at'=>'updated_at'


        );
    }

    public function getSource()
    {
        return 'data_cms';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function getModuleTitleByID($id)
    {

        $query = new Query(
            "SELECT Title FROM UsersApplicationModule WHERE ID=" . $id,
            $this->getDI()
        );
        $module = $query->execute();
        return $module;
    }
//    public function getDeptByID($id){
//
//        $query = new Query(
//            "SELECT Title FROM DataCmsDeptsRel".
//            " JOIN DataCmsDeptsRelItem ON DataCmsDeptsRel.ID=DataCmsDeptsRelItem.Depts_ID "
//            ."WHERE DataCmsDeptsRelItem.Item_ID=".$id,
//            $this->getDI()
//        );
//        $dept = $query->execute();
//        return $dept;
//    }


    public function buildTree($depts, $parentId = 0, $lang_id)
    {
        foreach ($depts as $dept) {

            if ($dept->Parent_Depts_ID == $parentId) {
                echo "<li>";
                if($dept->Core_Depts_ID == '5')
                {
                    echo \Phalcon\Tag::checkField(array("Manfct_Depts_ID[]", "value" => $dept->ID, "class" => 'dept-item', 'required' => 'required'));
                }
                else
                {
                   if(in_array($dept->ID,[80,81,82,83])){

                   }else{
                       echo \Phalcon\Tag::checkField(array("Depts_ID[]", "value" => $dept->ID, "class" => 'dept-item'));

                   }
                }
                
                $get_lang = \DataCmsDeptsRelLang::findFirst("dept_id={$dept->ID} AND lang_id={$lang_id}");
                if (!$get_lang) {
                    echo $dept->Title;
                } else {
                    echo $get_lang->title;
                }
                echo "<ul class='child'>";
                $this->buildTree(\DataCmsDeptsRel::find(), $dept->ID,$lang_id);
                echo "</ul>";
                echo "</li>";
            }

        }
    }

    public static function buildCatsTree($depts, $parentId = 0, $lang_id)
    {
        $tree = '';

        foreach ($depts as $dept) {

            if ($dept->Parent_Depts_ID == $parentId) {
                $tree .= "<li>";
                $tree .= \Phalcon\Tag::checkField(array("cat_ids[]", "value" => $dept->ID, "class" => 'dept-item'));
                $get_lang = \DataCmsDeptsRelLang::findFirst("dept_id={$dept->ID} AND lang_id={$lang_id}");
                if (!$get_lang) {
                    $tree .= $dept->Title;
                } else {
                    $tree .= $get_lang->title;
                }
                $tree .= "<ul class='child'>";
                static::buildCatsTree(\DataCmsDeptsRel::find(), $dept->ID,$lang_id);
                $tree .= "</ul>";
                $tree .= "</li>";
            }

        }

        return $tree;
    }

    public function deptsTree(array $elements, $parentId = 0) {
        $branch = array();
        foreach ($elements as $element) {
            if ($element['Parent_Depts_ID'] == $parentId) {
                $children = $this->deptsTree($elements, $element['ID']);
                if ($children) {
                    $element['children'] = $children;
                }
                $branch[] = $element;
            }
        }

        return $branch;
    }


    public function buildEditTree($depts, $parentId = 0, $item_depts, $lang)
    {
        foreach ($depts as $dept) {

            if ($dept->Parent_Depts_ID == $parentId) {
                echo "<li>";
                if(in_array($dept->ID,[80,81,82,83])){

                }else{
                    if (in_array($dept->ID, $item_depts)) {
                        echo \Phalcon\Tag::checkField(array("Depts_ID[]", "value" => $dept->ID, "checked" => "checked"));
                    } else {
                        echo \Phalcon\Tag::checkField(array("Depts_ID[]", "value" => $dept->ID,));
                    }
                }


                $get_lang = \DataCmsDeptsRelLang::findFirst("dept_id={$dept->ID} AND lang_id={$lang}");
                if (!$get_lang) {
                    echo $dept->Title;
                } else {
                    echo $get_lang->title;
                }


                echo "<ul class='child'>";
                $this->buildEditTree(\DataCmsDeptsRel::find(), $dept->ID, $item_depts, $lang);
                echo "</ul>";
                echo "</li>";
            }

        }
    }

    public function getItemDept($Item_ID)
    {
        $dept_item = \DataCmsDeptsRelItem::find(["Item_ID= $Item_ID"]);
        $depts_array = array();
        foreach ($dept_item as $dept) {
            $depts_array[] = $dept->Depts_ID;
        }
        return $depts_array;
    }

    public function getItemIDByMainDeptID($Core_Depts_ID, $Item_ID)
    {
        $dept_sub = array();
        $item_dept_array = array();
        $depts = \DataCmsDeptsRel::find([
            "Core_Depts_ID= $Core_Depts_ID"
        ]);
        foreach ($depts as $dept) {
            $dept_sub[] = $dept->ID;
        }
        $item_depts = \DataCmsDeptsRelItem::find([
            "Item_ID = $Item_ID"
        ]);
        foreach ($item_depts as $item_dept) {
            $item_dept_array[] = $item_dept->Depts_ID;
        }


    }

    public function getDepts()
    {
        $main = \DataCmsDepts::find();
        $big_array = array();
        foreach ($main as $main_dept) {
            echo "<ul>";
            echo "<div>" . $main_dept->Title . "</div>";
            $children = \DataCmsDeptsRel::find([
                "Core_Depts_ID=" . $main_dept->ID,

            ]);
            foreach ($children as $child) {
                echo "<li>";
                echo \Phalcon\Tag::checkField(array("Depts_ID[]", "value" => $child->ID,));
                echo $child->Title . "</li>";
            }
            echo "</ul>";
        }

    }
    public function getTitleByLang($id){
        $lang = \DataCmsLang::findFirst(["data_cms_id={$this->ID} and lang_id={$id}"]);
        if(!$lang){
            return $this->Title;
        }
        return $lang->title;
    }

    public function getDesByLang($id){
        $lang = \DataCmsLang::findFirst(["data_cms_id={$this->ID} and lang_id={$id}"]);
        if(!$lang){
            return $this->Des;
        }
        return $lang->des;
    }

    public static function filterContentDefault()
    {

    }

    public function beforeUpdate()
    {
        $this->updated_at = time();
    }

    public function getPrice()
    {

    }

    public function purchaseNumber()
    {
        $purchase_number = 0;

        foreach($this->purchaseItems as $item)
        {
            if($item->order->status == \Vokuro\Cart\Models\OrderStatuses::paymentConfirmed())
            {
                $purchase_number += 1;
            }
        }

        return $purchase_number;
    }

    public function returnedNumber()
    {
        $returned_number = 0;

        foreach($this->purchaseItems as $item)
        {
            if($item->order->status == \Vokuro\Cart\Models\OrderStatuses::returned())
            {
                $returned_number += 1;
            }
        }

        return $returned_number;
    }

    public function deleteExtraFields()
    {
        if($this->extraFields)
        {
            $this->extraFields->delete();
        }
    }

    public function deleteKeyValues()
    {
        foreach($this->DataKeyvalueUserdata as $kv)
        {
            $kv->delete();
        }
    }

    public function deleteDeptsRel()
    {
        $categories_rel = \DataCmsDeptsRelItem::find([
            'Item_ID = :id: and (Module_ID = :categories_module: or Module_ID = :manfcts_module:)',
            'bind' => [
                'id'                => $this->ID,
                'categories_module' => 4,
                'manfcts_module'    => 5
            ]
            ]);

        foreach($categories_rel as $cat_rel)
        {
            $cat_rel->delete();
        }
    }

    public function getDate()
    {
        return date('d/m/Y', $this->DateTime);
    }

    public function relatedOrders()
    {
        $order_purchase = $this->purchaseItems;

        $orders_ids = [];
        
        foreach($order_purchase as $item)
        {

            if(!in_array($item->order_id, $orders_ids))
            {
                $orders_ids[] = $item->order_id;
            }
        }

        $orders = \Vokuro\Cart\Models\Orders::query()->inWhere('id', $orders_ids)->execute();
        
        return $orders;
    }
}
