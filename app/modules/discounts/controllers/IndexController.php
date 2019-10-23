<?php
namespace Vokuro\Discounts\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\Discounts\Models\DiscountRelItems;
use Vokuro\Discounts\Models\Discounts;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Offers\Models\OfferRegions;
use Vokuro\Offers\Models\OfferRelItems;
use Vokuro\Offers\Models\OfferRelTypes;
use Vokuro\Offers\Models\Offers;
use Phalcon\Security;
use Phalcon\Security\Random;

class IndexController extends ControllerBase
{
    public function indexAction(){
        $discounts = Discounts::find();
        $this->view->discounts = $discounts;
    }

    public function newAction($discount_id=null){
        $this->view->create = 1;
        if($discount_id!=null){
            $this->view->create = 0;
            $discount = Discounts::findFirst(["id={$discount_id}"]);
            $this->view->discount = $discount;

        }
    }

    public function addProuctToDiscountAction($discount_id){
        if(isset($_REQUEST["productsArray"])){
            foreach ($_REQUEST["productsArray"] as $value){
                $discount_rel_items = DiscountRelItems::findFirst(["discount_id={$discount_id} and data_cms_id={$value}"]);
                if($discount_rel_items){
                    continue;
                }
                $discount_rel_items = new DiscountRelItems();
                $discount_rel_items->discount_id = $discount_id;
                $discount_rel_items->data_cms_id = $value;
                $discount_rel_items->created_at=time();
                $discount_rel_items->updated_at=time();
                $discount_rel_items->save();
            }
            return "Done";
        }else{
            return "Failed";
        }



    }

    public function viewAction($discount_id){
        $this->view->create = 0;
        $discount = Discounts::findFirst(["id={$discount_id}"]);
        $this->view->discount = $discount;
        //get products
        $search_param["application_id"]=1;
        $search_param["module_id"]=8;
        $products = $this->CmsSearch->switchSearchAction("content_search",$search_param);
        $this->view->products = $products;
        //get discount products
        $discount_items = DiscountRelItems::find("discount_id={$discount_id}");
        $this->view->discount_items= $discount_items;
    }

    public function editAction($discount_id){
        $this->view->create = 0;
        $discount = Discounts::findFirst(["id={$discount_id}"]);
        $this->view->discount = $discount;
        //get products
        $search_param["application_id"]=1;
        $search_param["module_id"]=8;
        $products = $this->CmsSearch->switchSearchAction("content_search",$search_param);
        $this->view->products = $products;
        //get discount products
        $discount_items = DiscountRelItems::find("discount_id={$discount_id}");
        $this->view->discount_items= $discount_items;
    }

    public function deleteFromDiscountAction($discount_rel_id){
        $discount_rel_item= DiscountRelItems::findFirst(["id={$discount_rel_id}"]);
        if(!$discount_rel_item){
            return "failed";
        }else{
            $discount_rel_item->delete();
            return "Item Deleted";
        }
    }
    public function createAction()
    {
        if ($this->request->isPost()) {
            $discount_name = $this->request->getPost("discount_name");
            $discount_percentage = $this->request->getPost("discount_percentage");
            $discount_copoun_code = $this->request->getPost("discount_copoun_code");
            $discount_start_date = strtotime($this->request->getPost("discount_start_date"));
            $discount_end_date = strtotime($this->request->getPost("discount_end_date"));
            $discount = new Discounts();
            $discount->name=$discount_name;
            $discount->percentage=$discount_percentage;
            $discount->coupon=$discount_copoun_code;
            $discount->start_date = $discount_start_date;
            $discount->end_date = $discount_end_date;
            $discount->created_at = time();
            $discount->updated_at = time();
            if(!$discount->save()){
                foreach ($discount->getMessages() as $msg){
                    $this->flashSession->error($msg);
                }
            }
            $this->flashSession->success("Discount Created");
            return $this->response->redirect("discounts_module/index/new/{$discount->id}");

        }
    }

