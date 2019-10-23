<?php
namespace Vokuro\Pentavalue;


use Illuminate\Contracts\Console\Application;
use Models\DataCmsSavedFilter;

use Models\Content;
use Phalcon\Mvc\User\Component;


use Phalcon\Security\Random;
use Vokuro\ApiFactory;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderStatuses;

class CmsSearch extends Component
{

    private $is_mobile = 0;

    public function __construct()
    {
        if(isset($_GET["mobile"])){
            $this->is_mobile = 1;
        }
    }
    public function search()
    {
        $search_param = json_decode(file_get_contents("php://input"),true);
        if (empty($search_param)) {
            $application_id = $this->session->get('auth-identity')['Application_ID'];
            //if search parameters are empty, return all data_cms in this application
            $all_content = Content::find(["Application_ID={$application_id}"]);
            $items = [];
            foreach ($all_content as $item){
                $items[] = $item;
            }
            return $this->apiFactory->structureCMSResponse(200,$items);
        }
        $action = $search_param['action'];

        //save action
        // $this->saveFilter(file_get_contents("php://input"),$search_param['application_id'],$this->session->get('auth-identity')['id'],$search_param['action']);
        return $this->switchSearchAction($action,$search_param);

    }

    public function switchSearchAction($action,$search_param){
        $lang_id= $search_param['lang_id']?:1;
        switch ($action){
            case "content_search":
                $items_array =$this->content_search($search_param);
                $departments = isset($search_param['departments'])?$search_param['departments']:null;
                return $this->apiFactory->structureCMSResponse($items_array["status"],$items_array["items"],$items_array["robo_version"],$items_array["lang_id"],$items_array["total"], $departments);
                break;
            case "allCmsFollowed":
                $items =$this->allCmsFollowed($search_param);
                return $this->apiFactory->structureCMSResponse(200,$items,null,$lang_id);
                break;
            case "allCmsFavorite":
                $items =$this->allCmsFavorite($search_param);
                return $this->apiFactory->structureCMSResponse(200,$items,null,$lang_id);
                break;
            case "allCmsGoing":
                $items =$this->allCmsGoing($search_param);
                return $this->apiFactory->structureCMSResponse(200,$items,null,$lang_id);
                break;
            case "savedFilters":
                $items =$this->getSavedFilters($search_param);
                return $this->apiFactory->structureFilterResponse(200,$items);
                break;
            case "viewSavedFilter":
                return $this->viewSavedFilter($search_param);
                break;
            case "usersFollow":
                $items =$this->allUsersFollow($search_param);
                return $this->apiFactory->structureFilterResponse(200,$items);
                break;
            case "depts_search":
                $depts = $this->getDepts($search_param);
                $lang_id=null;
                if(isset($search_param["lang_id"])){
                    $lang_id=$search_param["lang_id"];
                }
                if($this->is_mobile==1){
                    return $this->apiFactory->structureDeptsResponseMobile($depts,$lang_id);
                }else{
                    return $this->apiFactory->structureDeptsResponse($depts,$lang_id);
                }
                break;
            case "depts_with_items":
                $lang_id=null;
                if(isset($search_param["lang_id"])){
                    $lang_id=$search_param["lang_id"];
                }
                $depts = $this->getDepts($search_param);
                return $this->apiFactory->structureDeptsResponse($depts, $lang_id,true);
                break;
            case "static_loc":
                $localization = $this->getStaticTrans($search_param);
                return $this->apiFactory->structureGeneralResponse($localization);
                break;
            case "compare_cms":
                $compared_array = $this->compareSearch($search_param);
                return $this->apiFactory->structureCompareResponse($compared_array,$search_param['lang_id']);
                break;
            case 'depts_tree':
                $depts_tree = $this->getDeptsTree($search_param);
                return $this->apiFactory->returnDeptsTree($depts_tree);
                break;
            case 'best_selling':
                $lang_id = (isset($search_param['lang_id']))?$search_param['lang_id']:2;
                $best_selling = $this->getBestSellingProducts($search_param);
                return $this->apiFactory->returnBestSellingProducts($best_selling, $lang_id);
                break;
        }
    }

