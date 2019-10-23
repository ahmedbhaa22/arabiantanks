<?php
namespace Vokuro\Offers\Controllers;

use Models\TanksRegions;
use Vokuro\Controllers\ControllerBase;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Models\CompanyBranches;
use Vokuro\Offers\Models\OfferBranches;
use Vokuro\Offers\Models\OfferRegions;
use Vokuro\Offers\Models\OfferRelItems;
use Vokuro\Offers\Models\OfferRelTypes;
use Vokuro\Offers\Models\Offers;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Offers\Models\OffersLang;

class IndexController extends ControllerBase
{
    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';

    public function indexAction()
    {
//        $content_search = $this->modelsManager->createBuilder()->from("Vokuro\Offers\Models\Offers");
//        $content_search->orderBy("Vokuro\Offers\Models\Offers.id DESC");
//        $result = $content_search->getQuery()->execute();
//        $this->view->offers = $result;
        $filter["offer_filter_name"] = "";
        $filter["offer_filter_start_date"] = "";
        $filter["offer_filter_end_date"] = "";
        $this->view->filter = $filter;
    }

    public function newAction($offer_id = null)
    {
        if ($offer_id == null) {
            $this->view->create = 1;
            $regions = $this->TanksBranches->getRegions();
            $this->view->regions = $regions;
            //Delivery Places (Branches)
            $delivery_places = CompanyBranches::find();
            $this->view->delivery_places = $delivery_places;
        } else {
            $this->view->create = 0;
            $offer = Offers::findFirst(["id={$offer_id}"]);
            $this->view->offer = $offer;
            //offer details
            $offer_rel_type = OfferRelTypes::find(["offer_id={$offer->id}"]);
            $this->view->offer_rel_type = $offer_rel_type;


        }


    }