    public function saveAction()
    {
        if ($this->request->isPost()) {
            $discount_id=$this->request->getPost("discount_id");
            $discount_name = $this->request->getPost("discount_name");
            $discount_percentage = $this->request->getPost("discount_percentage");
            $discount_copoun_code = $this->request->getPost("discount_copoun_code");
            $discount_start_date = strtotime($this->request->getPost("discount_start_date"));
            $discount_end_date = strtotime($this->request->getPost("discount_end_date"));
            $discount = Discounts::findFirst(["id={$discount_id}"]);
            if(!$discount){
                return $this->response->redirect("discounts_module/index/index");
            }
            $discount->name=$discount_name;
            $discount->percentage=$discount_percentage;
            $discount->coupon=$discount_copoun_code;
            $discount->start_date = $discount_start_date;
            $discount->end_date = $discount_end_date;
            $discount->updated_at = time();
            if(!$discount->save()){
                foreach ($discount->getMessages() as $msg){
                    $this->flashSession->error($msg);
                }
            }
            $this->flashSession->success("Discount Saved");
            return $this->response->redirect("discounts_module/index/edit/{$discount->id}");

        }
    }

    public function deleteAction($discount_id){
        $discount = Discounts::findFirst(["id={$discount_id}"]);
        if($discount){
            $discount->delete();
            $discount_rel_items= DiscountRelItems::find(["discount_id={$discount_id}"]);
            foreach ($discount_rel_items as $item){
                $item->delete();
            }
            $this->flashSession->success("Discount Deleted");
            return $this->response->redirect("discounts_module/index/index");
        }else{
            return $this->response->redirect("discounts_module/index/index");
        }
    }
    public function delete_discountsAction(){
        $discounts = $this->request->getPost("discounts");
        foreach ($discounts as $discount_id){
            $discount = Discounts::findFirst(["id={$discount_id}"]);
            if($discount){
                $discount->delete();
                $discount_rel_items= DiscountRelItems::find(["discount_id={$discount_id}"]);
                foreach ($discount_rel_items as $item){
                    $item->delete();
                }
                $this->flashSession->success("Discount Deleted");
                return $this->response->redirect("discounts_module/index/index");
            }
        }
    }

    public function delete_discount_productsAction(){
        $discount_products = $this->request->getPost("discount_products");
        $discount_id = $this->request->getPost("discount_id");
        foreach ($discount_products as $data_cms_id){
            $discount_rel_item= DiscountRelItems::findFirst(["discount_id={$discount_id} and data_cms_id={$data_cms_id}"]);
            if(!$discount_rel_item){

            }else{
                $discount_rel_item->delete();

            }
        }
    }


    public function discounts_tableAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $filter["discount_filter_name"]="";
        $filter["discount_filter_percentage"]="";
        $filter["discount_filter_coupon"]="";
        $filter["discount_filter_start_date"]="";
        $filter["discount_filter_end_date"]="";
        if($this->request->getQuery("page")){
           $page=  $this->request->getQuery("page");
        }else{
            $page= 1;
        }
        $search_param=[];
        $search_param['pagination']['page']=$page;
        $search_param['pagination']['num_rec']=20;
            if($this->request->isPost()){
                $post = $_POST;

                if($this->request->getPost("discount_filter_name")!=""){
                    $search_param["name"]=$this->request->getPost("discount_filter_name");
                    $filter["discount_filter_name"]=$this->request->getPost("discount_filter_name");
                }
                if($this->request->getPost("discount_filter_start_date")!=""){
                    $search_param["date_from"]=$this->request->getPost("discount_filter_start_date");
                    $filter["discount_filter_start_date"]=$this->request->getPost("discount_filter_start_date");
                }
                if($this->request->getPost("discount_filter_end_date")!=""){
                    $search_param["date_to"]=$this->request->getPost("discount_filter_end_date");
                    $filter["discount_filter_end_date"]=$this->request->getPost("discount_filter_end_date");
                }
                if($this->request->getPost("discount_filter_coupon")!=""){
                    $search_param["coupon"]=$this->request->getPost("discount_filter_coupon");
                    $filter["discount_filter_coupon"]=$this->request->getPost("discount_filter_coupon");
                }
                $result = $this->DiscountsService->ajaxgetDiscounts($search_param);
                $discounts = $result["result"];

            }else{
                $result = $this->DiscountsService->ajaxgetDiscounts($search_param);
                $discounts = $result["result"];
            }

