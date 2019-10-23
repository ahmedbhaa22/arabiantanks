<?php 
namespace Vokuro;
use Models\Content;
use Models\DataCmsOrderStatus;
use Models\DataFormsResponse;
use Models\EntityTags;
use Models\GeneralNotifications;
use Models\NewsLetter;
use Models\TanksCities;
use Models\TanksCountries;
use Models\TanksRegions;
use Models\TanksTaxes;
use Models\UsersMobile;
use Vokuro\Cart\Models\OrderItems;
use Vokuro\Cart\Models\OrderItemTypes;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderStatuses;
use Vokuro\Discounts\Models\Discounts;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoStates;
use Vokuro\Models\Companies;
use Vokuro\Models\CompanyBranches;
use Vokuro\Models\ProductExtraFields;
use Vokuro\Models\Tags;
use Vokuro\Offers\Models\Offers;
use Vokuro\Pentavalue\Jsonobjects;
use Vokuro\Models\DataKeyvalueEntity;
use Vokuro\Pentavalue\Helpers;
use Phalcon\Mvc\User\Component;
/** HTTP Status Codes **/
/** Success OK            200
 *  No Content            204
 *  No Auth               401
 *  Missing Parameters    422
 *  Bad Request           400
 *  Conflict              409
 * **/


class ApiFactory extends Component{
    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';
    private $baseUri = '';
    private $is_mobile = 0;

    public function __construct($baseUri)
    {
        $this->baseUri = $baseUri;
        if(isset($_GET["mobile"])){
            $this->is_mobile = 1;
        }
    }

    public function structureGeneralResponse($items){
        $result['status']  = $this->getStatus(200, 'Strings loaded successfully');
        $result['content'] = $items;
        return $result;
    }

    public function structureDeptsResponse($depts, $lang_id,$with_items = false)
    {
        $result = [];

        if($depts)
        {
            $depts_arr = [];

            foreach($depts as $dept)
            {
                $name = $dept->Title;
                $des = $dept->Des;
                if($lang_id!=null){
                    $dept_lang = \DataCmsDeptsRelLang::findFirst(["dept_id={$dept->ID} AND lang_id={$lang_id}"]);
                    if($dept_lang){
                        $name = $dept_lang->title;
                        $des = $dept_lang->des;
                    }
                }

                $dept_data = [
                    'id' => $dept->ID,
                    'name' => $name,
                    'description' => $des,
                    'image' => $this->baseUri . static::UPLOAD_LOCATION .$dept->Img,
                    'content' => '',
                    'created_at' => $dept->created_at,
                    'duration' => '',
                    'visit_num' => '',
                    'order' => $dept->Orders,
                    'link_share' => '',
                    'items_count' => count($dept->DeptsContent),
                    'more' => ['attributes'=>$this->getDeptAttributes($dept->ID, $lang_id)],
                    'media' => $this->getDeptMedia($dept),
                ];

                if($with_items)
                {
                    $items_ids = [];
                    $dept_data['cms'] = [];

                    $items = $dept->DeptsContent;

                    if(count($items))
                    {
                        foreach($items as $item)
                        {
                            $items_ids[] = $item->Item_ID;
                        }

                        $items_ids_str = join(',', $items_ids);
                        $data_cms = Content::query()
                            ->where("ID in ({$items_ids_str})")
                            ->execute();

                        $dept_data['cms'] = $this->getDataCms($data_cms,$lang_id);
                    }
                }
                $dept_data["settings"]=[];
                $depts_arr[] = $dept_data;
            }

            $result['status']  = $this->getStatus(200, 'Depts loaded successfully');
            $result['content'] = $depts_arr;
        }
        else
        {
            $result['status']  = $this->getStatus(204, 'Error loading depts');
        }

        return $result;
    }

    public function getDeptAttributes($dept_id, $lang_id)
    {
        $kv_ids = [];

        $dept_rel_kv = \DataKeyvalueDeptCms::find([
            'dept_id = {dept} and application_id = {app} and subject_to_maintenance = {maintenance}',
            'bind' => [
                'dept' => $dept_id,
                'app' => 1,
                'maintenance' => 0
            ]
        ]);

        foreach($dept_rel_kv as $d_rel_kv)
        {
            $kv_ids[] = $d_rel_kv->dkv_id;
        }

        $keyvalues = \DataKeyvalue::query()->inWhere('ID', $kv_ids)->execute();

        $attributes = [];

        foreach($keyvalues as $kv)
        {
            $attributes[] = ($kv->getDataKeyvalueLang('Lang_ID = '.$lang_id))?
                $kv->getDataKeyvalueLang('Lang_ID = '.$lang_id)->Title:$kv->Paramter;
        }

        return $attributes;
    }

    private function getDeptRelLang($dept,$lang_id){

    }

    private function getDeptLangs($dept_id)
    {
        $result = [];

        $dept_langs = \DataCmsDeptsRelLang::find([
            'dept_id = {dept}',
            'bind' => [
                'dept' => $dept_id
            ]
        ]);

        if(count($dept_langs))
        {
            $result = $this->structureDeptLangs($dept_langs);
        }

        return $result;
    }

    private function structureDeptLangs($dept_langs)
    {
        $result = [];

        foreach($dept_langs as $dl)
        {
            $result[] = [
                'id' => $dl->id,
                'data_cms_id' => '',
                'dept_id' => $dl->dept_id,
                'lang_id' => $dl->lang_id,
                'title' => $dl->title,
                'des' => $dl->des,
                'content' => ''
            ];
        }

        return $result;
    }

    /**
     *
     * @param type $code
     * @param type $message
     * @param type $parameters array('field_name' => 'error message' , 'field_name' => 'error message')
     */
    public function structureCMSResponse($status, $items, $robo_version,$lang_id,$total=null,$depts=null) {


        $data=[];

        if($status==200){
//            if($robo_version==1){
//                $data = $this->getDataCmsV1($items);
//                return $data;
//            }
            $data = $this->getDataCms($items,$lang_id,$depts);
            $msg = 'Data loaded';
        }else{
            $data=[];
            $msg = 'No data';
        }

        if($total==null){
            $total=0;
        }
        return array(
            'status' => $this->getStatus($status, $msg),
            'content' => $data,
            'total' => $total
        );
    }

    public function structureCompareResponse($items,$lang_id) {

        $data =[];
        $data = $this->getDataCms($items,$lang_id);
        return array(
            'status' => $this->getStatus(200, "Data loaded"),
            'content' => $data
        );
    }

