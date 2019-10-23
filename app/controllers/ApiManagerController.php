<?php

namespace Vokuro\Controllers;
use Phalcon\Http\Request;
use Phalcon\Mvc\Router\Group;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Mvc\Url;
use Vokuro\Forms\AdvancedSearchForm;
use Vokuro\Models\Projects;
use Vokuro\Pentavalue\Keyvalue;
use Phalcon\Mvc\Model\Query\Builder;
use DataTables\DataTable;
use \Api;
use \Screen;
use \ScreenMedia;
use Phalcon\Mvc\View;

class ApiManagerController extends ControllerApiBase{
    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';
    public function indexAction(){
        $projects = Projects::find(["order"=>"id"]);
        $this->view->projects = $projects;

    }
    public function groupAction(){

        $project_id = $this->request->getQuery("project_id");
        if(!$this->request->getQuery("group_id")){
            $group = \ApiGroup::findFirst(["project_id={$project_id}"]);
			if(!$group){
				$group_id = 1;
			}else{
            $group_id = $group->id;
			}
        }
        else{
            $group_id = $this->request->getQuery("group_id");
        }

        $project= Projects::findFirst(["id={$project_id}"]);
        $screens = Screen::find(["project_id={$project_id} and group_id={$group_id}"]);
        $project_attach= \ApiAppAttachments::find(["project_id={$project_id}"]);
        $project_groups = \ApiGroup::find(["project_id={$project_id}"]);
        $this->view->project_groups = $project_groups;
        $this->view->content = $screens;
        $this->view->project = $project;
        $this->view->group_id = $group_id;
        $this->view->project_attach = $project_attach;
        $this->view->project_id=$this->request->getQuery("project_id");
        return;
//        $project_id = $this->request->getQuery("project_id");
//        $apis = Api::find(["project_id={$project_id}", "group"=>"group"]);
//        $this->view->content = $apis;
//        $this->view->project_id = $project_id;
    }
    public function newAction(){

    }
    public function createAction(){
        if(!$this->request->isPost()){
            die();
        }
        //screenshots links
        $api = new Api();
        $api->title= $this->request->getPost("title");
        $api->des= $this->request->getPost("des");
        $api->project_id= $this->request->getPost("project_id");
        $api->success_response= $this->request->getPost("success_response");
        $api->fail_response= $this->request->getPost("fail_response");
        $api->empty_response= $this->request->getPost("empty_response");
        $screen = new Screen();
        $screen->project_id = $this->request->getPost("project_id");
        $screen->title=$this->request->getPost("screen_title");
        $screen->des=$this->request->getPost("screen_des");
        if (!$screen->save()) {
            foreach ($screen->getMessages() as $message) {
                $this->flashSession->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "api_manager",
                'action' => 'new'
            ]);

            return;
        }
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                $screen_media= new ScreenMedia();

