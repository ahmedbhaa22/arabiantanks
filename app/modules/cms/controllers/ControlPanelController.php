<?php

namespace Vokuro\Cms\Controllers;

use Models\Content;
use Vokuro\Cms\Services\BranchesService;
use Vokuro\Cms\Services\ClientCatsService;
use Vokuro\Cms\Services\PendReqReasonsSerivce;
use Vokuro\Controllers\ControllerBase;

use DataTables\DataTable;

use Models\UsersMobile;

use Phalcon\Tag;

use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Models\BranchContacts;
use Vokuro\Models\CompanyBranches;
use Vokuro\Models\Profiles;

use Vokuro\Models\UserInformation;

use Vokuro\Models\UsersRules;
use Vokuro\Models\UsersUsersRules;
use Phalcon\Filter;

class ControlPanelController extends ControllerBase
{
    public function indexAction(){
//       // $this->view->disable();
//        $branches_service = new BranchesService();
//        $search_param["page"] = 1;
//        $branches = $branches_service->getBranches($search_param);
//        $branches = $this->TanksBranches->getBranches($search_param);
//        //print_r($branches);

    }

    public function branches_tableAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $filter["filter_cities"]=0;
        $filter["filter_regions"]=0;
        if($this->request->getPost("filter_cities")){
            if($this->request->getPost("filter_cities") != 0){
                $filter["filter_cities"]=$this->request->getPost("filter_cities");
                if($this->request->getPost("filter_regions")){
                    $filter["filter_regions"]=$this->request->getPost("filter_regions");
                    $search_param["region_id"]=$filter["filter_regions"];
                    $search_param["city_id"]= $filter["filter_cities"];
                }
            }
        }

        $search_param["page"] = 1;
        if($this->request->getQuery("page","int")){
            $search_param["page"] = $this->request->getQuery("page");
        }
        $branches = $this->TanksBranches->getBranches($search_param);
        $this->view->content = $branches;