    public function getBestSellingProducts($search_param)
    {
        $valid_statuses = [
            OrderStatuses::paymentConfirmed(),
            OrderStatuses::pending(),
            OrderStatuses::shipping(),
            OrderStatuses::delivered(),
            OrderStatuses::inProgress()
        ];

        $orders_products = [];

        if(isset($search_param['application_id']) && isset($search_param['module_id']))
        {
            $orders = Orders::query()
                ->andWhere('application_id = '.$search_param['application_id'])
                ->andWhere('module_id = '.$search_param['module_id'])
                ->inWhere('status', $valid_statuses)
                ->execute();

            foreach($orders as $order)
            {
                $items = $order->getItems('item_type_id = 1');

                foreach($items as $item)
                {
                    if(!array_key_exists($item->item_id, $orders_products))
                    {
                        $orders_products[$item->item_id] = $item->count;
                    }
                    else
                    {
                        $orders_products[$item->item_id] = $orders_products[$item->item_id] + $item->count;
                    }
                }
            }
        }

        arsort($orders_products);

        $sorted_products_ids = [];

        foreach($orders_products as $product_id=>$count)
        {
            $sorted_products_ids[] = $product_id;
        }

        $sorted_products = [];

        foreach($sorted_products_ids as $p_id)
        {
            $product = Content::findFirst($p_id);
            if($product)
            {
                $sorted_products[] = $product;
            }
        }

      return $sorted_products;
    }

    public function getDeptsTree($search_param)
    {
        $lang_id = (isset($search_param['lang_id']))?$search_param['lang_id']:2;
        $parent_depts = null;
        $depts_tree   = [];
        if(isset($search_param['core_dept_id']) && isset($search_param['application_id']) && isset($search_param['module_id']))
        {
            $parent_depts = \DataCmsDeptsRel::find([
                'Core_Depts_ID = {core_dept} and Application_ID = {app_id} and Module_ID = {module} and Parent_Depts_ID = 0',
                'bind' => [
                    'core_dept' => $search_param['core_dept_id'],
                    'app_id'    => $search_param['application_id'],
                    'module'    => $search_param['module_id'],
                ],
                'order' => 'Orders asc'
            ]);

            $dept_search = $this->modelsManager->createBuilder()->from("DataCmsDeptsRel")
                ->notInWhere("DataCmsDeptsRel.ID", [80,81,82,83])
            ->andWhere("DataCmsDeptsRel.Module_ID=8")
            ->andWhere("DataCmsDeptsRel.Core_Depts_ID=4");
            $parent_depts = $dept_search->getQuery()->execute();



            foreach($parent_depts as $parent)
            {

                $children_arr = [];
                $children = \DataCmsDeptsRel::find([
                    'Core_Depts_ID = {core_dept} and Application_ID = {app_id} and Module_ID = {module} and Parent_Depts_ID = {parent}',
                    'bind' => [
                        'core_dept' => $search_param['core_dept_id'],
                        'app_id'    => $search_param['application_id'],
                        'module'    => $search_param['module_id'],
                        'parent'    => $parent->ID
                    ],
                    'order' => 'Orders asc'
                ]);

                foreach($children as $child)
                {
                    $children_arr[] = [
                        'childe_id'=>$child->ID,
                        'child_name'=>($child->getDeptRelLang('lang_id = '.$lang_id))?
                            $child->getDeptRelLang('lang_id = '.$lang_id)->title:$child->Title
                    ];
                }

                $depts_tree[] = [
                    'parent_id'=>$parent->ID,
                    'parent_name'=>($parent->getDeptRelLang('lang_id = '.$lang_id))?
                        $parent->getDeptRelLang('lang_id = '.$lang_id)->title:$parent->Title,
                    'children'=>$children_arr,
                    'order'=>$parent->Orders
                ];
            }
        }
        usort($depts_tree, function ($a, $b) {
            if($a['order'] - $b['order'] >= 0){
                return 1;
            }
            return -1;
            // return $a['Distance'] - $b['Distance'];
        });
        return $depts_tree;
    }



