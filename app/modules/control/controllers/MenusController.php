<?php

namespace Vokuro\Control\Controllers;

use Vokuro\Models\Menus;
use Phalcon\Http\Request;
use Phalcon\Security;
use Phalcon\Mvc\Url;
use Models\DataCmsMenus;


class MenusController extends ModuleBase
{


    public function mainAction(){
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $menus= DataCmsMenus::find(["application_id={$app_id}"]);
        $this->view->menus = $menus;
    }

    public function indexAction($menu_id){
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $menu = Menus::find(array("app_id={$app_id} and menu_cms_id={$menu_id}"));
        $this->view->menu = $menu;
        $this->view->menu_cms_id = $menu_id;
    }
    public function editAction($id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $item = Menus::findFirst(array("app_id={$app_id} and id={$id}"));
        $this->tag->setDefault("id",$item->id);
        $this->tag->setDefault("name",$item->name);
        $this->tag->setDefault("href",$item->href);
        $this->tag->setDefault("other_icon",$item->icon);

    }

    public function editMenuAction($id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $item = DataCmsMenus::findFirst(array("application_id={$app_id} and id={$id}"));
        $this->tag->setDefault("menu_id",$item->id);
        $this->tag->setDefault("menu_name",$item->menu_name);
        $this->view->menu_id = $item->id;

    }
    public function deleteAction($id){
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $item = Menus::findFirst(array("app_id={$app_id} and id={$id}"));
        $item->delete();
        $this->flashSession->success($this->getTranslation()->_("Item was deleted successfully"));
        return $this->response->redirect("menus/main/");
    }


    public function deleteMenuAction($id){
        $app_id = $this->session->get('auth-identity')['Application_ID'];
        $item = DataCMsMenus::findFirst(array("application_id={$app_id} and id={$id}"));
        $items = Menus::find(array("app_id={$app_id}"));
        if(count($items)>0){
            $items->delete();
        }
        $item->delete();
        $this->flashSession->success($this->getTranslation()->_("Item was deleted successfully"));
        return $this->response->redirect("menus/main/");
    }
    public function newAction($menu_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
		$this->view->menu_id = $menu_id;
    }
    public function newMenuAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
    }

    public function saveMenuAction(){
        if ($this->request->isPost()){
            $id=$this->request->getPost("menu_id");
            $item = DataCmsMenus::findFirst(array("id={$id}"));
            $item->menu_name = $this->request->getPost("menu_name");
            $item->save();
            $this->flashSession->success($this->getTranslation()->_("Menu was saved successfully"));
            return $this->response->redirect("menus/main");
        }
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
            if(!empty($this->request->getPost('other_icon'))){
                $item->icon = $this->request->getPost("other_icon");
            }else{
                $item->icon = $this->request->getPost("icon");
            }

            $item->order = $this->request->getPost("order");
			$item->menu_cms_id = $this->request->getPost("menu_id");
            $item->save();
            $this->flashSession->success($this->getTranslation()->_("Item was Added successfully"));
            return $this->response->redirect("menus/main");
        }
    }
    public function createMenuAction()
    {
        if ($this->request->isPost()) {
            $item = new DataCmsMenus();
            $item->application_id = $this->session->get('auth-identity')['Application_ID'];
            $item->menu_name = $this->request->getPost("menu_name");
            $item->save();
            $this->flashSession->success($this->getTranslation()->_("Item was Added successfully"));
            return $this->response->redirect("menus/main");
        }
    }

	public function fixAction(){
		$items = Menus::find(["app_id={$this->session->get('auth-identity')['Application_ID']}"]);
		foreach ($items as $key => $value) {
			$value->menu_cms_id = 2 ;
			$value->save();
		}
	}
}