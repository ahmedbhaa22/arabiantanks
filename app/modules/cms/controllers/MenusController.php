<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;

use Vokuro\Models\Menus;
use Phalcon\Http\Request;
use Phalcon\Security;
use Phalcon\Mvc\Url;


class MenusController extends ControllerBase
{

    public function indexAction(){
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $menu = Menus::find(array("app_id={$app_id}"));
        $this->view->menu = $menu;
    }
    public function editAction($id){
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $item = Menus::findFirst(array("app_id={$app_id} and id={$id}"));
        $this->tag->setDefault("id",$item->id);
        $this->tag->setDefault("name",$item->name);
        $this->tag->setDefault("icon",$item->icon);
        $this->tag->setDefault("order",$item->order);
        $this->tag->setDefault("href",$item->href);
    }
    public function deleteAction($id){
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $item = Menus::findFirst(array("app_id={$app_id} and id={$id}"));
        $item->delete();
        $this->flashSession->success($this->getTranslation()->_("Item was deleted successfully"));
        return $this->response->redirect("menus/index/");
    }
    public function newAction(){

    }
    public function saveAction(){
        if ($this->request->isPost()){
            $id=$this->request->getPost("id");
            $item = Menus::findFirst(array("id={$id}"));
            $item->name = $this->request->getPost("name");
            $item->href = $this->request->getPost("href");
            $item->icon = $this->request->getPost("icon");
            $item->order = $this->request->getPost("order");
            $item->save();
            $this->flashSession->success($this->getTranslation()->_("Item was saved successfully"));
            return $this->response->redirect("menus/index");
        }
    }
    public function createAction()
    {
        if ($this->request->isPost()) {
            $item = new Menus();
            $item->app_id = $this->session->get('auth-identity')['Application_ID'];
            $item->name = $this->request->getPost("name");
            $item->href = $this->request->getPost("href");
            $item->icon = $this->request->getPost("icon");
            $item->order = $this->request->getPost("order");
            $item->save();
            $this->flashSession->success($this->getTranslation()->_("Item was Added successfully"));
            return $this->response->redirect("menus/index");
        }
    }
}