        $this->view->discounts = $discounts;
        $this->view->filter = $filter;
        //pagination
        $pagination["num_of_rec"] = count($result["total"]);
        $pagination["num_of_pages"] = ceil($pagination["num_of_rec"]/$search_param['pagination']['num_rec']);
        $pagination["current_page"] = $page;
        $pagination["next_page"] = $page+1;
        if($page+1>$pagination["num_of_pages"] ){
            $pagination["next_page"] = $pagination["num_of_pages"];
        }
        $pagination["last_page"] = $pagination["num_of_pages"] ;
        $pagination["back_page"] = $page-1 ;
        if($page-1<1 ){
            $pagination["back_page"] = 1;
        }
        $pagination["first_page"] = 1 ;
        $this->view->pagination = $pagination;


    }

    public function productsAction($discount_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $filter["product_name"]="";
        $filter["departments"]=[];
        $filter["product_price_from"]="";
        $filter["product_price_to"]="";
        $filter["manufacturer"]=0;
        $discount = Discounts::findFirst(["id={$discount_id}"]);
        $this->view->discount = $discount;
        //get products
        $search_param=[];
        $search_param["application_id"]=1;
        $search_param["module_id"]=8;
        $search_param["lang_id"]=2;
        if($this->request->getQuery("page")){
            $page=  $this->request->getQuery("page");
        }else{
            $page= 1;
        }
        $search_param['pagination']['page']=$page;
        $search_param['pagination']['num_rec']=10;
        if($this->request->isPost()){
            $search_param['name']= $this->request->getPost('product_name');
            $filter["product_name"]=$this->request->getPost('product_name');
            if(isset($_POST["Depts_ID"])){
                $search_param['departments']= $this->request->getPost('Depts_ID');
                $filter["departments"]=$this->request->getPost('Depts_ID');
            }
            if($this->request->getPost('product_price_from')!="" && $this->request->getPost('product_price_to')!="" ){
                $search_param['extra_fields']['price_from']= $this->request->getPost('product_price_from');
                $search_param['extra_fields']['price_to']= $this->request->getPost('product_price_to');
                $filter["product_price_from"]=$this->request->getPost('product_price_from');
                $filter["product_price_to"]=$this->request->getPost('product_price_to');
            }
            if($this->request->getPost('product_company')!=0){
                $search_param['manufacturer']= $this->request->getPost('product_company');
                $filter["manufacturer"]=$this->request->getPost('product_company');
            }

        }
        $products = $this->CmsSearch->switchSearchAction("content_search",$search_param);
        $this->view->products = $products;
        $pagination["num_of_rec"] = count($products["total"]);
        $pagination["num_of_pages"] = ceil($pagination["num_of_rec"]/$search_param['pagination']['num_rec']);
        $pagination["current_page"] = $page;
        $pagination["next_page"] = $page+1;
        if($page+1>$pagination["num_of_pages"] ){
            $pagination["next_page"] = $pagination["num_of_pages"];
        }
        $pagination["last_page"] = $pagination["num_of_pages"] ;
        $pagination["back_page"] = $page-1 ;
        if($page-1<1 ){
            $pagination["back_page"] = 1;
        }
        $pagination["first_page"] = 1 ;
        $this->view->pagination = $pagination;
        $this->view->filter = $filter;
        //Manufacturers
        $manufacturers = \DataCmsDeptsRel::find(["Core_Depts_ID=5"]);
        $this->view->manufacturers = $manufacturers;
        $this->tag->setDefault("product_company", $filter['manufacturer']);

    }
    public function discount_productsAction($discount_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $filter["product_name"]="";
        $filter["product_price_from"]="";
        $filter["product_price_to"]="";
        $filter["manufacturer"]=0;
        $discount = Discounts::findFirst(["id={$discount_id}"]);
        $this->view->discount = $discount;
        //get products
        $search_param=[];
        $search_param["application_id"]=1;
        $search_param["module_id"]=8;
        $search_param["lang_id"]=2;
        $search_param["discount_id"]=$discount_id;
        if($this->request->getQuery("page")){
            $page=  $this->request->getQuery("page");
        }else{
            $page= 1;
        }
        $search_param['pagination']['page']=$page;
        $search_param['pagination']['num_rec']=5;
        if($this->request->isPost()){
            $search_param['name']= $this->request->getPost('product_name');
            $filter["product_name"]=$this->request->getPost('product_name');
            if($this->request->getPost('product_price_from')!="" && $this->request->getPost('product_price_to')!="" ){
                $search_param['extra_fields']['price_from']= $this->request->getPost('product_price_from');
                $search_param['extra_fields']['price_to']= $this->request->getPost('product_price_to');
                $filter["product_price_from"]=$this->request->getPost('product_price_from');
                $filter["product_price_to"]=$this->request->getPost('product_price_to');
            }
            if($this->request->getPost('product_company')!=0){
                $search_param['manufacturer']= $this->request->getPost('product_company');
                $filter["manufacturer"]=$this->request->getPost('product_company');
            }

        }
        $products = $this->DiscountsService->discount_products_search($search_param);
        $this->view->products = $products;
        $pagination["num_of_rec"] = count($products["total"]);
        $pagination["num_of_pages"] = ceil($pagination["num_of_rec"]/$search_param['pagination']['num_rec']);
        $pagination["current_page"] = $page;
        $pagination["next_page"] = $page+1;
        if($page+1>$pagination["num_of_pages"] ){
            $pagination["next_page"] = $pagination["num_of_pages"];
        }
        $pagination["last_page"] = $pagination["num_of_pages"] ;
        $pagination["back_page"] = $page-1 ;
        if($page-1<1 ){
            $pagination["back_page"] = 1;
        }
        $pagination["first_page"] = 1 ;
        $this->view->pagination = $pagination;
        $this->view->filter = $filter;
        //Manufacturers
        $manufacturers = \DataCmsDeptsRel::find(["Core_Depts_ID=5"]);
        $this->view->manufacturers = $manufacturers;
        $this->tag->setDefault("product_company", $filter['manufacturer']);
        $discount_items = DiscountRelItems::find("discount_id={$discount_id}");
        //$this->view->pick("index/partials/discount_products");
        $this->view->discount_items= $products;

    }

    public function add_discount_catAction(){
        if(!$this->request->isPost()){
            echo "not post";
            die;
        }
        $dept = $this->request->getPost("Depts_ID")[0];
        if(!$dept){
            $this->flashSession->error("Please Choose Department");

            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        $discount_id = $this->request->getPost("discount_id");

        $products= \DataCmsDeptsRelItem::find(["Depts_ID={$dept}"]);
            foreach ($products as $value){
                $discount_rel_items = DiscountRelItems::findFirst(["discount_id={$discount_id} and data_cms_id={$value->Item_ID}"]);
                if($discount_rel_items){
                    continue;
                }
                $discount_rel_items = new DiscountRelItems();
                $discount_rel_items->discount_id = $discount_id;
                $discount_rel_items->data_cms_id = $value->Item_ID;
                $discount_rel_items->created_at=time();
                $discount_rel_items->updated_at=time();
                $discount_rel_items->save();
            }
            $this->flashSession->success("Products has been added to discount");

        return $this->response->redirect($_SERVER['HTTP_REFERER']);


    }

    public function ajaxDeleteDiscountAction($discount_id)
    {
        $response['status'] = 0;
        $response['msg']    = '';

        $discount = Discounts::findFirst($discount_id);

        if(!$discount)
        {
            $response['msg'] = 'خصم خطأ';
            return json_encode($response);
        }

        if(!$discount->delete())
        {
            $response['msg'] = 'خطأ أثناء حذف الخصم ، حاول مرة أخرى';
            return json_encode($response);
        }

        $discount_rel_items = DiscountRelItems::find([
            'discount_id = :discount_id:',
            'bind' => [
                'discount_id' => $discount_id
            ]
        ]);

        foreach($discount_rel_items as $item)
        {
            $item->delete();
        }

        $response['status'] = 1;

        return json_encode($response);
    }
}