    public function getDepts($search_param)
    {
        $result = false;

        if(isset($search_param['core_dept_id']) && isset($search_param['application_id']) && isset($search_param['module_id']))
        {
            if(isset($search_param['dept_id'])) {
                $result = \DataCmsDeptsRel::find([
                    'ID = {dept_id} and Core_Depts_ID = {core_dept_id} and Application_ID = {app_id} and Module_ID = {module}',
                    'bind' => [
                        'core_dept_id' => $search_param['core_dept_id'],
                        'app_id' => $search_param['application_id'],
                        'module' => $search_param['module_id'],
                        'dept_id' => $search_param['dept_id'],
                    ],
                    'order' => 'Orders asc'
                ]);


            }
            elseif(isset($search_param['dept_name']))
            {
                $result = \DataCmsDeptsRel::find([
                    'Title like {dept_name} and Core_Depts_ID = {core_dept_id} and Application_ID = {app_id} and Module_ID = {module}',
                    'bind' => [
                        'core_dept_id' => $search_param['core_dept_id'],
                        'app_id'       => $search_param['application_id'],
                        'module'       => $search_param['module_id'],
                        'dept_name'    => '%'.$search_param['dept_name'].'%',
                    ],
                    'order' => 'Orders asc'
                ]);
                
                Helpers::saveSearchKeyword($search_param['dept_name']);
            }
            else{
               if($search_param['core_dept_id']==5){
                   $result = \DataCmsDeptsRel::find([
                       'Core_Depts_ID = {core_dept_id} and Application_ID = {app_id} and Module_ID = {module}',
                       'bind' => [
                           'core_dept_id' => $search_param['core_dept_id'],
                           'app_id' => $search_param['application_id'],
                           'module' => $search_param['module_id'],
                       ],
                       'order' => 'Orders asc'
                   ]);
               }else{
                   $dept_search = $this->modelsManager->createBuilder()->from("DataCmsDeptsRel")
                       ->inWhere("DataCmsDeptsRel.ID", [77,78,79,74,75,76]);
                   $result = $dept_search->getQuery()->execute();
               }



            }


        }

        return $result;
    }