                    $screen_media->title= $file->getName();
                    $screen_media->screen_id = $screen->id;
                    $screen_media->type = "img";
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $screen_media->media = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION .$random_name);
                    }

                if (!$screen_media->save()) {
                    foreach ($screen->getMessages() as $message) {
                        $this->flashSession->error($message);
                    }

                    $this->dispatcher->forward([
                        'controller' => "api_manager",
                        'action' => 'new'
                    ]);

                    return;
                }

            }

        }
        $api->screen_id= $screen->id;
        $api->type_method= $this->request->getPost("type_method");
        $api->api_link= $this->request->getPost("api_link");
        if (!$api->save()) {
            foreach ($api->getMessages() as $message) {
                $this->flashSession->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "api_manager",
                'action' => 'new'
            ]);

            return;
        }
        $this->flashSession->success("Api Added Successfully");
        $this->dispatcher->forward([
            'controller' => "api_manager",
            'action' => 'index'
        ]);
        return;
    }

    public function apiProjectAction(){
        $project_id = $this->request->getQuery("project_id");
        $apis = Api::find(["project_id={$project_id}"]);
        $this->view->content = $apis;
    }
    public function apiViewAction($api_id){
        $apis = Api::findFirst(["id={$api_id}"]);
        $this->view->content = $apis;
    }
    public function groupAddAction(){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        if(!$this->request->isPost()){
            die("get out");
        }
        $group= new \ApiGroup();
        $group->project_id = $this->request->getPost("project_id");
        $group->group_title = $this->request->getPost("group_title");
        $group->save();
       return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$group->project_id}");
    }
    public function pageAddAction(){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        if(!$this->request->isPost()){
            die("get out");
        }
        $screen = new Screen();
        $screen->title = $this->request->getPost("page_name");
        $screen->des = $this->request->getPost("page_desc");
        $screen->project_id = $this->request->getPost("project_id");
        $screen->group_id = $this->request->getPost("group_id");
        $screen->save();
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                $screen_media= new ScreenMedia();
                $screen_media->title= $this->request->getPost("screenshot_title");
                $screen_media->screen_id = $screen->id;
                $screen_media->type = "img";
                $random = new Random();
                $random_name = $random->uuid() . "." . $file->getExtension();
                if ($file->getName() != "") {
                    $screen_media->media = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION .$random_name);
                }

                if (!$screen_media->save()) {
                    foreach ($screen->getMessages() as $message) {
                        $this->flashSession->error($message);
                    }
                    return;
                }

            }

        }

        //return $this->response->redirect($_SERVER['HTTP_REFERER']);
        return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$screen->project_id}");
    }
    public function screenshotAddAction(){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        if(!$this->request->isPost()){
            die("get out");
        }
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                $screen_media= new ScreenMedia();
                $screen_media->title= $this->request->getPost("screenshot_title");
                $screen_media->screen_id = $this->request->getPost("screen_id");
                $screen_media->type = "img";
                $random = new Random();
                $random_name = $random->uuid() . "." . $file->getExtension();
                if ($file->getName() != "") {
                    $screen_media->media = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION .$random_name);
                }

                if (!$screen_media->save()) {
                    foreach ($screen_media->getMessages() as $message) {
                        $this->flashSession->error($message);
                    }
                    return;
                }

            }

        }

        return $this->response->redirect($_SERVER['HTTP_REFERER']);
        //return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$group->project_id}");
    }
    public function apiAddAction(){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        if(!$this->request->isPost()){
            die();
        }
        //screenshots links
        $api = new Api();
        $api->title= $this->request->getPost("api_title");
        $api->des= $this->request->getPost("api_des");
        $api->project_id= $this->request->getPost("project_id");
        $api->success_response= $this->request->getPost("success_response");
        $api->fail_response= $this->request->getPost("fail_response");
        $api->empty_response= $this->request->getPost("empty_response");
        $api->api_link= $this->request->getPost("api_link");
        $api->type_method= $this->request->getPost("api_method");
        $api->screen_id= $this->request->getPost("screen_id");
        $api->group= $this->request->getPost("group_id");
        if (!$api->save()) {
            foreach ($api->getMessages() as $message) {
                $this->flashSession->error($message);
            }
            return;
        }
        //saving params
        foreach ($this->request->getPost("param_ids") as $param_id){
            $param = new \ApiParam();
            $param->param_name = $this->request->getPost("param_name".$param_id);
            $param->param_des = $this->request->getPost("param_des".$param_id);
            $param->param_link = $this->request->getPost("param_link".$param_id);
            $param->api_id = $api->id;
            if (!$param->save()) {
                foreach ($param->getMessages() as $message) {
                    $this->flashSession->error($message);
                }
                return;
            }

            }
        //return $this->response->redirect($_SERVER['HTTP_REFERER']);
        return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$api->project_id}");
    }
    public function paramAddAction(){
    	
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        if(!$this->request->isPost()){
            die();
        }
        $param = new \ApiParam();
        $param->param_name = $this->request->getPost("param_name");
        $param->param_des = $this->request->getPost("param_des");
        $param->param_link = $this->request->getPost("param_link");
        $param->api_id = $this->request->getPost("param_api_id");
        if (!$param->save()) {
            foreach ($param->getMessages() as $message) {
                $this->flashSession->error($message);
            }
            return;
        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
        //return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$group->project_id}");
    }
    public function screenshotDeleteAction($id){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        $screen_media = ScreenMedia::findFirst(["id={$id}"]);
        $screen_media->delete();
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
        //return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$group->project_id}");

    }
    public function apiDeleteAction($id){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        $api = Api::findFirst(["id={$id}"]);
        $api->delete();
        $params = \ApiParam::find(["api_id={$id}"]);
        foreach ($params as $param){
            $param->delete();
        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
        //return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$group->project_id}");

    }
    public function screenDeleteAction($id){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        $screen = Screen::findFirst(["id={$id}"]);
        $screen->delete();
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
       // return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$group->project_id}");

    }
    public function groupDeleteAction($id){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        $group = \ApiGroup::findFirst(["id={$id}"]);
        $group->delete();
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
        //return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$group->project_id}");

    }
    public function paramDeleteAction($id){
    	if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
        $param = \ApiParam::findFirst(["id={$id}"]);
        $param->delete();
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
       // return $this->response->redirect("http://penta-test.com/robo_cms/api_manager/group?project_id={$group->project_id}");

    }
    public function saveAction(){
        if(!$this->request->isPost()){
            die();
        }
        $id= $this->request->getPost("id");
        $api = Api::findFirst(["id={$id}"]);
        $api->success_response = $this->request->getPost("success_response");
        $api->fail_response = $this->request->getPost("fail_response");
        $api->empty_response = $this->request->getPost("empty_response");
        $api->title = $this->request->getPost("title");
        $api->des = $this->request->getPost("des");
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                if ($file->getKey() == "Img") {
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $content->Img = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION .$random_name);
                    }
                }

            }

        }


    }
    
    public function editSuccessAction($api_id){
    	$this->view->setRenderLevel(
            View::LEVEL_ACTION_VIEW
        );
		if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
    	$api= Api::findFirst(["id={$api_id}"]);
		$this->view->api = $api;
    }
	
	public function editFailedAction($api_id){
    	$this->view->setRenderLevel(
            View::LEVEL_ACTION_VIEW
        );
		if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
    	$api= Api::findFirst(["id={$api_id}"]);
		$this->view->api = $api;
    }
	
	public function editEmptyAction($api_id){
    	$this->view->setRenderLevel(
            View::LEVEL_ACTION_VIEW
        );
		if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
    	$api= Api::findFirst(["id={$api_id}"]);
		$this->view->api = $api;
    }
	
	public function saveResponseAction(){
    	$this->view->setRenderLevel(
            View::LEVEL_ACTION_VIEW
        );
		if(!isset($this->session->get('auth-identity')['Application_ID'])){
    		die("You are not allowed to do this action now");
    	}
		$api_id= $this->request->getPost("id");
    	$api= Api::findFirst(["id={$api_id}"]);
		foreach ($this->request->getPost() as $key => $value) {
			if($key!=="id"){
				$api->$key = $value;
			}
		}
		if(!$api->save()){
			foreach ($api->getMessages() as $message) {
                $this->flashSession->error($message);
            }

		}
		$this->flashSession->success("Response Updated");
		return $this->response->redirect("api_manager/group?project_id={$api->project_id}");
		
    }

    //Application Attachments

    public function addAppAttachmentsAction(){
        if(!$this->request->isPost()){
            die();
        }
        $des= $this->request->getPost("des");
        $app_id= $this->request->getPost("project_id");
        $app_attach= new \ApiAppAttachments();
        $app_attach->des=$des;
        $app_attach->project_id=$app_id;
        $app_attach->type = "type";
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                if ($file->getKey() == "file") {
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $app_attach->file = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION .'api_files/'.$random_name);
                    }
                }


            }
        }
        if(!$app_attach->save()){
            foreach ($app_attach->getMessages() as $message){
                $this->flash->error($message);
            }
            die();
        }
        return $this->flash->success("New Entry Added");
    }

    public function editAppAttachmentsAction($id){
        if(!$this->request->isPost()){
            die();
        }
        $des= $this->request->getPost("Des");
        $app_attach= \ApiAppAttachments::findFirst(["id={$id}"]);
        $app_attach->des=$des;
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                if ($file->getKey() == "ios") {
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $app_attach->ios_slice = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION .$random_name);
                    }
                }
                elseif ($file->getKey() == "android") {
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $app_attach->android_slice = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION .$random_name);
                    }
                }
                elseif ($file->getKey() == "ux") {
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $app_attach->ux = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION .$random_name);
                    }
                }

            }
        }
        if(!$app_attach->save()){
            foreach ($app_attach->getMessages() as $message){
                $this->flash->error($message);
            }
            die();
        }
        return $this->flash->success("Entry Saved");
    }

    //Screen Attachments

    public function addScreenAttachmentsAction(){
        if(!$this->request->isPost()){
            die();
        }
        $screen_id= $this->request->getPost("screen_id");
        $app_id= $this->request->getPost("project_id");
        $app_attach=  new \ApiAppScreenAttachments();
        $app_attach->screen_id=$screen_id;
        $app_attach->project_id=$app_id;
        $app_attach->type ="type";
        $app_attach->des = $this->request->getPost("des");

        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                if ($file->getKey() == "file") {
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $app_attach->file = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION .'api_files/'.$random_name);
                    }
                }

            }
        }
        if(!$app_attach->save()){
            foreach ($app_attach->getMessages() as $message){
                $this->flash->error($message);
            }
            die();
        }
        return $this->flash->success("New Entry Added");
    }

    public function editScreenAttachmentsAction($id){
        if(!$this->request->isPost()){
            die();
        }
        $app_attach=  \ApiAppScreenAttachments::findFirst(["id={$id}"]);
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                if ($file->getKey() == "file") {
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();
                    if ($file->getName() != "") {
                        $app_attach->ios_slice = $random_name;
                        $file->moveTo(static::UPLOAD_LOCATION .$random_name);
                    }
                }

            }
        }
        if(!$app_attach->save()){
            foreach ($app_attach->getMessages() as $message){
                $this->flash->error($message);
            }
            die();
        }
        return $this->flash->success("New Entry Added");
    }

    public function screenShotCommentsAction($screenshot_id){
        $comments= \ApiAppScreenshotComments::find("screen_shot={$screenshot_id}");
        $screen_shot=ScreenMedia::findFirst(["id={$screenshot_id}"]);
        $this->view->screen_shot = $screen_shot->media;
        $this->view->comments = $comments;
        $this->view->screenshot_id = $screenshot_id;
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
    }
    public  function screenShotsCommentsAjaxAction($screenshot_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $comments= \ApiAppScreenshotComments::find("screen_shot={$screenshot_id}");
        $this->view->comments = $comments;
    }
    public function addCommentAjaxAction(){
        if(!$this->request->isPost()){
            die("Get out");
        }
        $this->view->disable();
        $comment = new \ApiAppScreenshotComments();
        $comment->comment = $this->request->getPost("comment");
        $comment->screen_shot = $this->request->getPost("screenshot_id");
        $comment->created_date=time();
        $comment->title=$this->request->getPost("title");
        if(!$comment->save()){
            foreach ($comment->getMessages() as $message){
                $this->flash->error($message);
            }
        };
        $this->flash->success("Saved");

    }


}