        $this->view->regions = $this->TanksBranches->getRegions();
        $this->view->filter = $filter;
    }
    public function getRegionsAjaxAction($city_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $branches_service = new BranchesService();
        $regions = $branches_service->getRegions((int)$city_id);
        $this->view->regions = $regions;
        $this->view->selected = 0;
        if($this->request->getQuery("selected")!=0){
            $this->view->selected = $this->request->getQuery("selected");
        }
    }

    public function getCitiesAjaxAction($region_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $cities = $this->TanksBranches->getCitiesByRegion((int)$region_id);
        $this->view->cities = $cities;
        $this->view->selected = 0;
        if($this->request->getQuery("selected")!=0){
            $this->view->selected = $this->request->getQuery("selected");
        }
    }

    public function createBranchAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);

        if(!$this->request->getQuery("region")){
            return false;
        }

        $branch_info["region_id"] = $this->request->getQuery("region");
        $branch_info["city_id"] = $this->request->getQuery("city");

        $branch_info["name"] = $this->request->getQuery("branch_name");
        $branch_info["name_eng"] = $this->request->getQuery("branch_name_eng");
        $new_branch = $this->TanksBranches->addBranch($branch_info);
        return $new_branch;
    }
    public function deleteBranchAction(){
        $this->view->disable();
        $branch_service= new BranchesService();
        if($this->request->getPost("branches_checked")){
            $branches_checked=$this->request->getPost("branches_checked");
            foreach ($branches_checked as $branch){
                $branch_info["id"] = $branch;
                $branch_service->deleteBranch($branch_info);
            }
            return true;
        }
        if(!$this->request->getQuery("branch_id")){
            return false;
        }
        $branch_info["id"] = $this->request->getQuery("branch_id","int");

        $new_branch = $branch_service->deleteBranch($branch_info);
        return $new_branch;
    }

    public function clients_cats_tableAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $filter_client_cats=[];
        $filter_client_cats["id"]=0;
        $this->view->selected = "all";
        $search_param["page"] = 1;
        if($this->request->getQuery("page","int")){
            $search_param["page"] = $this->request->getQuery("page");
        }
        if($this->request->getPost("client_cat_id")){
            $search_param["id"] = $this->request->getPost("client_cat_id");
            $filter_client_cats["id"] = $this->request->getPost("client_cat_id");
            if($this->request->getPost("client_cat_id")!="all"){
                $this->view->selected = $this->request->getPost("client_cat_id");
            }
        }
        $cliet_cats_service= new ClientCatsService();
        $clients_cats=$cliet_cats_service->getClientCats($search_param);
        $clients_cats_all= $cliet_cats_service->getAllClientCats();
        $this->view->filter_client_cats=$filter_client_cats;
        $this->view->content = $clients_cats;
        $this->view->clients_cats_all = $clients_cats_all;


    }
    public function createCatAction(){
        $this->view->disable();

        if(!$this->request->getPost("cat")){
            return false;
        }
         $cat_info["name"] = $this->request->getPost("cat");
        $cliet_cats_service= new ClientCatsService();
        $new_branch = $cliet_cats_service->addCat($cat_info);
        return $new_branch;
    }
    public function getClientsCatsAjaxAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $clients_cats_service = new ClientCatsService();
        $clients_cats = $clients_cats_service->getAllClientCats();
        $this->view->clients_cats = $clients_cats;
        $this->view->selected = 0;
        if($this->request->getQuery("selected")!=0){
            $this->view->selected = $this->request->getQuery("selected");
        }
    }
    public function deleteCatAction(){
        $this->view->disable();
        $cliet_cats_service= new ClientCatsService();
        if($this->request->getPost("cats_checked")){
            $cats_checked=$this->request->getPost("cats_checked");
            foreach ($cats_checked as $cat){
                $cat_info["id"] = $cat;
                $cliet_cats_service->deleteCat($cat_info);
            }
            return true;
        }
        if(!$this->request->getQuery("cat_id")){
            return false;
        }
        $cat_info["id"] = $this->request->getQuery("cat_id","int");

        $new_branch = $cliet_cats_service->deleteCat($cat_info);
        return $new_branch;
    }
    public function reasons_tableAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $filter_reason=[];
        $search_param["page"] = 1;
        $this->view->selected = "all";
        if($this->request->getQuery("page","int")){
            $search_param["page"] = $this->request->getQuery("page");
        }
        if($this->request->getPost("filter_reason")){
            $filter_reason["id"] = $this->request->getPost("filter_reason");
            if($this->request->getPost("filter_reason")!="all"){
                $search_param["id"] = $filter_reason["id"];
                $this->view->selected = $filter_reason["id"];
            }

        }
        $reasons_service = new PendReqReasonsSerivce();
        $reasons = $reasons_service->getReasons($search_param);
        $all_reasons = $reasons_service->getAllReasons();
        $this->view->all_reasons = $all_reasons;
        $this->view->content = $reasons;
    }
    public function createReasonAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);

        if(!$this->request->getQuery("reason_name")){
            return false;
        }
        $reason_info["reason_title"] = $this->request->getQuery("reason_name");
        $reasons_service = new PendReqReasonsSerivce();
        $new_reason = $reasons_service->addReason($reason_info);
        return $new_reason;
    }
    public function deleteReasonAction(){
        $this->view->disable();
        $reason_service= new PendReqReasonsSerivce();
        if($this->request->getPost("reasons_checked")){
            $reasons_checked=$this->request->getPost("reasons_checked");
            foreach ($reasons_checked as $reason){
                $reason_info["id"] = $reason;
                $reason_service->deleteReason($reason_info);
            }
            return true;
        }
        if(!$this->request->getQuery("reason_id")){
            return false;
        }
        $reason_info["id"] = $this->request->getQuery("reason_id","int");

        $reason_service->deleteReason($reason_info);
        return true;
    }

    public function testTransAction(){
        $this->view->disable();
        $cp_system_trans= \CpSystemTranslation::find(["lang_id=1"]);
        $result = [];
        foreach ($cp_system_trans as $string){
            $result[$string->word_key] = $string->value;

        }
        print_r($result);

    }

    public function testQueryAction(){
        $this->view->disable();
        $content= Content::find(["Module_ID=8"]);
        die();
    }

    public function edit_branchAction($branch_id){
        $branch_id=(int)$branch_id;
        $branch = CompanyBranches::findFirst(["id={$branch_id}"]);
        $this->view->branch = $branch;
    }
    public function save_branchAction(){
        if(!$this->request->isPost()){
            die;
        }
        $branch_id = $this->request->getPost("branch_id");
        $address = $this->request->getPost("branch_address");
        $name = $this->request->getPost("branch_name");
        $phone = $this->request->getPost("branch_phone");
        $branch = CompanyBranches::findFirst(["id={$branch_id}"]);
        $branch->address=$address;
        $branch->phone = $phone;
        $branch->name = $name;
        $branch->lat=$this->request->getPost("branch_lat");
        $branch->long=$this->request->getPost("branch_long");
        $branch->mail=$this->request->getPost("mail");
        if(!$branch->save()){
            foreach($branch->getMessages() as $msg){
                $this->flashSession->error($msg);
            }
        }
        $contact_phone= BranchContacts::findFirst(["branch_id={$branch_id} and type_id=2"]);
        if(!$contact_phone){
            $contact_phone = new BranchContacts();
            $contact_phone->branch_id=$branch_id;
            $contact_phone->type_id=2;

        }
        $contact_phone->name = $phone;
        $contact_phone->save();
        $contact_mail= BranchContacts::findFirst(["branch_id={$branch_id} and type_id=1"]);
        if(!$contact_mail){
            $contact_mail = new BranchContacts();
            $contact_mail->branch_id=$branch_id;
            $contact_mail->type_id=1;

        }
        $contact_mail->name = $this->request->getPost("mail");
        $contact_mail->save();
        return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }
}