    public function content_search($search_param){

        $content_search = $this->modelsManager->createBuilder()->from("Models\Content")->andWhere("Models\Content.Application_ID ={$search_param['application_id']}");

        if(isset($search_param['id'])){
            $content_search->andWhere("Models\Content.ID ={$search_param['id']}");
        }
        $content_search->leftJoin("DataCmsDeptsRelItem","DataCmsDeptsRelItem.Item_ID = Models\Content.ID");
        $content_search->leftJoin("DataKeyvalueUserdata","DataKeyvalueUserdata.Item_ID = Models\Content.ID");
        $content_search->leftJoin("DataKeyvalueUserdataLang","DataKeyvalueUserdataLang.item_id = Models\Content.ID");
        $content_search->leftJoin("Vokuro\Models\ProductExtraFields","Vokuro\Models\ProductExtraFields.item_id = Models\Content.ID");
        if(isset($search_param['lang_id'])){
            if(!$this->isDefaultAppLang($search_param['application_id'],$search_param['lang_id'])){
                $content_search->innerJoin("DataCmsLang","DataCmsLang.data_cms_id = Models\Content.ID");
                $content_search->andWhere("DataCmsLang.lang_id={$search_param['lang_id']}");
                if(isset($search_param['name'])){
                    $content_search->andWhere("DataCmsLang.title like '%{$search_param['name']}%'");
                }
                if(isset($search_param['description'])){
                    $content_search->andWhere("DataCmsLang.des like '%{$search_param['des']}%'");
                }
                if(isset($search_param['content'])){
                    $content_search->andWhere("DataCmsLang.content like '%{$search_param['content']}%'");
                }
                if(isset($search_param['more'])){
                    foreach ($search_param['more'] as $k=>$v){
                        if(isset($v['type']) && $v['type']=="multi"){
                            $alias = "alias_multi".$k;
                            $content_search->innerJoin("DataKeyvalueUserdata","DataKeyvalueUserdata.Item_ID = {$alias}.Item_ID","{$alias}");
                            $content_search->where("{$alias}.DKV_ID={$v['dkv_id']}");
                            $content_search->andWhere("find_in_set({$v['value']},{$alias}.Value)");
                        }else{
                            $alias = "alias".$k;
                            $content_search->innerJoin("DataKeyvalueUserdataLang","DataKeyvalueUserdataLang.item)id = {$alias}.item_id","{$alias}");
                            $content_search->where("{$alias}.dkv_id={$v['dkv_id']}");
                            $content_search->andWhere("{$alias}.value='{$v['value']}'");
                            $content_search->andWhere("{$alias}.lang_id='{$search_param['lang_id']}'");
                        }

                    }
                }

            }else{
                if(isset($search_param['name'])){
                    $content_search->andWhere("Models\Content.Title like '%{$search_param['name']}%'");
                    Helpers::saveSearchKeyword($search_param['name']);
                }
                if(isset($search_param['description'])){
                    $content_search->andWhere("Models\Content.Des like '%{$search_param['description']}%'");
                }
                if(isset($search_param['content'])){
                    $content_search->andWhere("Models\Content.Content like '%{$search_param['content']}%'");
                }
                if(isset($search_param['more'])){
                    foreach ($search_param['more'] as $k=>$v){
                        if(isset($v['type']) && $v['type']=="multi"){
                            $alias = "alias".$k;
                            $alias_multi = "alias_multi".$k;
                            $content_search->innerJoin("DataKeyvalueUserdata","DataKeyvalueUserdata.Item_ID = {$alias}.Item_ID","{$alias}");
                            $content_search->where("{$alias}.DKV_ID={$v['dkv_id']}");
                            $content_search->innerJoin("Models\DataKeyvalueUserdataMultiValue","{$alias_multi}.value_id = {$alias}.ID","{$alias_multi}");
                            $content_search->andWhere("{$alias_multi}.option_id='{$v['value']}'");
                        }else{
                            $alias = "alias".$k;
                            $content_search->innerJoin("DataKeyvalueUserdata","DataKeyvalueUserdata.Item_ID = {$alias}.Item_ID","{$alias}");
                            $content_search->where("{$alias}.DKV_ID={$v['dkv_id']}");
                            $content_search->andWhere("{$alias}.Value='{$v['value']}'");
                        }

                    }
                }
            }
        }
//        if(isset($search_param['langs'])){
//            $content_search->innerJoin("DataCmsLang","DataCmsLang.data_cms_id = Models\Content.ID");
//            $content_search->andWhere("DataCmsLang.lang_id={$search_param['langs']['lang_id']}");
//            if(isset($search_param['langs']['title'])){
//                $content_search->andWhere("DataCmsLang.title like '%{$search_param['langs']['title']}%'");
//            }
//            if(isset($search_param['langs']['des'])){
//                $content_search->andWhere("DataCmsLang.des like '%{$search_param['langs']['des']}%'");
//            }
//            if(isset($search_param['langs']['content'])){
//                $content_search->andWhere("DataCmsLang.content like '%{$search_param['langs']['content']}%'");
//            }
//
//        }

        //$content_search->leftJoin("DataKeyvalueUserdataLang","DataKeyvalueUserdataLang.kv_userdata_id = DataKeyvalueUserdata.ID");
        // $content_search->leftJoin("DataCmsLang","DataCmsLang.data_cms_id = Models\Content.ID");
        if(isset($search_param['module_id'])){
            $content_search->andWhere("Models\Content.Module_ID= {$search_param['module_id']}");
        }

        if(isset($search_param['active'])){
            $content_search->andWhere("Models\Content.Active = {$search_param['active']}");
        }

        if (isset($search_param['date_from']) && isset($search_param['date_to'])) {
            if($search_param['date_from']==$search_param['date_to']){
                $date_from = strtotime($search_param['date_from']);
                $beginOfDay = strtotime("midnight", $date_from);
                $endOfDay   = strtotime("tomorrow", $beginOfDay) - 1;
                $content_search->betweenWhere("Models\Content.DateTime", $beginOfDay, $endOfDay);
            }else{
                $date_from = strtotime($search_param['date_from']);
                $date_to = strtotime($search_param['date_to']);
                $endOfDayTo   = strtotime("tomorrow", $date_to) - 1;
                $content_search->betweenWhere("Models\Content.DateTime", $date_from, $date_to);
            }

        }

        if(isset($search_param['departments']) && !empty($search_param['departments'])){
//            $depts=join("','", $search_param['departments']);
            $content_search->inWhere("DataCmsDeptsRelItem.Depts_ID", $search_param['departments']);
        }

        //Extra Fields
        if(isset($search_param['extra_fields']['price_from'])&& isset($search_param['extra_fields']['price_to'])){
            $content_search->betweenWhere("Vokuro\Models\ProductExtraFields.price", $search_param['extra_fields']['price_from'], $search_param['extra_fields']['price_to']);
        }

        //Manufacturers
        if(isset($search_param['manufacturer'])){
            $content_search->innerJoin("DataCmsDeptsRelItem","manufacturer.Item_ID = Models\Content.ID","manufacturer");
            $content_search->andWhere("manufacturer.Depts_ID={$search_param['manufacturer']}");
        }

        //tags

        if(isset($search_param['tags']) && !empty($search_param['tags'])){
            foreach ($search_param['tags'] as $k=>$value){
                $alias_tags_entitiy = "alias_tags_entitiy".$k;
                $alias_tags_tag = "alias_tags_tag".$k;
                $content_search->innerJoin("Models\EntityTags","{$alias_tags_entitiy}.item_id = Models\Content.ID","{$alias_tags_entitiy}");
                $content_search->innerJoin("Vokuro\Models\Tags","{$alias_tags_tag}.id={$alias_tags_entitiy}.tag_id","{$alias_tags_tag}");
//                $content_search->andWhere("{$alias_tags_entitiy}.tag_id={$value['id']}");
                $content_search->andWhere("{$alias_tags_tag}.name='{$value['tag']}'");
            }

        }

        //Most Selling

        if(isset($search_param['most_selling'])){
            $content_search->innerJoin("Vokuro\Models\TanksMostSellingProducts","Vokuro\Models\TanksMostSellingProducts.product_id = Models\Content.ID");

        }
        if(isset($search_param['offer_items'])){
            $content_search->notInWhere("Models\Content.ID",$search_param["offer_items"]);

        }


        $content_search->groupBy(array('Models\Content.ID'));

//        $count_result = clone $content_search;
//        //Get Count of All results
//        $count_result->columns(
//            [
//                "count_rows"=>"COUNT(Models\Content.ID)",
//            ]
//        );
//        $count = $count_result->getQuery()->execute();
//        print_r($count);exit;
//        $count_all= $count[0]->count_rows;
        $total_results = clone $content_search;
        $total_results->columns("COUNT(*) rowcount");
        if(isset($search_param['pagination'])){
            $numberPage= $search_param['pagination']['page'];
            $num_rec_per_page = $search_param['pagination']['num_rec'];
            $start_from = ($numberPage-1) * $num_rec_per_page;
            //echo($num_rec_per_page);exit;
            $content_search->limit($num_rec_per_page,$start_from);
        }
        //die(var_dump($content_search->getQuery()->getSql()));


        /** SORT PRODUCTS BY NAME OR CREATION_DATE **/
        if(isset($search_param['sort']) && isset($search_param['sort']['by']) && isset($search_param['sort']['type']))
        {
            switch($search_param['sort']['by'])
            {
                case "name":
                    $content_search->orderBy(Content::class.".Title {$search_param['sort']['type']}");
                    break;
                case "created_at":
                    $content_search->orderBy(Content::class.".DateTime {$search_param['sort']['type']}");
                    break;
                default:
                    $content_search->orderBy("Models\Content.ID DESC");
                    break;
            }
        }
        else
        {
            $content_search->orderBy("Models\Content.ID DESC");
        }

        $result = $content_search->getQuery()->execute();

        /** SORT PRODUCT BY PRICE **/
        if(isset($search_param['sort']) && isset($search_param['sort']['by']) && isset($search_param['sort']['type']))
        {
            switch($search_param['sort']['by'])
            {
                case "price":
                    $result = $this->sortProductsByPrice($result, $search_param['sort']['type']);
                    break;
                default:
                    $result = $result;
                    break;
            }
        }

        $status=200;
        if(count($result) == 0){
            $status = 204;
        }
        $items =[];
        foreach ($result as $item){
            $items[] = $item;
        }
        $lang_id = 0;
        if(isset($search_param['lang_id'])){
                $lang_id=$search_param['lang_id'];

        }

        $robo_version= 2;
        if(isset($search_param['robo_version'])){
            $robo_version=$search_param['robo_version'];
        }

        return [
            "items"=>$items,
            "status"=>$status,
            "robo_version" =>$robo_version,
            "lang_id" => $lang_id,
            "total"=>$total_results->getQuery()->execute()
        ];
    }