    public function offer_itemsAction($offer_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $offer = Offers::findFirst(["id={$offer_id}"]);
        $this->view->offer = $offer;
        //get items in offer
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        } else {
            $page = 1;
        }
        $builder = $this->modelsManager->createBuilder()
            ->from("Vokuro\Offers\Models\OfferRelItems")
            ->andWhere("Vokuro\Offers\Models\OfferRelItems.offer_id={$offer_id}");
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit" => 5,
                "page" => $page,
            ]
        );
        $this->view->offer_items = $paginator->getPaginate();
    }

    public function viewAction($offer_id)
    {
        $offer_id=(int)$offer_id;
        $offer = Offers::findFirst(["id={$offer_id}"]);
        if(!$offer){
            $this->flashSession->error("هذا العرض غير موجود");
            return $this->response->redirect("offers_module/index");
        }
        $this->view->offer = $offer;
        //offer details
        $offer_rel_type = OfferRelTypes::findFirst(["offer_id={$offer->id}"]);
        $this->view->offer_rel_type = $offer_rel_type;
    }

    public function addProductToOfferAction($product_id, $offer_id)
    {
        $this->view->disable();
        $offer_item = OfferRelItems::findFirst(["data_cms_id={$product_id} AND offer_id={$offer_id}"]);
        if ($offer_item) {
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        } else {
            $offer_item = new OfferRelItems();
            $offer_item->offer_id = $offer_id;
            $offer_item->data_cms_id = $product_id;
            $offer_item->created_at = time();
            $offer_item->updated_at = time();
            $offer_item->save();
            //update offer count
            $offer = Offers::findFirst(["id={$offer_id}"]);
            $offer->products_number++;
            $offer->save();
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function removeFromOfferAction($product_id, $offer_id)
    {
        $this->view->disable();
        $offer_item = OfferRelItems::findFirst(["data_cms_id={$product_id} AND offer_id={$offer_id}"]);
        if ($offer_item) {
            $offer_item->delete();
            //update offer count
            $offer = Offers::findFirst(["id={$offer_id}"]);
            $offer->products_number--;
            $offer->save();
        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    public function editAction($offer_id)
    {
        $this->view->create = 0;
        $offer = Offers::findFirst(["id={$offer_id}"]);
        if(!$offer){
            $this->flashSession->error("هذا العرض غير موجود");
            return $this->response->redirect("offers_module/index");
        }
        $this->view->offer = $offer;
        //offer details
        $offer_rel_type = OfferRelTypes::find(["offer_id={$offer->id}"]);
        $this->view->offer_rel_type = $offer_rel_type;
        //get items in offer
        $offer_items = OfferRelItems::find(["offer_id={$offer_id}"]);
        $this->view->offer_items = $offer_items;
        //get products
//        $search_param["application_id"]=1;
//        $search_param["module_id"]=8;
////        $products = $this->CmsSearch->switchSearchAction("content_search",$search_param);
////        $this->view->products = $products;
        //Regions
        $cities = GeoCities::find();
        $this->view->cities = $cities;
        //Delivery Places (Branches)
        $delivery_places = CompanyBranches::find();
        $this->view->delivery_places = $delivery_places;
        $offer_regions_arr=[];
        $offer_delivery_arr=[];
        $offer_regions=OfferRegions::find("offer_id={$offer_id}");
        foreach ($offer_regions as $offer_region){
            $offer_regions_arr[]=$offer_region->region_id;
        }
        $offer_delivery_palces=OfferBranches::find("offer_id={$offer_id}");
        foreach ($offer_delivery_palces as $offer_delivery_palce){
            $offer_delivery_arr[]=$offer_delivery_palce->branch_id;
        }
        $this->view->offer_regions=$offer_regions_arr;
        $this->view->offer_delivery_places=$offer_delivery_arr;
    }

    public function deleteAction($offer_id)
    {
        $offer_id=(int)$offer_id;
        $offer = Offers::findFirst(["id={$offer_id}"]);
        if(!$offer){
            $this->flashSession->error("هذا العرض غير موجود");
            return $this->response->redirect("offers_module/index");
        }
        if ($offer) {
            $offer->delete();
            $offer_rel_items = OfferRelItems::find(["offer_id={$offer_id}"]);
            foreach ($offer_rel_items as $item) {
                $item->delete();
            }
            $this->flashSession->success("Offer Deleted");
            return $this->response->redirect("offers_module/index/index");
        } else {
            return $this->response->redirect("offers_module/index/index");
        }
    }
    public function delete_offersAction(){
        $offers = $this->request->getPost("offers");
        foreach ($offers as $offer_id){
            $offer_id=(int)$offer_id;
            $offer = Offers::findFirst(["id={$offer_id}"]);
            if(!$offer){
                continue;
            }
            if ($offer) {
                $offer->delete();
                $offer_rel_items = OfferRelItems::find(["offer_id={$offer_id}"]);
                foreach ($offer_rel_items as $item) {
                    $item->delete();
                }
                $this->flashSession->success("Offer Deleted");
            }

        }
    }

    public function createAction()
    {
        if ($this->request->isPost()) {
            $regions = [];
            $offer_name = $this->request->getPost("offer_name");
            $offer_des = $this->request->getPost("offer_des");
            $offer_discount_ratio = $this->request->getPost("discount_ratio");
            $date_from = strtotime($this->request->getPost("date_from"));
            $date_to = strtotime($this->request->getPost("date_to"));
            $regions = $this->request->getPost("regions") ?: $regions;
            $offer_price = $this->request->getPost("offer_price");
            $offer_tax_percentage = (int)$this->request->getPost("tax_percentage");
            $offer = new Offers();
            $offer->name = $offer_name;
            $offer->description = $offer_des;
            $offer->discount_percent = $offer_discount_ratio;
            if ($this->request->getPost("show_home_page")) {
                $offer->show_in_homepage = 1;
            } else {
                $offer->show_in_homepage = 0;
            }
            $offer->active = 1;
            $offer->created_at = time();
            $offer->original_price = 0;
            $offer->price = $offer_price;
            $offer->updated_at = time();
            $offer->products_number = 0;
            $offer->max_purchase_number = 0;
            $offer->tax_percentage = $offer_tax_percentage;
            if ($this->request->hasFiles() == true) {
                foreach ($this->request->getUploadedFiles() as $file) {
                    if ($file->getKey() == "offer_picture") {
                        //die("Islam");
                        $random = new Random();
                        $random_name = $random->uuid() . "." . $file->getExtension();

                        $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                        $offer->image = $random_name;

                    }
                }

            }
            if (!$offer->save()) {
                foreach ($offer->getMessages() as $msg) {
                    $this->flashSession->error($msg);
                }

            }
            //regions
            foreach ($regions as $region) {
                $offer_region = new OfferRegions();
                $offer_region->created_at = time();
                $offer_region->offer_id = $offer->id;
                $offer_region->region_id = $region;
                $offer_region->updated_at = time();
                if (!$offer_region->save()) {
                    foreach ($offer_region->getMessages() as $msg) {
                        $this->flashSession->error($msg);
                    }

                }
            }
            //offer types
            if ($this->request->getPost("offer_duration1")) {
                //until quantity
                $offer_rel_type = new OfferRelTypes();
                $offer_rel_type->offer_id = $offer->id;
                $offer_rel_type->type_id = 1;
                $offer_rel_type->created_at = time();
                $offer_rel_type->updated_at = time();
                $offer_rel_type->start_date = $date_from;
                $offer_rel_type->end_date = $date_to;

            }
            if ($this->request->getPost("offer_duration2")) {
                //Limited Period
                $offer_rel_type = new OfferRelTypes();
                $offer_rel_type->offer_id = $offer->id;
                $offer_rel_type->type_id = 2;
                $offer_rel_type->created_at = time();
                $offer_rel_type->updated_at = time();
                $offer_rel_type->start_date = $date_from;
                $offer_rel_type->end_date = $date_to;
                if (!$offer_rel_type->save()) {
                    foreach ($offer_rel_type->getMessages() as $msg) {
                        $this->flashSession->error($msg);
                    }

                }

            }

            $regions = [];
            $delivery_places = [];
            $regions = $this->request->getPost("regions") ?: $regions;
            $delivery_places = $this->request->getPost("delivery_places") ?: $delivery_places;
            //Regions
            if ($regions != []) {
                foreach ($regions as $region) {
                    $offer_region = new OfferRegions();
                    $offer_region->offer_id = $offer->id;
                    $offer_region->region_id = $region;
                    $offer_region->created_at = time();
                    $offer_region->updated_at = time();
                    $offer_region->save();

                }

            }
            //Delivery Places
            if ($delivery_places != []) {
                //Offer Regions
                foreach ($delivery_places as $delivery_place) {

                    $offer_delivery_place = new OfferBranches();
                    $offer_delivery_place->offer_id = $offer->id;
                    $offer_delivery_place->branch_id = $delivery_place;
                    $offer_delivery_place->created_at = time();
                    $offer_delivery_place->updated_at = time();
                    $offer_delivery_place->save();

                }

            }



            $offer_name_en = $this->request->getPost("offer_name_en");
            $offer_des_en = $this->request->getPost("offer_des_en");
            $offer_lang = new OffersLang();
            $offer_lang->offer_id = $offer->id;
            $offer_lang->name = $offer_name_en;
            $offer_lang->description= $offer_des_en;
            if ($this->request->hasFiles() == true) {
                foreach ($this->request->getUploadedFiles() as $file) {
                    if ($file->getKey() == "offer_picture_en") {
                        //die("Islam");
                        $random = new Random();
                        $random_name = $random->uuid() . "." . $file->getExtension();

                        $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                        $offer_lang->img = $random_name;

                    }
                }

            }
            $offer_lang->lang_id= 2;
            if(!$offer_lang->save()){
                foreach ($offer_lang->getMessages() as $e){
                    $this->flashSession->error($e);
                }
            };

            return $this->response->redirect("offers_module/index/view/{$offer->id}");
        }
    }

    public function saveAction()
    {
        if ($this->request->isPost()) {
            $regions = [];
            $delivery_places = [];
            $offer_id = $this->request->getPost("offer_id");
            $offer_name = $this->request->getPost("offer_name");
            $offer_des = $this->request->getPost("offer_des");
            $offer_discount_ratio = $this->request->getPost("discount_ratio");
            $date_from = strtotime($this->request->getPost("date_from"));
            $date_to = strtotime($this->request->getPost("date_to"));
            $regions = $this->request->getPost("regions") ?: $regions;
            $delivery_places = $this->request->getPost("delivery_places") ?: $delivery_places;
            $offer_price = $this->request->getPost("offer_price");
            $offer = Offers::findFirst(["id={$offer_id}"]);
            $offer->name = $offer_name;
            $offer->description = $offer_des;
            $offer->discount_percent = $offer_discount_ratio;
            $offer->price = $offer_price;
            if ($this->request->getPost("show_home_page")) {
                $offer->show_in_homepage = 1;
            } else {
                $offer->show_in_homepage = 0;
            }
            $offer->active = 1;
            $offer->original_price = 0;
            $offer->updated_at = time();
            $offer->max_purchase_number = 0;
            if ($this->request->hasFiles() == true) {
                foreach ($this->request->getUploadedFiles() as $file) {
                    if ($file->getKey() == "offer_picture" && strlen($file->getName()) > 0) {
                        //die("Islam");
                        $random = new Random();
                        $random_name = $random->uuid() . "." . $file->getExtension();

                        $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                        $offer->image = $random_name;

                    }
                }

            }
            if (!$offer->save()) {
                foreach ($offer->getMessages() as $msg) {
                    $this->flashSession->error($msg);
                }

            }else{
                if($offer->lang){
                    $offer_lang=$offer->lang;
                }else{
                    $offer_lang = new OffersLang();
                }
                $offer_lang->offer_id= $offer->id;
                $offer_lang->lang_id=2;
                $offer_lang->name= $this->request->getPost("offer_name_eng");
                $offer_lang->description= $this->request->getPost("offer_des_eng");
                if ($this->request->hasFiles() == true) {
                    foreach ($this->request->getUploadedFiles() as $file) {
                        if ($file->getKey() == "offer_picture_eng" && strlen($file->getName()) > 0) {
                            //die("Islam");
                            $random = new Random();
                            $random_name = $random->uuid() . "." . $file->getExtension();

                            $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                            $offer_lang->img = $random_name;

                        }
                    }

                }
                if (!$offer_lang->save()) {
                    foreach ($offer_lang->getMessages() as $msg) {
                        $this->flashSession->error($msg);
                    }
                }
            }
            //regions
//            foreach ($regions as $region) {
//                $offer_region = new OfferRegions();
//                $offer_region->created_at = time();
//                $offer_region->offer_id = $offer->id;
//                $offer_region->region_id = $region;
//                $offer_region->updated_at = time();
//                if (!$offer_region->save()) {
//                    foreach ($offer_region->getMessages() as $msg) {
//                        $this->flashSession->error($msg);
//                    }
//
//                }
//            }
            //offer types
            if ($this->request->getPost("offer_duration1")) {
                //until quantity
                $offer_rel_type = OfferRelTypes::findFirst(["offer_id={$offer_id} and type_id=1"]);
                if (!$offer_rel_type) {
                    $offer_rel_type = new OfferRelTypes();
                    $offer_rel_type->created_at = time();
                }
                $offer_rel_type->offer_id = $offer->id;
                $offer_rel_type->type_id = 1;
                $offer_rel_type->updated_at = time();
                $offer_rel_type->start_date = $date_from;
                $offer_rel_type->end_date = $date_to;

            }
            if ($this->request->getPost("offer_duration2")) {
                //Limited Period
                $offer_rel_type = OfferRelTypes::findFirst(["offer_id={$offer_id} and type_id=2"]);
                if (!$offer_rel_type) {
                    $offer_rel_type = new OfferRelTypes();
                    $offer_rel_type->created_at = time();
                }
                $offer_rel_type->offer_id = $offer->id;
                $offer_rel_type->type_id = 2;
                $offer_rel_type->updated_at = time();
                $offer_rel_type->start_date = $date_from;
                $offer_rel_type->end_date = $date_to;
                if (!$offer_rel_type->save()) {
                    foreach ($offer_rel_type->getMessages() as $msg) {
                        $this->flashSession->error($msg);
                    }

                }

            }
            if ($regions != []) {
                //Offer Regions
                $offer_regions = OfferRegions::find(["offer_id={$offer_id}"]);
                foreach ($offer_regions as $offer_region) {
                    if (!in_array($offer_region->region_id, $regions)) {
                        $offer_region->delete();
                    }

                }
                foreach ($regions as $region) {
                    $offer_region = OfferRegions::findFirst(["offer_id={$offer_id} AND region_id={$region}"]);
                    if (!$offer_region) {
                        $offer_region = new OfferRegions();
                        $offer_region->offer_id = $offer_id;
                        $offer_region->region_id = $region;
                        $offer_region->created_at = time();
                        $offer_region->updated_at = time();
                        $offer_region->save();
                    } else {
                        $offer_region->updated_at = time();
                        $offer_region->save();
                    }
                }

            } else {
                $offer_regions = OfferRegions::find(["offer_id={$offer_id}"]);
                foreach ($offer_regions as $offer_region) {
                    $offer_region->delete();
                }
            }

            if ($delivery_places != []) {
                //Offer Regions
                $offer_delivery_places = OfferBranches::find(["offer_id={$offer_id}"]);
                foreach ($offer_delivery_places as $offer_delivery_place) {
                    if (!in_array($offer_delivery_place->branch_id, $delivery_places)) {
                        $offer_delivery_place->delete();
                    }

                }
                foreach ($delivery_places as $delivery_place) {
                    $offer_delivery_place = OfferBranches::findFirst(["offer_id={$offer_id} AND branch_id={$delivery_place}"]);
                    if (!$offer_delivery_place) {
                        $offer_delivery_place = new OfferBranches();
                        $offer_delivery_place->offer_id = $offer_id;
                        $offer_delivery_place->branch_id = $delivery_place;
                        $offer_delivery_place->created_at = time();
                        $offer_delivery_place->updated_at = time();
                        $offer_delivery_place->save();
                    } else {
                        $offer_delivery_place->updated_at = time();
                        $offer_delivery_place->save();
                    }
                }

            } else {
                $offer_delivery_places = OfferBranches::find(["offer_id={$offer_id}"]);
                foreach ($offer_delivery_places as $offer_delivery_place) {
                    $offer_delivery_place->delete();
                }
            }

            //calculate offer price
            $calculate = $this->calculate_offer_price($offer_id);
            return $this->response->redirect("offers_module/index/edit/{$offer->id}");
        }
    }

    public function testAction()
    {
        $this->view->disable();
        $this->OffersService->ajaxgetOffers();
    }

    public function productsAction($offer_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $filter["product_name"] = "";
        $filter["departments"] = [];
        $filter["product_price_from"] = "";
        $filter["product_price_to"] = "";
        $filter["manufacturer"] = 0;
        $offer = Offers::findFirst(["id={$offer_id}"]);
        $this->view->offer = $offer;
        //get products
        $search_param = [];
        //get offer items
        $offer_items = $offer->getProducts();
        foreach ($offer_items as $item){
            $search_param["offer_items"][]= $item->ID;
        }
        $search_param["application_id"] = 1;
        $search_param["module_id"] = 8;
        $search_param["lang_id"] = 2;
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        } else {
            $page = 1;
        }
        $search_param['pagination']['page'] = $page;
        $search_param['pagination']['num_rec'] = 10;

        if ($this->request->isPost()) {
            $search_param['name'] = $this->request->getPost('product_name');
            $filter["product_name"] = $this->request->getPost('product_name');
            if (isset($_POST["Depts_ID"])) {
                $search_param['departments'] = $this->request->getPost('Depts_ID');
                $filter["departments"] = $this->request->getPost('Depts_ID');
            }
            if ($this->request->getPost('product_price_from') != "" && $this->request->getPost('product_price_to') != "") {
                $search_param['extra_fields']['price_from'] = $this->request->getPost('product_price_from');
                $search_param['extra_fields']['price_to'] = $this->request->getPost('product_price_to');
                $filter["product_price_from"] = $this->request->getPost('product_price_from');
                $filter["product_price_to"] = $this->request->getPost('product_price_to');
            }
            if ($this->request->getPost('product_company') != 0) {
                $search_param['manufacturer'] = $this->request->getPost('product_company');
                $filter["manufacturer"] = $this->request->getPost('product_company');
            }

        }
        $products = $this->CmsSearch->switchSearchAction("content_search", $search_param);
        $this->view->products = $products;
        $pagination["num_of_rec"] = count($products["total"]);
        $pagination["num_of_pages"] = ceil($pagination["num_of_rec"] / $search_param['pagination']['num_rec']);
        $pagination["current_page"] = $page;
        $pagination["next_page"] = $page + 1;
        if ($page + 1 > $pagination["num_of_pages"]) {
            $pagination["next_page"] = $pagination["num_of_pages"];
        }
        $pagination["last_page"] = $pagination["num_of_pages"];
        $pagination["back_page"] = $page - 1;
        if ($page - 1 < 1) {
            $pagination["back_page"] = 1;
        }
        $pagination["first_page"] = 1;
        $this->view->pagination = $pagination;
        $this->view->filter = $filter;
        //Manufacturers
        $manufacturers = \DataCmsDeptsRel::find(["Core_Depts_ID=5"]);
        $this->view->manufacturers = $manufacturers;
        $this->tag->setDefault("product_company", $filter['manufacturer']);

    }

    public function offers_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        if ($this->request->getQuery("page")) {
            $page = $this->request->getQuery("page");
        } else {
            $page = 1;
        }
        $regions = TanksRegions::find();
        $this->view->regions = $regions;
        $search_param = [];
        $search_param['pagination']['page'] = $page;
        $search_param['pagination']['num_rec'] = 4;
        $filter["offer_filter_name"] = "";
        $filter["offer_filter_start_date"] = "";
        $filter["offer_filter_end_date"] = "";
        $filter["offer_filter_region"] = 0;
        if ($this->request->isPost()) {
            $post = $_POST;

            if ($this->request->getPost("offer_filter_start_date") != "") {
                $search_param["date_from"] = $this->request->getPost("offer_filter_start_date");
                $filter["offer_filter_start_date"] = $this->request->getPost("offer_filter_start_date");
            }
            if ($this->request->getPost("offer_filter_end_date") != "") {
                $search_param["date_to"] = $this->request->getPost("offer_filter_end_date");
                $filter["offer_filter_end_date"] = $this->request->getPost("offer_filter_end_date");
            }
            if ($this->request->getPost("offer_filter_name") != "") {
                $search_param["name"] = $this->request->getPost("offer_filter_name");
                $filter["offer_filter_name"] = $this->request->getPost("offer_filter_name");
            }
            if ($this->request->getPost("offer_filter_region") != 0) {
                $search_param["region"] = $this->request->getPost("offer_filter_region");
                $filter["offer_filter_region"] = $this->request->getPost("offer_filter_region");
            }
            $offers = $this->OffersService->ajaxgetOffers($search_param);
            $this->view->offers = $offers["items"];


        } else {
            $offers = $this->OffersService->ajaxgetOffers($search_param);
            $this->view->offers = $offers["items"];
        }
        $this->view->filter = $filter;
        //pagination
        $pagination["num_of_rec"] = count($offers["total"]);
        $pagination["num_of_pages"] = ceil($pagination["num_of_rec"] / $search_param['pagination']['num_rec']);
        $pagination["current_page"] = $page;
        $pagination["next_page"] = $page + 1;
        if ($page + 1 > $pagination["num_of_pages"]) {
            $pagination["next_page"] = $pagination["num_of_pages"];
        }
        $pagination["last_page"] = $pagination["num_of_pages"];
        $pagination["back_page"] = $page - 1;
        if ($page - 1 < 1) {
            $pagination["back_page"] = 1;
        }
        $pagination["first_page"] = 1;
        $this->view->pagination = $pagination;
    }

    public function ajaxDeleteOfferAction($offer_id)
    {
        $response['status'] = 0;
        $response['msg']    = '';

        $offer = Offers::findFirst($offer_id);

        if(!$offer)
        {
            $response['msg'] = 'عرض خطأ';
            return json_encode($response);
        }

        if(!$offer->delete())
        {
            $response['msg'] = 'خطأ أثناء حذف العرض، حاول مرة أخرى';
            return json_encode($response);
        }

        $offer_rel_items = OfferRelItems::find([
            'offer_id = :offer_id:',
            'bind' => [
                'offer_id' => $offer_id
            ]
        ]);

        foreach($offer_rel_items as $item)
        {
            $item->delete();
        }

        $response['status'] = 1;

        return json_encode($response);
    }

    protected function calculate_offer_price($offer_id){
        $offer_id = (int)$offer_id;
        $offer = Offers::findFirst(["id={$offer_id}"]);
        return true;
        if(!$offer){
            return false;
        }
        $total_price_before = 0;
        foreach ($offer->products as $product){
            $price = ($product->extraFields)?floatval($product->extraFields->price):0;
            $total_price_before += $price;
        }
        $offer->original_price = $total_price_before;
        $offer->price = $total_price_before - ($total_price_before * ($offer->discount_percent / 100));
        $offer->save();
        return true;
    }
}