    public function structureFilterResponse($status, $items) {

        $data=[];
        if(!empty($items)){
            foreach ($items as $item){
                $data[] = $item;
            }
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }
    public function getStatus ($code = '200', $message, $parameters = array()) {
        return array (
            'code' => $code,
            'message' => $message,
            'error_details' => $parameters
        );
    }
    private function getDataCms($datacms_objs,$lang_id=null, $depts=null) {

        $data = array();
        foreach($datacms_objs as $item) {
            //Fixi Lang
            if($lang_id==null){
                $lang_id=2;
             if($this->request->get("lang_id")){
                    $lang_id =   $this->request->get("lang_id");
                }
            }
            $data_cms = $this->getDataCmsItemReturn($item,$lang_id);
            $data_cms['link_share'] = "http://robo-apps.comnews.php?ID=14";
//            $data_cms['sub'] = array();
//            $data_cms['parameter_filter'] = array();


            //More structure is different in Mobile
            if($this->is_mobile==1){
                $data_cms['more'] = $this->structureMoreMobile($item,$lang_id, $depts);
            }
            else{
                $data_cms['more'] = $this->structureMore($item,$lang_id, $depts);
            }
            //END OF More Structure
            $data_cms['media'] = $this->getDataCmsMedia($item);
             // Settings
            $data_cms['settings']=[];
            //
            $data [] = $data_cms;
        }
        return $data;
    }

    private function structureMore($item,$lang_id, $depts=null)
    {
        $more = [];

        // keyvalues
        $kv_model['key'] = 'keyvalue';
        $kv_model['group_name'] = 'Key Value Fields';
        $kv_model['value'] = $this->getDataCmsKeyValues($item,$lang_id);

        // extra fields
        $extra_model['key'] = 'extra';
        $extra_model['group_name'] = 'Extra Fields';
        $extra_model['value'] = $this->getDataCmsExtraFields($item,$lang_id);

        //category attributes
        $att_model['key'] = 'attributes';
        $att_model['group_name'] = 'Attributes Fields';
        $att_model['value'] = $this->getDataCmsKeyValuesAttributes($item,$lang_id, $depts);

        // get categories array
        $categories_model['key'] = 'categories';
        $categories_model['group_name'] = 'Product Categories';
        $categories_model['value'] = (count($item->categories))?$this->getCategoriesTree($item->categories[0]):[];

        // category id
        $category_id_model['key']        = 'category_id';
        $category_id_model['group_name'] = 'Product Category ID';
        $category_id_model['value'][]    = ['category_id'=>(count($item->categories))?$item->categories[0]->ID:''];

        // manufacturer data
        $manufacturer_model['key']        = 'manufacturer_data';
        $manufacturer_model['group_name'] = 'Manufacturer Data';
        $manufacturer_model['value'][]    = (count($item->manufacturers))?[
            'manufacturer_id'   => $item->manufacturers[0]->ID,
            'manufacturer_name' => $item->manufacturers[0]->Title
        ]:[];

        // type
        $type_model['key']        = 'item_type';
        $type_model['group_name'] = 'Item Type';
        $type_model['value'][]    = ['type_id'=>1];

        // discount data
        $discount_percentage_model['key']        = 'discount_percentage';
        $discount_percentage_model['group_name'] = 'Product Discount Percentage';
        $discount_percentage_model['value'][]    = ['discount_percentage'=>(count($item->discounts))?
        $item->discounts[0]->percentage:''];

        // tags
        $tags_model['key']        = 'tags';
        $tags_model['group_name'] = 'Tags';
        $tags_model['value'][]    = [
            'tags' => $this->getProductTags($item)
        ];

        $more[] = $kv_model;
        $more[] = $extra_model;
        $more[] = $att_model;
        $more[] = $categories_model;
        $more[] = $category_id_model;
        $more[] = $discount_percentage_model;
        $more[] = $type_model;
        $more[] = $manufacturer_model;
        $more[] = $tags_model;
        return $more;
    }

    public function getProductTags($product)
    {
        $tags_rel_product = EntityTags::find([
            'entity_id = 1 and item_id = {item} and module_id = 8',
            'bind' => [
                'item' => $product->ID
            ]
        ]);

        $tags_ids = [];

        foreach($tags_rel_product as $tag_rel_p)
        {
            $tags_ids[] = $tag_rel_p->tag_id;
        }

        $products_tags = Tags::query()->inWhere('id', $tags_ids)->execute();

        return $products_tags;
    }

    public function getCategoriesTree($category, $categories_tree=[])
    {
        $categories_tree[] = ['id'=>$category->ID, 'parent_id'=>$category->Parent_Depts_ID];

        if($category->Parent_Depts_ID != 0)
        {
            $parent = \DataCmsDeptsRel::findFirst($category->Parent_Depts_ID);
            $this->getCategoriesTree($parent, $categories_tree);
        }
        else
        {
            return $categories_tree;
        }
    }

    private function getDataCmsExtraFields($item,$lang_id=null)
    {
        // TODO the extra fields should be returned based on the module type
        $extra_fields_arr = [];
        $extra_fields_model['parameter'] = '';
        $extra_fields_model['value'] = '';

        $extra_fields = ProductExtraFields::findFirst([
            'item_id = {item_id}',
            'bind' => [
                'item_id' => $item->ID
            ]
        ]);

        if($extra_fields)
        {
            foreach($extra_fields as $key=>$value)
            {
                if($key !== 'module_id' && $key !== 'item_id' && $key !== 'tax_percent')
                {
                    $extra_fields_model['parameter'] = $key;
                    if($lang_id==null || $lang_id==2){
                        $extra_fields_model['name'] = $key;
                    }elseif($lang_id==1){
                        $extra_fields_model['name'] = $key;
                    }
                    $extra_fields_model['value'] = $value;
                    $extra_fields_arr[] = $extra_fields_model;
                }
            }
        }

        // Add The new Tax method 30/04/2018
        if($item->Module_ID==8){

            $tax_percent = $item->extraFields?$item->extraFields->tax_percent:0;

            //check department tax

            $product_department = $item->Depts;
            if(count($product_department)>0){
                $dept_id =$product_department[0]->Depts_ID;
                //check dept tax
                $dept_tax=$this->getDepartmentTaxPercentage($dept_id);
                if($dept_tax!=0){
                    $tax_amount = $dept_tax;
                }else{
                    $tax_amount = $tax_percent;
                }
            }else{
                $tax_amount = $tax_percent;
            }
            $extra_fields_model['parameter']="tax_percent";
            $extra_fields_model['name']="tax_percent";
            $extra_fields_model['value'] = $tax_amount;
            $extra_fields_arr[] = $extra_fields_model;
        }



        return $extra_fields_arr;
    }

    public function getDataCmsItemReturn($item,$lang_id=null) {
        $duration = $this->duration($item->DateTime);
        $name= (!empty($item->Title)) ? $item->Title : '';
        $des= (!empty($item->Des)) ? $item->Des : '';
        $content =(!empty(($item->Content))) ? ($item->Content) : '';
        //get langs
        $langs=[];
        foreach ($item->lang as $lang){
            $langs[]= $lang->toArray();
        }

        if($lang_id!=0 && $lang_id!=null){

            foreach($item->getLang(["lang_id= {$lang_id}"]) as $item_lang){
                $name= $item_lang->title;
                $des= $item_lang->des;
                $content= $item_lang->content;

            }
        }else{

            $name= (!empty($item->Title)) ? $item->Title : '';
            $des= (!empty($item->Des)) ? $item->Des : '';
            $content =(!empty(($item->Content))) ? ($item->Content) : '';
        }

       // die($content);

        if(isset($_GET["mobile"])){
            $content =str_replace("\n","",html_entity_decode($content));
            $content =str_replace("\t","",html_entity_decode($content));
            $content =str_replace("\r","",html_entity_decode($content));

        }

        return array(
            'id' => $item->ID,
            'name' => $name,
            'description' => $des,
            'image' => (!empty($this->baseUri.static::UPLOAD_LOCATION.$item->Img)) ? $this->baseUri.static::UPLOAD_LOCATION.$item->Img : '',
            'content' =>  $content,
            'created_at' => (!empty($item->DateTime)) ? $item->DateTime : '',
            'duration' => (!empty($duration)) ? $duration : '',
//            'langs' => $langs,
//            'module_id' => (!empty($item->Module_ID)) ? $item->Module_ID : '',
//            'active'=>$item->Active,
            'visit_num'=>$item->Visit_Num,
            'order'=> $item->Order,
            'product_type' => 1
        );
    }
    public function getDataCmsDeptsRelItemReturn($item) {
        $duration = $this->duration($item->created_at);
        return array(
            'id' => $item->ID,
            'name' => (!empty($item->Title)) ? $item->Title : '',
            'description' => (!empty($item->Des)) ? $item->Des : '',
            'image' => (!empty(static::UPLOAD_LOCATION.$item->Img)) ? static::UPLOAD_LOCATION.$item->Img : '',
            'created_at' => (!empty($item->created_at)) ? $item->created_at : '',
            'duration' => (!empty($duration)) ? $duration : ''

        );
    }
    private function getDataCmsKeyValues($item,$lang_id) {
        $keyvalues = \DataKeyvalueUserdata::find(["Item_ID={$item->ID}"]);
        $response = [];
        if (count($keyvalues) < 1) {
            return $response;
        }
        foreach ($keyvalues as $value) {
            if($value->DataKeyvalue->DataKeyvalueGroup->Is_Dept==2){
                continue;
            }
            $tilte = $value->Title;
            $des = $value->Des;
            $kv_value= [];
            $kv_value["value_id"] = "";
            $kv_value["value_title"] = $value->Value;
//            $value_langs = [];
            if($lang_id!=0 || $lang_id!= null){
                if($value->DataKeyvalue->has_langs == 1){
                    foreach ($value->getLangs(["lang_id={$lang_id}"]) as $kv_lang){
                        $tilte = $kv_lang->title?:"";
                        $des = $kv_lang->des?:"";
                        $kv_value["value_id"] = "";
                        $kv_value["value_title"] = $kv_lang->value;
                    }
                }
            }
            $value_multi=[];



            if($value->DataKeyvalue->CKV_ID==1 ||$value->DataKeyvalue->CKV_ID==3 ||$value->DataKeyvalue->CKV_ID==8 ){
                if($value->DataKeyvalue->CKV_ID==3){
                    $values_array= explode(",",$value->Value);
                    foreach ($values_array as $value_array){
                        $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value_array}"]);
                        $value_option["value_id"]=$option_lang->Option_ID;
                        $value_option["value_title"]=$option_lang->Title;
                        if($lang_id!=0 || $lang_id!= null){
                            $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value_array} AND Lang_ID={$lang_id}"]);
                            if($option_lang){
                                $value_option["value_id"]=$option_lang->Option_ID;
                                $value_option["value_title"]=$option_lang->Title;
                            }
                        }
                        $value_multi[]= $value_option;
                    }

                }elseif($value->DataKeyvalue->CKV_ID==8){
                    $values_array= explode(",",$value->Value);
                    foreach ($values_array as $value_array){
                        $data_keyvalue_entity = DataKeyvalueEntity::findFirst(["dkv_id={$value->DKV_ID}"]);
                        $model_name= $data_keyvalue_entity->SetupEntities->model_name;
                        $model= new $model_name();
                        $option = $model->findFirst(["id={$value_array}"]);
                        $value_option["value_id"]=$option->id;
                        $value_option["value_title"]=$option->name;
                        $metadata = $model->getModelsMetaData();
                        $attributes = $metadata->getAttributes($model);
                        foreach($attributes as $k=>$v){
                            if (in_array($v,array('id','name'))) unset($attributes[$k]);
                        }
                        foreach ($attributes as $v){
                            $value_option[$v]=$option->{$v};
                        }

                        $value_multi[]= $value_option;
                    }
                }else{
                        $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value}"]);
                        $value_option["value_id"]=$option_lang->Option_ID;
                        $value_option["value_title"]=$option_lang->Title;
                        if($lang_id!=0 || $lang_id!= null){
                            $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value} AND Lang_ID={$lang_id}"]);
                            if($option_lang){
                                $value_option["value_id"]=$option_lang->Option_ID;
                                $value_option["value_title"]=$option_lang->Title;
                            }
                        }
                        $value_multi[]= $value_option;
                    }