    private function sortProductsByPrice($products, $sort_type)
    {
        $products_prices = [];
        $sorted_products = [];

        foreach($products as $product)
        {
            $price = ($product->extraFields)?$product->extraFields->price:0;

            $products_prices[$price][] = $product;
        }

        switch($sort_type)
        {
            case 'asc':
                ksort($products_prices);
                break;
            case 'desc':
                krsort($products_prices);
                break;
            default:
                ksort($products_prices);
                break;
        }

        foreach($products_prices as $price=>$products)
        {
            foreach($products as $product)
            {
                $sorted_products[] = $product;
            }
        }

        return $sorted_products;
    }

    //All Data Cms Followed By Certain User
    public function allCmsFollowed($search_param){

        $content_search = $this->modelsManager->createBuilder()->from("Models\Content")
            ->andWhere("Models\Content.Application_ID ={$search_param['application_id']}");
        $content_search->rightJoin("Models\DataCmsUsersFollow","Models\DataCmsUsersFollow.data_cms_id = Models\Content.ID");
        $content_search->andWhere("Models\DataCmsUsersFollow.user_id ={$search_param['user_id']}");
        $content_search->andWhere("Models\DataCmsUsersFollow.type =1");
        $content_search->groupBy(array('Models\Content.ID'));
        //0var_dump($content_search->getQuery()->getSql());exit;
        $result = $content_search->getQuery()->execute();

        if(count($result) == 0){
            return [];
        }
        $items =[];
        foreach ($result as $item){
            $items[] = $item;
        }

        return $items;
    }