                $kv_value =  $value_multi;

            }
            if($value->DataKeyvalue->CKV_ID==4){
                $kv_value["value_title"] = "http://penta-test.com/tanks_project/uploads/".$kv_value["value_title"];
            }
            $keyvalue_name = $value->DataKeyvalue->DataKeyvalueLang->Title;
            if($lang_id!=0 || $lang_id!= null){
                $keyvalue_name = $value->DataKeyvalue->getDataKeyvalueLang(["Lang_ID={$lang_id}"])->Title;
            }
            $kv = array(
                'id' => $value->ID,
                'parameter' => $value->DataKeyvalue->Paramter,
                'name'=>$keyvalue_name,
                'value' => $kv_value,
                'dkv_id' => $value->DKV_ID,
                'title' => $tilte,
                'des' => $des,
//                'langs'=> $value_langs,
                'setting_id' => 3
            );
            $response[] = $kv;

        }
        return $response;
    }

    private function getDataCmsKeyValuesAttributes($item,$lang_id, $depts=null) {
        $response = [];

        if(isset($depts) && is_array($depts))
        {
            foreach($depts as $dept_id)
            {
                $dept = \DataCmsDeptsRel::findFirst($dept_id);
                
                foreach($dept->categoryFields as $cat_field)
                {
                    $response_model = [
                        'id' => '',
                        'parameter' => '',
                        'value'     => [
                            'value_id'    => '',
                            'value_title' => ''
                        ],
                        'dkv_id'     => '',
                        'title'      => '',
                        'des'        => '',
                        'setting_id' => ''
                    ];

                    $dkv_user_data = \DataKeyvalueUserdata::findFirst([
                        'DKV_ID = :dkv_id: and Item_ID = :item_id:',
                        'bind' => [
                            'dkv_id'  => $cat_field->ID,
                            'item_id' => $item->ID
                        ]
                    ]);

                    if($dkv_user_data)
                    {
                        $response_model['id'] = $dkv_user_data->ID;
                        $response_model['value']['value_id']    = $dkv_user_data->ID;
                        $response_model['value']['value_title'] = $dkv_user_data->Value;
                        $check_lang = \DataKeyvalueUserdataLang::findFirst(["kv_userdata_id={$dkv_user_data->ID} and lang_id={$lang_id}"]);
                        if($check_lang){
                            $response_model['value']['value_title'] = $check_lang->value;
                        }
                        //Check Keyvalue Type if select box return the title of the selected option
                        $dkv_type = $dkv_user_data->DataKeyvalue->CKV_ID;
                        switch($dkv_type){
                            case 1:
                                $response_model['value']['value_title'] = \DataKeyvalueOptionLang::findFirst(["Option_ID={$dkv_user_data->Value} AND Lang_ID=1"])->Title?:"";
                                break;
                        }
                    }

                    $response_model['parameter']  = $cat_field->Paramter;
                    $response_model['dkv_id']     = $cat_field->ID;
                    $response_model['title']      = $cat_field->getTitle($lang_id);
                    $response_model['des']        = '';
                    $response_model['setting_id'] = 3;

                    $response[] = $response_model;
                }
            }
        }
        else
        {
            foreach($item->categories as $item_dept)
            {
                foreach($item_dept->categoryFields as $cat_field)
                {
                    $response_model = [
                        'id' => '',
                        'parameter' => '',
                        'value'     => [
                            'value_id'    => '',
                            'value_title' => ''
                        ],
                        'dkv_id'     => '',
                        'title'      => '',
                        'des'        => '',
                        'setting_id' => ''
                    ];

                    $dkv_user_data = \DataKeyvalueUserdata::findFirst([
                        'DKV_ID = :dkv_id: and Item_ID = :item_id:',
                        'bind' => [
                            'dkv_id'  => $cat_field->ID,
                            'item_id' => $item->ID
                        ]
                    ]);

                    if($dkv_user_data)
                    {
                        $response_model['id'] = $dkv_user_data->ID;
                        $response_model['value']['value_id']    = $dkv_user_data->ID;


                        $response_model['value']['value_title'] = $dkv_user_data->Value;
                        //Handling Langs

                            $check_lang = \DataKeyvalueUserdataLang::findFirst(["kv_userdata_id={$dkv_user_data->ID} and lang_id={$lang_id}"]);
                            if($check_lang){
                                $response_model['value']['value_title'] = $check_lang->value;
                            }

                        //Check Keyvalue Type if select box return the title of the selected option
                        $dkv_type = $dkv_user_data->DataKeyvalue->CKV_ID;
                        switch($dkv_type){
                            case 1:
                                $response_model['value']['value_title'] = \DataKeyvalueOptionLang::findFirst(["Option_ID={$dkv_user_data->Value} AND Lang_ID=1"])->Title?:"";
                                break;
                        }
                    }

                    $response_model['parameter']  = $cat_field->Paramter;
                    $response_model['dkv_id']     = $cat_field->ID;
                    $response_model['title']      = $cat_field->getTitle($lang_id);
                    $response_model['des']        = '';
                    $response_model['setting_id'] = 3;

                    $response[] = $response_model;
                }
            }
        }

        return $response;
        // **** TODO .. loop on the datakeyvalue
        // structure a model for each keyvalue
        // the values inside it which are related to the keyvalueuserdata should be get on time that it is required
        // after structuring all of the datakeyvalue arrays combine them all together and then send them




//         $keyvalues = \DataKeyvalueUserdata::find(["Item_ID={$item->ID}"]);
//         $response = [];
//         if (count($keyvalues) < 1) {
//             return $response;
//         }
//         foreach ($keyvalues as $value) {
//             if($value->DataKeyvalue->DataKeyvalueGroup->Is_Dept!=2){
//                 continue;
//             }
//             $tilte = $value->Title;
//             $des = $value->Des;
//             $kv_value= [];
//             $kv_value["value_id"] = "";
//             $kv_value["value_title"] = $value->Value;
// //            $value_langs = [];
//             if($lang_id!=0 || $lang_id!= null){
//                 if($value->DataKeyvalue->has_langs == 1){
//                     foreach ($value->getLangs(["lang_id={$lang_id}"]) as $kv_lang){
//                         $tilte = $kv_lang->title?:"";
//                         $des = $kv_lang->des?:"";
//                         $kv_value = $kv_lang->value;
//                     }
//                 }
//             }
//             $value_multi="";

//             if($value->DataKeyvalue->CKV_ID==1 ||$value->DataKeyvalue->CKV_ID==3 ||$value->DataKeyvalue->CKV_ID==8 ){
//                 if($value->DataKeyvalue->CKV_ID==3){
//                     $values_array= explode(",",$value->Value);
//                     foreach ($values_array as $value_array){
//                         $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value_array}"]);
//                         $value_option["value_id"]=$option_lang->Option_ID;
//                         $value_option["value_title"]=$option_lang->Title;
//                         if($lang_id!=0 || $lang_id!= null){
//                             $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value_array} AND Lang_ID={$lang_id}"]);
//                             if($option_lang){
//                                 $value_option["value_id"]=$option_lang->Option_ID;
//                                 $value_option["value_title"]=$option_lang->Title;
//                             }
//                         }
//                         $value_multi[]= $value_option;
//                     }

//                 }elseif($value->DataKeyvalue->CKV_ID==8){
//                     $values_array= explode(",",$value->Value);
//                     foreach ($values_array as $value_array){
//                         $data_keyvalue_entity = DataKeyvalueEntity::findFirst(["dkv_id={$value->DKV_ID}"]);
//                         $model_name= $data_keyvalue_entity->SetupEntities->model_name;
//                         $model= new $model_name();
//                         $option = $model->findFirst(["id={$value_array}"]);
//                         $value_option["value_id"]=$option->id;
//                         $value_option["value_title"]=$option->name;
//                         $metadata = $model->getModelsMetaData();
//                         $attributes = $metadata->getAttributes($model);
//                         foreach($attributes as $k=>$v){
//                             if (in_array($v,array('id','name'))) unset($attributes[$k]);
//                         }
//                         foreach ($attributes as $v){
//                             $value_option[$v]=$option->{$v};
//                         }

//                         $value_multi[]= $value_option;
//                     }
//                 }else{
//                     $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value}"]);
//                     $value_option["value_id"]=$option_lang->Option_ID;
//                     $value_option["value_title"]=$option_lang->Title;
//                     if($lang_id!=0 || $lang_id!= null){
//                         $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value} AND Lang_ID={$lang_id}"]);
//                         if($option_lang){
//                             $value_option["value_id"]=$option_lang->Option_ID;
//                             $value_option["value_title"]=$option_lang->Title;
//                         }
//                     }
//                     $value_multi[]= $value_option;
//                 }

//                 $kv_value =  $value_multi;

//             }
//             $kv = array(
//                 'id' => $value->ID,
//                 'parameter' => $value->DataKeyvalue->Paramter,
//                 'value' => $kv_value,
//                 'dkv_id' => $value->DKV_ID,
//                 'title' => $tilte,
//                 'des' => $des,
// //                'langs'=> $value_langs,
//                 'setting_id' => 3
//             );
//             $response[] = $kv;

//         }
//         return $response;
    }
    private function getDataCmsMedia($item) {
        $media = \DataCmsMedia::find(["Item_ID={$item->ID}"]);
        $response = [];
        if (count($media) < 1) {
            return $response;
        }
        foreach ($media as $value) {
            $content_media = [];
            $content_media['id'] = '';
            $content_media['image'] = $this->baseUri.static::UPLOAD_LOCATION . $value->Img;
            $content_media['link'] = $value->Link;
            $content_media['type'] = $value->Type;
            $response[] = $content_media;

        }
        return $response;
    }

    private function getDeptMedia($dept)
    {
        $response = [];

        foreach($dept->media as $media)
        {
            $dept_media = [];

            $dept_media['id']    = '';
            $dept_media['image'] = $this->baseUri.'/'.$media->Img;
            $dept_media['link']  = $media->Link;
            $dept_media['type']  = $media->Type;

            $response[] = $dept_media;
        }

        return $response;
    }

    private function duration ($time) {
        $timediff=time()-$time;
        $days=intval($timediff/86400);
        $remain=$timediff%86400;
        $hours=intval($remain/3600);
        $remain=$remain%3600;
        $mins=intval($remain/60);
        $secs=$remain%60;

        if ($secs>=0) $timestring = "0 minutes ".$secs." seconds ";
        if ($mins>0) $timestring = $mins." minutes ".$secs." seconds ";
        if ($hours>0) $timestring = $hours." hours ".$mins." minutes ";
        if ($days>0) $timestring = $days." days ".$hours." hours ";

        return $timestring;
    }
    //Robo Version 1 Functions

    private function getDataCmsV1($datacms_objs) {
        $data = array();
        foreach($datacms_objs as $item) {
            $data_cms["Basc_Data"] = $this->getDataCmsItemReturnV1($item);
            $data_cms["Setting_Data"]= [];
            $data_cms["Key_Value"]=[];
            $data_cms["Others_Data"]=[];
            $data[]= $data_cms;

        }
        return $data;
    }


    public function getDataCmsItemReturnV1($item) {
        $duration = $this->duration($item->DateTime);
        //get langs
        $langs=[];
        foreach ($item->lang as $lang){
            $langs[]= $lang->toArray();
        }
        return array(
            'ID' => $item->ID,
            'Title' => (!empty($item->Title)) ? $item->Title : '',
            'Des' => (!empty($item->Des)) ? $item->Des : '',
            'Pic' => (!empty(static::UPLOAD_LOCATION.$item->Img)) ? static::UPLOAD_LOCATION.$item->Img : '',
            'Content' => (!empty(strip_tags($item->Content))) ? strip_tags($item->Content) : '',
            'DateTime' => (!empty($item->DateTime)) ? $item->DateTime : '',
            'Key' => "",
            'Link_Share' => "",
            'Links'=>"",
            'Parameter_Filter'=>"",
            'Images' => $this->getDataCmsMediaImagesV1($item),
            'Videos'=>$this->getDataCmsMediaVideosV1($item),

        );
    }
    private function getDataCmsKeyValuesV1($item) {
        $keyvalues = \DataKeyvalueUserdata::find(["Item_ID={$item->ID}"]);
        $response = [];
        if (count($keyvalues) < 1) {
            return $response;
        }
        foreach ($keyvalues as $value) {
            $value_langs = [];
//            foreach ($value->langs as $lang){
//                $value_langs[] =[
//                    "lang_id"=>$lang->lang_id,
//                    "value"=>$lang->value,
//                ];
//            }
            $kv = array(
                'id' => $value->ID,
                'paramter' => $value->DataKeyvalue->Paramter,
                'value' => $value->Value,
                'dkv_id' => $value->DKV_ID,
                'langs'=> $value_langs,

                'setting_id' => 3
            );
            $response[] = $kv;

        }
        return $response;
    }
    private function getDataCmsMediaImagesV1($item) {
        $media = \DataCmsMedia::find(["Item_ID={$item->ID} AND Type='Img'"]);
        $response = [];
        if (count($media) < 1) {
            return $response;
        }
        foreach ($media as $value) {
            $response[] = static::UPLOAD_LOCATION . $value->Img;
        }
        return $response;
    }
    private function getDataCmsMediaVideosV1($item) {
        $media = \DataCmsMedia::find(["Item_ID={$item->ID} AND Type='Video'"]);
        $response = [];
        if (count($media) < 1) {
            return $response;
        }
        foreach ($media as $value) {
            $response[] = $value->Link;
        }
        return $response;
    }

    public function getOffers($offer_id, $region_id,$lang_id)
    {
        $response['status']  = [];
        $response['content'] = [];

        try
        {

            $offers = Offers::getDetailed($offer_id, $region_id, $this->baseUri, static::UPLOAD_LOCATION,null,$lang_id);

            $response['status']  = $this->getStatus(200, 'Offers Loaded');
            $response['content'] = $offers;
        }
        catch(\Exception $e)
        {
            $response['status']  = $this->getStatus($e->getCode(), 'Error loading offers');
        }

        return $response;
    }

    public function getHomePageOffers($lang_id)
    {
        $response['status'] = [];
        $response['content'] = [];

        try
        {
            $homepage_offers = Offers::getDetailed(null, null, $this->baseUri, static::UPLOAD_LOCATION, 1,$lang_id);

            $response['status']  = $this->getStatus(200, 'Homepage Offers Loaded');
            $response['content'] = $homepage_offers;
        }
        catch(\Exception $e)
        {
            $response['status']  = $this->getStatus($e->getCode(), $e->getMessage());
        }

        return $response;
    }

    public function getOffersByName($name)
    {
        $response['status']  = $this->getStatus(200, 'Offers loaded');
        $response['content'] = [];
        $offers = Offers::find([
            'name like {name}',
            'bind' => [
                'name' => '%'.$name.'%'
            ]
        ]);

        $response['content'] = $offers;

        // Helpers::saveSearchKeyword($name);

        return $response;
    }

    public function getDiscounts()
    {
        $response['status']  = [];
        $response['content'] = [];

        try
        {
            $discounts = Discounts::getDetailed();

            for($i=0; $i<count($discounts); $i++)
            {
                $discounts[$i]['products'] = $this->getDataCms($discounts[$i]['products']);
            }

            $response['status']  = $this->getStatus(200, 'Discounts Loaded');
            $response['content'] = $discounts;
        }
        catch(\Exception $e)
        {
            $response['status'] = $this->getStatus($e->getCode(), 'Error loading discounts');
        }

        return $response;
    }

    public function getRegions($city_id, $lang_id)
    {
        $response['status'] = [];
        $response['content'] = [];

        try
        {
            $regions = null;
            $regions_arr = [];
             $regions = TanksRegions::find();
            foreach($regions as $region)
            {
                $regions_arr[] = ['id' => $region->id, 'name' => $region->name];

            }


            $response['status']  = $this->getStatus(200, 'Regions Loaded');
            $response['content'] = $regions_arr;

        }
        catch(\Exception $e)
        {
            $response['status'] = $this->getStatus($e->getCode(), $e->getMessage());
        }

        return $response;
    }

    public function getCities($country_id, $lang_id)
    {
        $response['status']  = 0;
        $response['content'] = [];

        try
        {
            $cities = null;
            $cities_arr = [];


                $cities = TanksCities::find();
            foreach($cities as $city) {
                $cities_arr[] = ['id' => $city->id, 'name' => $city->name];
            }

            
            $response['status']  = $this->getStatus(200, 'Cities loaded');
            $response['content'] = $cities_arr;
        }
        catch(\Exception $e)
        {
            $response['status'] = $this->getStatus($e->getCode(), $e->getMessage());
        }

        return $response;
    }

    public function getCountries($lang_id)
    {
        $response['status']  = 0;
        $response['content'] = [];

        try
        {
            $countries = TanksCountries::find();
            $countries_arr = [];
            foreach($countries as $country)
            {
                $countries_arr[] = ['id' => $country->id, 'name' => $country->name];
            }


            $response['status']  = $this->getStatus(200, 'Countries Loaded');
            $response['content'] = $countries_arr;
        }
        catch(\Exception $e)
        {
            $response['status'] = $this->getStatus($e->getCode(), $e->getMessage());
        }

        return $response;
    }

    public function getCartExtraData($user_id)
    {
        $response['status']  = [];
        $response['content'] = [];
        $price = 0;
        $discount_amount = 0;
        //tax addition after calculating tax
        $tax_amount      = 0;

        $cart = Orders::getDetailed($user_id, OrderStatuses::cart());

        for($i = 0; $i < count($cart['items']['cms']); $i++)
        {
            if($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id']))
            {
                $price += $this->getItemPrice($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id'])['id']) * $cart['items']['cms'][$i]['count'];
                
                $discount_amount += $this->getItemDiscountAmount($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id'])['id']);
                
                $tax_amount += $this->getItemTaxAmount($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id'])['id']) * $cart['items']['cms'][$i]['count'];
            }
        }

        for($i = 0; $i < count($cart['items']['offers']); $i++)
        {
            if($this->getOrderItemOfferDetails($cart['items']['offers'][$i]['id']))
            {
                $price += $this->getOfferPrice($this->getOrderItemOfferDetails($cart['items']['offers'][$i]['id'])['id']) * $cart['items']['offers'][$i]['count'];
                $tax_amount += $this->getOfferTaxAmount($this->getOrderItemOfferDetails($cart['items']['offers'][$i]['id'])['id']);
            }
        }

        $extra_response['price']           = $price;
        $extra_response['discount_amount'] = $discount_amount;
        $extra_response['tax_amount']      = $tax_amount;
        $extra_response['total_price']     = $price - $discount_amount + $tax_amount;
        $extra_response['user_address']    = UsersMobile::getMainAddress($user_id);
        $extra_response['payment_methods'] = Companies::findFirst(1)->paymentMethods;

        $response['status']  = $this->getStatus(200, 'Cart extra data loaded');
        $response['content'][] = $extra_response;

        return $response;
    }

    public function getCart($user_id)
    {
        $cart_response = [];
        $response['status'] = [];
        $response['content'] = [];

        try
        {
            $cart = Orders::getDetailed($user_id, OrderStatuses::cart());

            for($i = 0; $i < count($cart['items']['cms']); $i++)
            {
                // Language Turnarround
//                $lang_id= 2;
//                if($this->request->get("lang_id")){
//                    $lang_id =   $this->request->get("lang_id");
//                }
//                if($lang_id==1){
//                    $product_id= $cart['items']['cms'][$i]['id'];
//                    $product_lang=\DataCmsLang::findFirst(["lang_id=1 and data_cms_id={$product_id}"]);
//                    if($product_lang){
//                        $cart['items']['cms'][$i]['name']=$product_lang->title;
//                        $cart['items']['cms'][$i]['description']=$product_lang->des;
//                        $cart['items']['cms'][$i]['content']=$product_lang->content;
//                    }
//                }

                if($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id']))
                {
                    $cart_response[] = $this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id']);
                }
            }

            for($i = 0; $i < count($cart['items']['offers']); $i++)
            {
                if($this->getOrderItemOfferDetails($cart['items']['offers'][$i]['id']))
                {
                    $cart_response[] = $this->getOrderItemOfferDetails($cart['items']['offers'][$i]['id']);
                }
            }

            $response['status'] = $this->getStatus(200, 'Cart LogetOrderItemCmsDetailsaded');
            $response['content'] = $cart_response;
        }
        catch(\Exception $e)
        {
            $response['status'] = $this->getStatus($e->getCode(), $e->getMessage());
        }

        return $response;
    }

    public function getItemTaxAmount($item_id)
    {
        $tax_amount = 0;

        $item = Content::findFirst($item_id);

        $item_price  = floatval(($item->extraFields)?$item->extraFields->price:0);
        $tax_percent = $item->extraFields?$item->extraFields->tax_percent:0;

        //check department tax

        $product_department = $item->Depts;
        if(count($product_department)>0){
            $dept_id =$product_department[0]->Depts_ID;
            //check dept tax
            $dept_tax=$this->getDepartmentTaxPercentage($dept_id);
            if($dept_tax!=0){
                $tax_amount =  $item_price * ($dept_tax/100);
            }else{
                $tax_amount = $item_price * ($tax_percent/100);
            }
        }else{
            $tax_amount =  0;
        }

        return $tax_amount;
    }

    public function getItemDiscountAmount($item_id)
    {
        $discount_amount = 0;

        $item = Content::findFirst($item_id);

        $item_price = floatval(($item->extraFields)?$item->extraFields->price:0);
        $item_original_price = floatval(($item->extraFields)?$item->extraFields->old_price:0);

        $discount = (count($item->discounts))?$item->discounts[0]:null;



        if(isset($discount))
        {
            // $discount_amount = $item_original_price - $item_price;
            $discount_amount = $item_price * ($discount->percentage / 100);
        }


        return $discount_amount;
    }

    private function getItemPrice($item_id)
    {
        $item  = Content::findFirst($item_id);
        $price = ($item->extraFields)?floatval($item->extraFields->price):0;
        //$price = $price + ($price * ($item->extraFields->tax_percent / 100));
        return $price;
    }

    public function getOfferPrice($offer_id)
    {
        $offer = Offers::findFirst($offer_id);
        return floatval($offer->price);
    }

    public function getOfferTaxAmount($offer_id){
        $offer = Offers::findFirst($offer_id);
        $tax_amount = $offer->price * ($offer->tax_percentage / 100);
        return floatval($tax_amount);
    }

    public function getWishlist($user_id)
    {
        $wishlist_response = [];
        $response['status'] = [];
        $response['content'] = [];

        try
        {
            $wishlist = Orders::getDetailed($user_id, OrderStatuses::wishList());

            for($i = 0; $i < count($wishlist['items']['cms']); $i++)
            {
                if($this->getOrderItemCmsDetails($wishlist['items']['cms'][$i]['id']))
                {
                    $wishlist_response[] = $this->getOrderItemCmsDetails($wishlist['items']['cms'][$i]['id']);
                }
            }

            for($i = 0; $i < count($wishlist['items']['offers']); $i++)
            {
                if($this->getOrderItemOfferDetails($wishlist['items']['offers'][$i]['id']))
                {
                    $wishlist_response[] = $this->getOrderItemOfferDetails($wishlist['items']['offers'][$i]['id']);
                }
            }

            $response['status'] = $this->getStatus(200, 'WishList Loaded');
            $response['content'] = $wishlist_response;
        }
        catch(\Exception $e)
        {
            $response['status'] = $this->getStatus($e->getCode(), $e->getMessage());
        }

      return $response;
    }

    public function getOrderItemCmsDetails($order_item_id)
    {
        $order_item = OrderItems::findFirst($order_item_id);

        if($order_item->cmsDetails)
        {
            $result = $this->getDataCms([$order_item->cmsDetails])[0];
            // Handling Mobile
            if(isset($_GET["mobile"])){
                $cart_count_model['key'] = 'cart_count';
                $cart_count_model['group_name'] = 'Cart Count';
                $cart_count_model['value'][] =  array(
                        "value_type" =>  "normal",
                        "value_string" =>  $order_item->count
                    );
                $result['more'][] = $cart_count_model;
            }else{
                $cart_count_model['key'] = 'cart_count';
                $cart_count_model['group_name'] = 'Cart Count';
                $cart_count_model['value'][] = ['count' => $order_item->count];

                $result['more'][] = $cart_count_model;
            }

            return $result;
        }
        else
        {
            return [];
        }
    }

    public function getOrderItemOfferDetails($order_offer_id)
    {

        $order_offer = OrderItems::findFirst($order_offer_id);
        $result = (count($this->getOffers($order_offer->item_id, null)['content']) != 0)?$this->getOffers($order_offer->item_id, null)['content'][0]:[];
        $cart_count_model['key']        = 'cart_count';
        $cart_count_model['group_name'] = 'Cart Count';
        if($this->is_mobile == 1){
            $cart_count_model['value'][] =  array(
                "value_type" =>  "normal",
                "value_string" =>  $order_offer->count
            );
            $result['more'][] = $cart_count_model;
        }else{
            $cart_count_model['value'][]    = ["count"=>$order_offer->count];

            $result['more'][] = $cart_count_model;
        }



        return $result;
    }

    public function addToCart($user_id, $controller)
    {
        $response['status'] = [];
        $response['content'] = [];

        if(!$controller->request->isPost())
        {
            $response['status'] = $this->getStatus(400, 'Wrong HTTP method :' . $controller->request->getMethod().':');
        }
        else
        {
            try
            {
                // $validation_result = $controller->validationService->validateRequest($controller->request, [
                //     'id','count','type_id','delivery_place']);
                $validation_result = $controller->validationService->validateRequest($controller->request, [
                    'id','count','type_id']);

                if(count($validation_result))
                {
                    if($controller->lang_id == 2)
                    {
                        $response['status'] = $this->getStatus(422, 'Missing required params', $validation_result);
                    }
                    else
                    {
                        $response['status'] = $this->getStatus(422, 'رجاء ملأ الحقول المطلوبة', $validation_result);
                    }
                }
                else
                {
                    $cart_id = Orders::getUserCart($user_id)->id;

                    $request_data = $controller->validationService->getRequestData($controller->request);

                    if($request_data['type_id'] == OrderItemTypes::offer())
                    {
                        $offer = Offers::findFirst($request_data['id']);

                        if(!$offer)
                        {
                            if($controller->lang_id == 2)
                            {
                                $response['status'] = $this->getStatus(400, 'Error adding offer to cart',[
                                'Offer doesn\'t exist'
                            ]);
                            }
                            else
                            {
                                $response['status'] = $this->getStatus(400, 'خطأ أثناء إضافة العرض في سلة التسوق',[
                                'العرض غير موجود'
                            ]);
                            }
                        }
                        else
                        {
                            //This is For Test / to be replaced by offer_max_purchase_number
                            if($request_data['count'] > 2000)
                            {
                                if($controller->lang_id == 2)
                                {
                                    $response['status'] = $this->getStatus(400, 'Error adding offer to cart',[
                                    'Offer request exceeds maximum number of purchase number'
                                ]);
                                }
                                else
                                {
                                    $response['status'] = $this->getStatus(400, 'خطأ أثناء إضافة العرض في سلة التسوق',[
                                    'تم تخطي الحد الأقصى من عدد العروض التي يمكن طلبها'
                                ]);
                                }
                            }
                            else
                            {
                                $inserted_item = $this->insertItemToCart($request_data, $cart_id);
                                if($inserted_item)
                                {
                                    if($controller->lang_id == 2)
                                    {
                                        $response['status'] = $this->getStatus(200, 'Offer added to cart');
                                    }
                                    else
                                    {
                                        $response['status'] = $this->getStatus(200, 'تم إضافة العرض في سلة التسوق');
                                    }
                                }
                                else
                                {
                                    if($controller->lang_id == 2)
                                    {
                                        $response['status'] = $this->getStatus(409, 'Error adding offer to cart',
                                        $inserted_item->getMessages()->toArray());
                                    }
                                    else
                                    {
                                        $response['status'] = $this->getStatus(409, 'خطأ أثناء إضافة العرض في سلة التسوق',
                                        $inserted_item->getMessages()->toArray());
                                    }
                                }
                            }
                        }
                    }
                   else
                   {
                       $product = Content::findFirst($request_data['id']);

                       if(!$product)
                       {
                            if($controller->lang_id == 2)
                            {
                                $response['status'] = $this->getStatus(400, 'Error adding product to cart',[
                               'Product doesn\'t exist'
                           ]);
                            }
                            else
                            {
                                $response['status'] = $this->getStatus(400, 'خطأ أثناء إضافة المنتج في سلة التسوق',[
                               'المنتج غير موجود'
                           ]);
                            }
                       }
                       else
                       {
                           $inserted_item = $this->insertItemToCart($request_data, $cart_id);
                           if($inserted_item)
                           {
                                if($controller->lang_id == 2)
                                {
                                    $response['status'] = $this->getStatus(200, 'Product added to cart');
                                }
                                else
                                {
                                    $response['status'] = $this->getStatus(200, 'تم إضافة المنتج في سلة التسوق');
                                }
                           }
                           else
                           {
                                if($controller->lang_id == 2)
                                {
                                    $response['status'] = $this->getStatus(409, 'Error adding product to cart',
                                   $inserted_item->getMessages()->toArray());
                                }
                                else
                                {
                                    $response['status'] = $this->getStatus(409, 'خطأ أثناء إضافة المنتج في سلة التسوق',
                                   $inserted_item->getMessages()->toArray());
                                }
                           }
                       }
                   }
                }
            }
            catch(\Exception $e)
            {
                $response['status'] = $this->getStatus($e->getCode(), $e->getMessage());
            }
        }

        return $response;
    }

    private function insertItemToCart($request_data, $cart_id)
    {
        $new_item = OrderItems::findFirst([
            'item_id = {item_id} and item_type_id = {type_id}',
            'bind' => [
                'item_id' => $request_data['id'],
                'type_id' => $request_data['type_id']
            ]
        ]);

        if(!$new_item)
        {
            $new_item = new OrderItems();
        }

        $new_item->application_id = 1;
        $new_item->module_id      = 1;
        $new_item->order_id       = $cart_id;
        $new_item->item_id        = (isset($request_data['id']))?$request_data['id']:0;
        $new_item->item_type_id   = (isset($request_data['type_id']))?$request_data['type_id']:0; // 1 -> cms , 2 -> offer
        $new_item->date           = time();
        $new_item->cost           = (isset($request_data['cost']))?$request_data['cost']:0;
        $new_item->count          = (isset($request_data['count']))?$request_data['count']:0;
        $new_item->color          = (isset($request_data['color']))?$request_data['color']:null;
        $new_item->delivery_place = isset($request_data['delivery_place'])?$request_data['delivery_place']:null;
        $new_item->updated_at     = time();

        return $new_item->save();
    }

    public function removeFromCart($user_id, $controller)
    {
        $response['status'] = [];
        $response['content'] = [];

        if(!$controller->request->isPost())
        {
            $response['status'] = $this->getStatus(400, 'Wrong HTTP method :' . $controller->request->getMethod().':');
        }
        else
        {
            try
            {
                $validation_result = $controller->validationService->validateRequest($controller->request,
                    ['item_id','type_id']);

                if(count($validation_result))
                {
                    $response['status'] = $this->getStatus(422, 'Missing required params', $validation_result);
                }
                else
                {
                    $request_data = $controller->validationService->getRequestData($controller->request);

                    $cart = Orders::getUserCart($user_id);
                    $item = $cart->getItems([
                        'item_id = '.$request_data['item_id'].' and item_type_id = '.$request_data['type_id']
                    ]);

                    if(count($item)>0)
                    {
                        if($item[0]->delete())
                        {
                            $response['status'] = $this->getStatus(200, 'Item removed from cart');
                        }
                        else
                        {
                            $response['status'] = $this->getStatus(409, 'Error removing item from cart',
                                $item[0]->getMessages()->toArray());
                        }
                    }
                    else
                    {
                        $response['status'] = $this->getStatus(409, 'Error removing item from cart',
                           ['Item doesn\'t exist']);
                    }
                }
            }
            catch(\Exception $e)
            {
                $response['status'] = $this->getStatus($e->getCode(), $e->getMessage());
            }
        }

        return $response;
    }

    public function addToWishlist($user_id, $controller)
    {
        $response['status'] = [];
        $response['content'] = [];

        if(!$controller->request->isPost())
        {
            $response['status'] = $this->getStatus(400, 'Wrong HTTP method :' . $controller->request->getMethod().':');
        }
        else
        {
            try
            {
                $validation_result = $controller->validationService->validateRequest($controller->request, ['id','type_id']);

                if(count($validation_result))
                {
                    $response['status'] = $this->getStatus(422, 'Missing required params', $validation_result);
                }
                else
                {
                    $wishlist_id =  Orders::getUserWishlist($user_id)->id;

                    $request_data = $controller->validationService->getRequestData($controller->request);

                    if($request_data['type_id'] == OrderItemTypes::offer())
                    {
                        $offer = Offers::findFirst($request_data['id']);

                        if(!$offer)
                        {
                            if($controller->lang_id == 2)
                            {
                                $response['status'] = $this->getStatus(400, 'Error adding offer to wishlist',[
                                'Offer doesn\'t exist'
                            ]);
                            }
                            else
                            {
                                $response['status'] = $this->getStatus(400, 'خطأ أثناء إضافة العرض في قائمة الأمنيات',[
                                'العرض غير موجود'
                            ]);
                            }
                        }
                        else
                        {
                            $inserted_item = $this->insertItemToCart($request_data, $wishlist_id);
                            if($inserted_item)
                            {
                                if($controller->lang_id == 2)
                                {
                                    $response['status'] = $this->getStatus(200, 'Offer added to wishlist');
                                }
                                else
                                {
                                    $response['status'] = $this->getStatus(200, 'تم إضافة العرض لقائمة الأمنيات');
                                }
                            }
                            else
                            {
                                if($controller->lang_id == 2)
                                {
                                    $response['status'] = $this->getStatus(409, 'Error adding offer to wishlist',
                                    $inserted_item->getMessages()->toArray());
                                }
                                else
                                {
                                    $response['status'] = $this->getStatus(409, 'خطأ أثناء إضافة العرض لقائمة الأمنيات',
                                    $inserted_item->getMessages()->toArray());
                                }
                            }
                        }
                    }
                    else
                    {
                        $product = Content::findFirst($request_data['id']);

                        if(!$product)
                        {
                            if($controller->lang_id == 1)
                            {
                                $response['status'] = $this->getStatus(400, 'Error adding product to wishlit',[
                                'Product doesn\'t exist'
                            ]);
                            }
                            else
                            {
                                $response['status'] = $this->getStatus(400, 'خطأ أثناء إضافة المنتج لقائمة الأمنيات',[
                                'المنتج غير موجود'
                            ]);
                            }
                        }
                        else
                        {
                            $inserted_item = $this->insertItemToCart($request_data, $wishlist_id);
                            if($inserted_item)
                            {
                                if($controller->lang_id == 2)
                                {
                                    $response['status'] = $this->getStatus(200, 'Product added to wishlist');
                                }
                                else
                                {
                                    $response['status'] = $this->getStatus(200, 'تم إضافة المنتج لقائمة الأمنيات');
                                }
                            }
                            else
                            {
                                if($controller->lang_id == 2)
                                {
                                    $response['status'] = $this->getStatus(409, 'Error adding product to wishlist',
                                    $inserted_item->getMessages()->toArray());
                                }
                                else
                                {
                                    $response['status'] = $this->getStatus(409, 'خطأ أثناء إضافة المنتج لقائمة الأمنيات',
                                    $inserted_item->getMessages()->toArray());
                                }
                            }
                        }
                    }
                }
            }
            catch(\Exception $e)
            {
                $response['status'] = $this->getStatus($e->getCode(), $e->getMessage());
            }
        }

        return $response;
    }

    public function getOfferItems($offer_id)
    {
        $response['status'] = [];
        $response['content'] = [];

        if(isset($offer_id))
        {
            $offer = Offers::findFirst($offer_id);

            if($offer)
            {
                $offer_items = $this->getDataCms($offer->products);

                $response['status'] = $this->getStatus(200, 'Offer items loaded');
                $response['content'] = $offer_items;
            }
            else
            {
                $response['status'] = $this->getStatus(409, 'Offer doesn\'t exist');
            }
        }
        else
        {
            $response['status'] = $this->getStatus(422, 'Missing required params', ['offer_id is required']);
        }


        return $response;
    }

    public function getBranches($region_id,$lang_id)
    {
        $response['status']  = $this->getStatus(200, 'Branches loaded');
        $response['content'] = CompanyBranches::getDetailed($region_id,$lang_id);

        return $response;
    }

    public function checkout($user_id, $controller)
    {
        $response['status']  = [];
        $response['content'] = [];

        if(!$controller->request->isPost())
        {
            $response['status'] = $this->getStatus(400, 'Wrong HTTP method :' . $controller->request->getMethod().':');
        }
        else
        {

                $request_data = $controller->validationService->getRequestData($controller->request);
                $user         = UsersMobile::findFirst($user_id);
                $receipt      = $controller->base64ToImg->convert($request_data['payment_receipt']);

                if(true)
                {
                    if($user->mainAddress)
                    {
                        $total_price = $this->getCartExtraData($user_id)['content'][0]['total_price'];
                        $user_comment     = (isset($request_data['comment']))?$request_data['comment']:'';
                        $create_new_order = Orders::handleChangeCartToNewOrder($user, $receipt, $user_comment, $total_price);

                        if($create_new_order !== false)
                        {
                            $response['status']    = $this->getStatus(200, 'تمت العملية بنجاح');
                            $response['content'][] = $create_new_order;
                            try{
                                $this->getDI()
                                    ->getMail()
                                    ->send([
                                        $user->Mail => "ArabiaTanks"
                                    ], "New Order Created", 'new_order', [
                                        'email.' => $user->Mail
                                    ]);
                            }
                            catch (\Exception $e){
                                $response['status']    = $this->getStatus(200, 'تمت العملية بنجاح ولكن لم يتم ارسال الايميل');

                            }


//                            $this->emailService->send($user->Mail, $user->Title, 'New Order Created', 'new_order',[
//                                'email.' => $user->Mail
//                            ]);
                        }
                        else
                        {
                            $response['status'] = $this->getStatus(409, 'خطأ أثناء العملية ، حاول مرة أخرى');
                        }
                    }
                    else
                    {
                        // error user must have main address
                        $response['status'] = $this->getStatus(400, 'لا يوجد عنوان رئيسي للمستخدم');
                    }
                }
                else
                {
                    // error uploading payment receipt
                    $response['status'] = $this->getStatus(400, 'حدث خطأ أثناء رفع إيصال الإيداع، حاول مرة أخرى');
                }

        }

        return $response;
    }

    public function requestVisit($form_id, $data)
    {
        $response['status']  = [];
        $response['content'] = [];

        $form_response = new DataFormsResponse();

        $form_response->Form_ID  = $form_id;
        $form_response->Response = json_encode($data);
        $form_response->IP       = 0;
        $form_response->User_ID  = (isset($data['user_id']))?$data['user_id']:0;
        $form_response->Date     = time();

        if(!$form_response->save())
        {
            $response['status'] = $this->getStatus(409, 'Error submitting form', $form_response->getMessages());
        }
        else
        {
            $response['status'] = $this->getStatus(200, 'Visit requested');
            $response['content'][] = $data;
        }

        return $response;
    }

    public function insertIntoForm($form_id,$form){
        $json_array = array();

        $json_array['Login'] = "0";

        $json_array['msg'] = $form["message"];

        $json_array['send'] = "0";

        $json_array['mail'] = $form["email"];

        $json_array['Name'] = $form["name"];

        $json_array['Title'] = "Customer Service Enquiry";

        $data_forms = new DataFormsResponse();

        $data_forms->Form_ID = 1;

        $data_forms->Response = json_encode($json_array);

        $data_forms->IP = $form["ip"];

        $data_forms->User_ID = 0;

        $data_forms->Date = time();
        $error_messages="";

        if (!$data_forms->save()) {

            foreach ($data_forms->getMessages() as $message) {

                $error_messages.= $message."";

            }
            $response['status'] = $this->getStatus(400, 'Error:'.$error_messages);
            $response['content'] = [];
        }else{
            $response['status'] = $this->getStatus(200, 'Saved Successfully');
            $response['content'] = [];
        }
        return $response;

    }


    public function insertIntoNewsLetter($mail,$application_id){
        $newsletter=NewsLetter::findFirst(["mail='{$mail}'"]);
        if($newsletter){
            $response['status'] = $this->getStatus(422, 'E-Mail Already Exist');
            $response['content'] = [];
        }else{
            $newsletter = new NewsLetter();
            $newsletter->mail = $mail;
            $newsletter->application_id=$application_id;
            $newsletter->save();
            $response['status'] = $this->getStatus(200, 'E-Mail Saved Sucessfully');
            $response['content'] = [];
        }
        return $response;

    }

    public function structureComparedItems($compared_items)
    {
        $structured_items = [];

        $items_ids = [];

        foreach($compared_items as $compare)
        {
            $items_ids[] = $compare->item_id;
        }

        $cms_items = Content::query()
            ->inWhere("ID", $items_ids)
            ->execute();

        if(count($cms_items))
        {
            $structured_items = $this->getDataCms($cms_items);
        }

        return $structured_items;
    }

    public function returnDeptsTree($depts_tree)
    {
        $response['status']  = $this->getStatus(200, 'Categories tree loaded');
        $response['content'] = $depts_tree;

        return $response;
    }

    public function returnBestSellingProducts($best_selling, $lang_id)
    {
        $response['status']  = $this->getStatus(200, 'Best selling products loaded');
        $response['content'] = $this->getDataCms($best_selling, $lang_id);

        return $response;
    }

    public function getOrderData($user_id,$status_id,$order_id)
    {
        $response['status']  = [];
        $response['content'] = [];
        $price = 0;
        $discount_amount = 0;
        $tax_amount      = 0;

        $cart = Orders::getDetailed($user_id, $status_id,$order_id);

        for($i = 0; $i < count($cart['items']['cms']); $i++)
        {
            if($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id']))
            {
                $price += $this->getItemPrice($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id'])['id']) * $cart['items']['cms'][$i]['count'];

                $discount_amount += $this->getItemDiscountAmount($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id'])['id']);

                $tax_amount += $this->getItemTaxAmount($this->getOrderItemCmsDetails($cart['items']['cms'][$i]['id'])['id']) * $cart['items']['cms'][$i]['count'];
            }
        }

        for($i = 0; $i < count($cart['items']['offers']); $i++)
        {
            if($this->getOrderItemOfferDetails($cart['items']['offers'][$i]['id']))
            {
                $price += $this->getOfferPrice($this->getOrderItemOfferDetails($cart['items']['offers'][$i]['id'])['id']) * $cart['items']['offers'][$i]['count'];
                $tax_amount += $this->getOfferTaxAmount($this->getOrderItemOfferDetails($cart['items']['offers'][$i]['id'])['id']);

            }
        }

        $extra_response['price']           = $price;
        $extra_response['discount_amount'] = $discount_amount;
        $extra_response['tax_amount']      = $tax_amount;
        $extra_response['total_price']     = $price - $discount_amount;

        $response['status']  = $this->getStatus(200, 'Cart extra data loaded');
        $response['content'][] = $extra_response;

        return $response;
    }

    public function getDepartmentTaxPercentage($dept_id){
        $dept_id=(int)$dept_id;
        $dept_tax=TanksTaxes::findfirst(["dept_id={$dept_id}"]);
        if($dept_tax){
            return $dept_tax->tax;
        }else{
            return 0;
        }
    }


    public function addOrderProve($controller)
    {
        $response['status'] = [];
        $response['content'] = [];

        if (!$controller->request->isPost()) {
            $response['status'] = $this->getStatus(400, 'Wrong HTTP method :' . $controller->request->getMethod() . ':');
        }else{
            $data = json_decode(file_get_contents('php://input'), true);

            $order_id= $data["order_id"];
            $receipt      = $controller->base64ToImg->convert($data['payment_receipt']);
            $order = Orders::findFirst(["id={$order_id}"]);
            $order->payment_receipt=$receipt;
           if(!$order->save()){
               $response['status']    = $this->getStatus(204, "Error:{$data["order_id"]},{$receipt}");
           };

            return $response;


        }

    }

    /// FOR "more" structure in mobile
    public function getItemDepts($item)
    {
        $depts = [];

        $depts_rel_item = \DataCmsDeptsRelItem::query()
            ->where('Item_ID = :item_id:')
            ->andWhere('Application_ID = :app_id:')
            ->andWhere('Module_ID = :module_id:')
            ->bind([
                'item_id'   => $item->ID,
                'app_id'    => $this->app_id,
                'module_id' => $this->module_id
            ])->execute();

        foreach($depts_rel_item as $dept_rel)
        {
            $dept = \DataCmsDeptsRel::query()
                ->where('ID = :id:')
                ->andWhere('Application_ID = :app_id:')
                ->andWhere('Module_ID = :module_id:')
                ->bind([
                    'id'        => $dept_rel->Depts_ID,
                    'app_id'    => $this->app_id,
                    'module_id' => $this->module_id
                ])->execute()->getFirst();

            if($dept)
            {
                $dept_rel_model['name'] = $dept->Title;
                $dept_rel_model['des']  = $dept->Des;
                $dept_rel_model['img']  = $dept->Img;
                $dept_rel_model['parent'] = [];

                if($dept->Parent_Depts_ID)
                {
                    $parent = \DataCmsDeptsRel::query()
                        ->where('ID = :id:')
                        ->andWhere('Application_ID = :app_id:')
                        ->andWhere('Module_ID = :module_id:')
                        ->bind([
                            'id' => $dept->Parent_Depts_ID,
                            'app_id' => $this->app_id,
                            'module_id' => $this->module_id
                        ])->execute()->getFirst();

                    $parent_dept_model['name'] = $parent->Title;
                    $parent_dept_model['des']  = $parent->Des;
                    $parent_dept_model['img']  = $parent->Img;

                    $dept_rel_model['parent'] = $parent_dept_model;
                }

                $depts[] = $dept_rel_model;
            }
        }

        return $depts;
    }

    public function getKvValues($dkv, $lang_id) {
        $value_model = [];
        $values = $dkv->values;
        foreach($values as $val) {
            $value_model[] = [
                'value_type' => 'object',
                'value_obj' => array(
                    'value_id' => $val->ID,
                    'value_title' => (count($val->getLangs('lang_id='.$lang_id)) > 0)?$val->getLangs('lang_id='.$lang_id)[0]->value:$val->Value
                )
            ];
        }
        return $value_model;
    }

    public function getDeptKeyvalue($dept, $lang_id) {
        $lang_id = $lang_id?$lang_id:2;
        $kv_groups_ids = [];

        $kv_groups = \DataKeyvalueGroup::query()
            ->where('Is_Dept = :is_dept:')
            ->andWhere('Depts_ID = :dept_id:')
            ->columns('ID')
            ->bind([
                'is_dept' => 1,
                'dept_id' => $dept->ID
            ])->execute();

        foreach($kv_groups as $group) {
            $kv_groups_ids[] = current($group);
        }
        $kv_model = [];
        $key_values = \DataKeyvalue::query()->inWhere('Group_ID', $kv_groups_ids)->execute();
        foreach($key_values as $kv) {
            $kv_model[] = [
                'id' => $kv->ID,
                'parameter' => $kv->Paramter,
                'name' => $kv->getDataKeyvalueLang('Lang_ID = '.$lang_id)?$kv->getDataKeyvalueLang('Lang_ID = '.$lang_id)->Title:'',
                'value' => $this->getKvValues($kv, $lang_id)

            ];
        }
        return $kv_model;
    }

    public function structureDeptsResponseMobile($depts, $lang_id,$with_items = false) {
        $result = [];
        if($depts) {
            $depts_arr = [];
            foreach($depts as $dept) {
                $name = $dept->Title;
                $des = $dept->Des;
                if($lang_id!=null){
                    $dept_lang = \DataCmsDeptsRelLang::findFirst(["dept_id={$dept->ID} AND lang_id={$lang_id}"]);
                    if($dept_lang){
                        $name = $dept_lang->title;
                        $des = $dept_lang->des;
                    }
                }
                $dept_keyvalues = [
                    'key'        => 'keyvalue',
                    'group_name' => 'Depratment KeyValues',
                    'value'      => $this->getDeptKeyvalue($dept, $lang_id)
                ];
                $dept_attrs = [
                    'key'        => 'attributes',
                    'group_name' => 'Department Attributes',
                    'value'      => $this->getDeptAttributes($dept->ID, $lang_id)
                ];
                $dept_media = [
                    'key'        => 'media',
                    'group_name' => 'Depratment Media',
                    'value'      => []
                ];
                $dept_data = [
                    'id' => $dept->ID,
                    'name' => $name,
                    'description' => $des,
                    'image' => $this->baseUri . static::UPLOAD_LOCATION .$dept->Img,
                    'content' => '',
                    'created_at' => $dept->created_at,
                    'duration' => '',
                    'visit_num' => '',
                    'order' => '',
                    'link_share' => '',
                    'items_count' => count($dept->DeptsContent),
                    'more' => [$dept_keyvalues, $dept_attrs, $dept_media]
                ];

                if($with_items)
                {
                    $items_ids = [];
                    $dept_data['cms'] = [];

                    $items = $dept->DeptsContent;

                    if(count($items))
                    {
                        foreach($items as $item)
                        {
                            $items_ids[] = $item->Item_ID;
                        }

                        $items_ids_str = join(',', $items_ids);
                        $data_cms = Content::query()
                            ->where("ID in ({$items_ids_str})")
                            ->execute();

                        $dept_data['cms'] = $this->getDataCms($data_cms,$lang_id);
                    }
                }
                $dept_data["settings"]=[];
                $depts_arr[] = $dept_data;
            }

            $result['status']  = $this->getStatus(200, 'Depts loaded successfully');
            $result['content'] = $depts_arr;
        }
        else
        {
            $result['status']  = $this->getStatus(204, 'Error loading depts');
        }

        return $result;
    }

    private function getDataCmsKeyValuesMobile($item,$lang_id) {
        $keyvalues = \DataKeyvalueUserdata::find(["Item_ID={$item->ID}"]);
        $response = [];
        if (count($keyvalues) < 1) {
            return $response;
        }
        foreach ($keyvalues as $value) {
            if($value->DataKeyvalue->DataKeyvalueGroup->Is_Dept == 2) {
                continue;
            }
            $title = $value->Title;
            $des = $value->Des;
            // modification to return this element as array not object --ashraf
            $kv_value = array(
                'value_type' => 'normal',
                'value_string' => $value->Value
            );
            if($lang_id!=0 || $lang_id!= null){
                if($value->DataKeyvalue->has_langs == 1) {
                    foreach ($value->getLangs(["lang_id={$lang_id}"]) as $kv_lang){
                        $title = $kv_lang->title?:"";
                        $des = $kv_lang->des?:"";
                        $kv_value =array(
                            'value_type' => 'normal',
                            'value_string' => $kv_lang->value
                        );

                    }
                }
            }
            $value_multi = "";
            if($value->DataKeyvalue->CKV_ID == 1 ||$value->DataKeyvalue->CKV_ID == 3 ||$value->DataKeyvalue->CKV_ID == 8){
                if($value->DataKeyvalue->CKV_ID == 3) {
                    $values_array = explode(",",$value->Value);
                    foreach ($values_array as $value_array) {
                        $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value_array}"]);
                        $value_option["value_id"]=$option_lang->Option_ID;
                        $value_option["value_title"]=$option_lang->Title;
                        if($lang_id!=0 || $lang_id!= null){
                            $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value_array} AND Lang_ID={$lang_id}"]);
                            if($option_lang){
                                $value_option["value_id"] = $option_lang->Option_ID;
                                $value_option["value_title"] = $option_lang->Title;
                            }
                        }
                        $value_multi= $value_option;
                    }

                }
                elseif($value->DataKeyvalue->CKV_ID == 8) {
                    $values_array= explode(",",$value->Value);
                    foreach ($values_array as $value_array){
                        $data_keyvalue_entity = DataKeyvalueEntity::findFirst(["dkv_id={$value->DKV_ID}"]);
                        $model_name= $data_keyvalue_entity->SetupEntities->model_name;
                        $model= new $model_name();
                        $option = $model->findFirst(["id={$value_array}"]);
                        $value_option["value_id"] = $option->id;
                        $value_option["value_title"] = $option->name;
                        $metadata = $model->getModelsMetaData();
                        $attributes = $metadata->getAttributes($model);
                        foreach($attributes as $k=>$v){
                            if (in_array($v,array('id','name'))) unset($attributes[$k]);
                        }
                        foreach ($attributes as $v){
                            $value_option[$v] = $option->{$v};
                        }
                        $value_multi = $value_option;
                    }
                }
                else {
                    $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value}"]);
                    $value_option["value_id"] = $option_lang->Option_ID;
                    $value_option["value_title"] = $option_lang->Title;
                    if($lang_id!=0 || $lang_id!= null){
                        $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value} AND Lang_ID={$lang_id}"]);
                        if($option_lang){
                            $value_option["value_id"] = $option_lang->Option_ID;
                            $value_option["value_title"] = $option_lang->Title;
                        }
                    }
                    $value_multi = $value_option;
                }
//                $kv_value =  $value_multi;
                $kv_value = array(
                    'value_type' => 'object',
                    'value_obj' => $value_multi
                );
            }
            if($value->DataKeyvalue->CKV_ID == 4) {
                $kv_value = array(
                    'value_type' => 'normal',
                    'value_string' => "http://penta-test.com/tanks_project/uploads/".$kv_value["value_title"]
                );
//                $kv_value["value_title"] = [];
            }
            $keyvalue_name = $value->DataKeyvalue->DataKeyvalueLang->Title;
            if($lang_id != 0 || $lang_id != null) {
                $keyvalue_name = $value->DataKeyvalue->getDataKeyvalueLang(["Lang_ID={$lang_id}"])->Title;
            }
            $kv = array(
                'id' => $value->ID,
                'parameter' => $value->DataKeyvalue->Paramter,
                'name' => $keyvalue_name,
                'value' => $kv_value,
                'dkv_id' => $value->DKV_ID,
                'title' => $title,
                'des' => $des,
//                'langs'=> $value_langs,
                'setting_id' => 3
            );
            $response[] = $kv;
        }
        return $response;
    }

    private function getDataCmsKeyValuesAttributesMobile($item,$lang_id) {
        $keyvalues = \DataKeyvalueUserdata::find(["Item_ID={$item->ID}"]);
        $response = [];
        if (count($keyvalues) < 1) {
            return $response;
        }
        foreach ($keyvalues as $value) {
            $check_maintenance= \DataKeyvalueDeptCms::findFirst(["dkv_id={$value->DKV_ID}"]);
            if(!$check_maintenance){
                continue;
            }
            if($check_maintenance->subject_to_maintenance==1){
                continue;
            }
            if($value->DataKeyvalue->DataKeyvalueGroup->Is_Dept!=2){
                continue;
            }
            $title = $value->Title;
            $des = $value->Des;
            $value_title = $value->Value;
            $check_lang = \DataKeyvalueUserdataLang::findFirst(["dkv_id={$value->DKV_ID} and lang_id={$lang_id}"]);
            if($check_lang){
                $value_title = $check_lang->value;
            }
            $kv_value = array(
                'value_type' => 'object',
                'value_obj' => [
                    'value_id' => $value->ID,
                    'value_title' => $value_title
                ]
            );
            //Check Keyvalue Type if select box return the title of the selected option
            $dkv_type = $value->DataKeyvalue->CoreKeyvalueType->ID;
            switch($dkv_type){
                case 1:
                    $value_title =\DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value} AND Lang_ID=1"])->Title?:"";
                    $kv_value = array(
                        'value_type' => 'object',
                        'value_obj' => [
                            'value_id' => $value->ID,
                            'value_title' => $value_title
                        ]
                    );
                    break;
            }
            if($lang_id != 0 || $lang_id != null){
                if($value->DataKeyvalue->has_langs == 1){
                    foreach ($value->getLangs(["lang_id = {$lang_id}"]) as $kv_lang){
                        $title = $kv_lang->title?:"";
                        $des = $kv_lang->des?:"";
//                        $name = $kv_lang->title?:"";
                        $kv_value = array(
                            'value_type' => 'normal',
                            'value_string' => $kv_lang->value
                        );
                    }
                }
            }
            $value_multi = array();

            if($value->DataKeyvalue->CKV_ID == 1 || $value->DataKeyvalue->CKV_ID == 3 || $value->DataKeyvalue->CKV_ID == 8){
                if($value->DataKeyvalue->CKV_ID == 3) {
                    $values_array= explode(",",$value->Value);
                    foreach ($values_array as $value_array){
                        $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value_array}"]);
                        $value_option["value_id"]=$option_lang->Option_ID;
                        $value_option["value_title"]= $option_lang->Title;
                        if($lang_id!=0 || $lang_id!= null){
                            $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value_array} AND Lang_ID={$lang_id}"]);
                            if($option_lang){
                                $value_option["value_id"] = $option_lang->Option_ID;
                                $value_option["value_title"] = $option_lang->Title;
                            }
                        }
                        $value_multi = $value_option;
                    }
                }
                elseif($value->DataKeyvalue->CKV_ID == 8) {
                    $values_array= explode(",",$value->Value);
                    foreach ($values_array as $value_array){
                        $data_keyvalue_entity = DataKeyvalueEntity::findFirst(["dkv_id={$value->DKV_ID}"]);
                        $model_name= $data_keyvalue_entity->SetupEntities->model_name;
                        $model= new $model_name();
                        $option = $model->findFirst(["id={$value_array}"]);
                        $value_option["value_id"]=$option->id;
                        $value_option["value_title"] = $option->name;
                        $metadata = $model->getModelsMetaData();
                        $attributes = $metadata->getAttributes($model);
                        foreach($attributes as $k=>$v){
                            if (in_array($v,array('id','name'))) unset($attributes[$k]);
                        }
                        foreach ($attributes as $v){
                            $value_option[$v]=$option->{$v};
                        }
                        $value_multi= $value_option;
                    }
                }
                else {
                    $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value}"]);
                    $value_option["value_id"]=$option_lang->Option_ID;
                    $value_option["value_title"]= $option_lang->Title;
                    if($lang_id!=0 || $lang_id!= null){
                        $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$value->Value} AND Lang_ID={$lang_id}"]);
                        if($option_lang){
                            $value_option["value_id"]=$option_lang->Option_ID;
                            $value_option["value_title"] = $option_lang->Title;
                        }
                    }
                    $value_multi= $value_option;
                }
                $kv_value =  array(
                    'value_type' => 'object',
                    'value_obj' => $value_multi
                );
            }
            $keyvalue_name = $value->DataKeyvalue->DataKeyvalueLang->Title;
            if($lang_id != 0 || $lang_id != null) {
                $keyvalue_name = $value->DataKeyvalue->getDataKeyvalueLang(["Lang_ID={$lang_id}"])->Title;
            }
            $kv = array(
                'id' => $value->ID,
                "name" => $keyvalue_name,
                'parameter' => $value->DataKeyvalue->Paramter,
                'dkv_id' => $value->DKV_ID,
                'title' => $title,
                'des' => $des,
//                'langs'=> $value_langs,
                'setting_id' => 3,
                'value' => $kv_value

            );
            $response[] = $kv;
        }
        return $response;
    }

    private function getDataCmsExtraFieldsMobile($item,$lang_id=null) {
        // TODO the extra fields should be returned based on the module type
        $extra_fields_arr = [];
        $extra_fields = ProductExtraFields::findFirst([
            'item_id = {item_id}',
            'bind' => [
                'item_id' => $item->ID
            ]
        ]);
        if($extra_fields) {
            foreach($extra_fields as $key=>$value) {
//                $extra_fields_model['id'] = '';
//                $extra_fields_model['dkv_id'] = '';
//                $extra_fields_model['title'] = '';
//                $extra_fields_model['des'] = '';
//                $extra_fields_model['setting_id'] = '';
                if($key !== 'module_id' && $key !== 'item_id') {
                    $extra_fields_model['parameter'] = $key;
                    if($lang_id == null || $lang_id == 2) {
                        $extra_fields_model['name'] = $key;
                    } elseif($lang_id == 1) {
                        $extra_fields_model['name'] = $key;
                    }
                    $extra_fields_model['value'] = array(
                        'value_type' => 'normal',
                        'value_string' => $value

                    );
                    $extra_fields_arr[] = $extra_fields_model;
                }
            }
        }
        return $extra_fields_arr;
    }

    private function structureMoreMobile($item,$lang_id) {
        $more = [];
        // keyvalues
        $kv_model['key'] = 'keyvalue';
        $kv_model['group_name'] = 'Key Value Fields';
        $kv_model['value'] = $this->getDataCmsKeyValuesMobile($item,$lang_id);

        // extra fields
        $extra_model['key']            = 'extra';
        $extra_model['group_name']     = 'Extra Fields';
        $extra_model['value'] = $this->getDataCmsExtraFieldsMobile($item,$lang_id);

        //category attbutes
        $att_model['key']        = 'attribute';
        $att_model['group_name'] = 'Attributes Fields';
        $att_model['value']      = $this->getDataCmsKeyValuesAttributesMobile($item,$lang_id);

        // get categories array
        $categories_model['key'] = 'categories';
        $categories_model['group_name'] = 'Product Categories';
        $categories_model['value'] = (count($item->categories))?$this->getCategoriesTree($item->categories[0]):[];

        // category id
        $category_id_model['key']        = 'category_id';
        $category_id_model['group_name'] = 'Product Category ID';
        $category_id_model['value'][]    =
            [
                'id' => '',
                'parameter' => '',
                'name' => '',
                'dkv_id' => '',
                'title' => '',
                'des' => '',
                'setting_id' => '',
                'value' => array(
                    'value_type' => 'normal',
                    'value_string' => (count($item->categories))?$item->categories[0]->ID:''
                )
            ];
        // manufacturer data
        $manufacturer_model['key']        = 'manufacturer_data';
        $manufacturer_model['group_name'] = 'Manufacturer Data';

        (count($item->manufacturers))? $manufacturer_model['value'] []   = [
            'value' => array(
                'value_type' => 'object',
                'value_obj' => array(
                    'value_id' => $item->manufacturers[0]->ID,
                    'value_title' => $item->manufacturers[0]->Title
                )
            )
        ]: $manufacturer_model['value']   = [];
        // type
        $type_model['key']        = 'item_type';
        $type_model['group_name'] = 'Item Type';
        $type_model['value'][]    = [
            'id' => '',
            'parameter' => '',
            'name' => '',
            'dkv_id' => '',
            'title' => '',
            'des' => '',
            'setting_id' => '',
            'value' => array(
                'value_type' => 'normal',
                'value_string' => '1'
            )
        ];

        // discount data
        $discount_percentage_model['key']        = 'discount_percentage';
        $discount_percentage_model['group_name'] = 'Product Discount Percentage';
        $discount_percentage_model['value'][]    = [
            'id' => '',
            'parameter' => '',
            'name' => '',
            'dkv_id' => '',
            'title' => '',
            'des' => '',
            'setting_id' => '',
            'value' => array(
                'value_type' => 'normal' ,
                'value_string' => count($item->discounts)?$item->discounts[0]->percentage:''
            )
        ];
        // tags
        $tags_model['key']        = 'tags';
        $tags_model['group_name'] = 'Tags';
//        var_dump($this->getProductTags($item));exit;
        if(count($this->getProductTags($item)) < 1) {
            $tags_model['value'] = array();
        } else {
            $tags_model['value'][]    = [
                'value' => array(
                    'value_type' => 'array',
                    'value_array' => $this->getProductTags($item),
                )
            ];
        }
        // departments
        $depts_model['key']        = 'departments';
        $depts_model['group_name'] = 'Departments';
        $depts_model['value'][]    = [

            'value' => [['value_id' => '', 'value_title' => $this->getItemDepts($item)]]
        ];

        $more[] = $kv_model;
        $more[] = $extra_model;
        $more[] = $att_model;
        $more[] = $categories_model;
        $more[] = $category_id_model;
        $more[] = $discount_percentage_model;
        $more[] = $type_model;
        $more[] = $manufacturer_model;
        $more[] = $tags_model;
//        $more[] = $depts_model;

        return $more;
    }


    public function add_notification($request){
        $notification = new GeneralNotifications();
        $notification->type_id=1;
        $notification->user_id= $request->user_id;
        $notification->module_id=8;
        $notification->application_id= 1;
        $notification->time = time();
        $notification->external_type_id=$request->external_type;
        $notification->show_type_id = 1;//now
        $notification->content = $request->content;
        $notification->is_read = 0;
        $notification->url = "";
        $notification->order_id= $request->order_id;
        $notification->save();
        $response['status'] = $this->getStatus(200, 'Notified Sucessfully');
        $response['content'] = [];
        return $response;
    }

    public function read_notification($request){
        $notification = GeneralNotifications::findFirst($request->id);
        if($notification){
            $notification->read_by_user = 1;
        }
        $notification->save();
        $response['status'] = $this->getStatus(200, 'Notification Read Successfully');
        $response['content'] = [];
        return $response;
    }

    public function get_new_notifications($request){
        $notifications = GeneralNotifications::find(["user_id={$request->user_id} AND read_by_user=0 AND external_type_id=2"])->toArray();
        $response['status'] = $this->getStatus(200, 'Notification Retrieved Successfully');
        $response['content'] = [$notifications];
        return $response;
    }


}