    //All Data Cms Favorite By Certain User
    public function allCmsFavorite($search_param){

        $content_search = $this->modelsManager->createBuilder()->from("Models\Content")
            ->andWhere("Models\Content.Application_ID ={$search_param['application_id']}");
        $content_search->rightJoin("Models\DataCmsUsersFollow","Models\DataCmsUsersFollow.data_cms_id = Models\Content.ID");
        $content_search->andWhere("Models\DataCmsUsersFollow.user_id ={$search_param['user_id']}");
        $content_search->andWhere("Models\DataCmsUsersFollow.type =2");
        $content_search->groupBy(array('Models\Content.ID'));
        //0var_dump($content_search->getQuery()->getSql());exit;
        $result = $content_search->getQuery()->execute();

        if(count($result) == 0){
            return [];
        }
        $items =[];
        foreach ($result as $item){
            $items[] = $item;
        }

        return $items;
    }

    //All Data Cms Going By Certain User
    public function allCmsGoing($search_param){

        $content_search = $this->modelsManager->createBuilder()->from("Models\Content")
            ->andWhere("Models\Content.Application_ID ={$search_param['application_id']}");
        $content_search->rightJoin("Models\DataCmsUsersFollow","Models\DataCmsUsersFollow.data_cms_id = Models\Content.ID");
        $content_search->andWhere("Models\DataCmsUsersFollow.user_id ={$search_param['user_id']}");
        $content_search->andWhere("Models\DataCmsUsersFollow.type =3");
        $content_search->groupBy(array('Models\Content.ID'));
        //0var_dump($content_search->getQuery()->getSql());exit;
        $result = $content_search->getQuery()->execute();

        if(count($result) == 0){
            return [];
        }
        $items =[];
        foreach ($result as $item){
            $items[] = $item->toArray()

            ;
        }

        return $items;
    }


    //Get all users followers for certain Data Cms
    public function allUsersFollow($search_param){

        $content_search = $this->modelsManager->createBuilder()->from("Models\DataCmsUsersFollow")
            ->andWhere("Models\DataCmsUsersFollow.data_cms_id ={$search_param['cms_id']}");
        $content_search->leftJoin("Models\UsersMobile","Models\DataCmsUsersFollow.user_id = Models\UsersMobile.ID");
        $content_search->andWhere("Models\DataCmsUsersFollow.type ={$search_param['follow_type']}");
        $content_search->groupBy(array('Models\DataCmsUsersFollow.ID'));
        //0var_dump($content_search->getQuery()->getSql());exit;
        $result = $content_search->getQuery()->execute();

        if(count($result) == 0){
            return [];
        }
        $items =[];
        foreach ($result as $item){
            if($item->UserInfo == false){
                continue;
            }
            $items[] = $item->UserInfo;


        }

        return $items;
    }

    //Save Filter
    public function saveFilter($filter,$application_id,$user_id,$action){
        $filter = new DataCmsSavedFilter(
            [
                "filter"=>$filter,
                "application_id"=>$application_id,
                "user_id"=>$user_id,
                "action"=>$action
            ]
        );
        $filter->save();
        return $filter;
    }
    //get saved filters
    public function getSavedFilters($search_param){
        $content_search = $this->modelsManager->createBuilder()->from("Models\DataCmsSavedFilter")
            ->andWhere("Models\DataCmsSavedFilter.application_id ={$search_param['application_id']}");
        if(isset($search_param['saved_filters']['user_id'])){
            $content_search->andWhere("Models\DataCmsSavedFilter.user_id ={$search_param['saved_filters']['user_id']}");
        }
        //$content_search->groupBy(array('Models\Content.ID'));
        //0var_dump($content_search->getQuery()->getSql());exit;
        $result = $content_search->getQuery()->execute();

        if(count($result) == 0){
            return [];
        }
        $items =[];
        foreach ($result as $item){
            $items[] = $item;
        }

        return $items;
    }
    //get saved filters
    public function viewSavedFilter($search_param){
        $content_search = $this->modelsManager->createBuilder()->from("Models\DataCmsSavedFilter")
            ->andWhere("Models\DataCmsSavedFilter.id ={$search_param['saved_filters']['id']}");
        //$content_search->groupBy(array('Models\Content.ID'));
        //0var_dump($content_search->getQuery()->getSql());exit;
        $result = $content_search->getQuery()->execute();

        if(count($result) == 0){
            return [];
        }
        $items =[];
        foreach ($result as $item){
            $search_param = json_decode($item->filter,true);
            $action= $search_param['action'];
            return $this->switchSearchAction($action,$search_param);
        }

    }

    public function getStaticTrans($search_param){
        $translations = \CpSystemTranslation::find(["lang_id={$search_param['lang_id']}"])->toArray();
        return $translations;
    }
    public function compareSearch($search_param){
        $content =[];
        foreach ($search_param["compare"] as $cms_id){
            $content_search = Content::findFirst(["ID={$cms_id}"]);
            $content[]=$content_search;
        }
        return $content;

    }

    public function isDefaultAppLang($app_id,$lang_id){
        $check = \ApplicationCmsLang::findFirst(["application_id={$app_id} and lang_id={$lang_id} and is_default=1"]);
        if(!$check){
            //echo "adsadasdd";die;
            return false;
        }
        return true;
    }


}



