<?php

namespace Vokuro\Controllers;

use Models\Content;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;
use Vokuro\FileManager;
use Vokuro\Forms\Validations\AdsValidation;
use Vokuro\Models\Ads;
use Vokuro\Models\Modules;

class AdsController extends ControllerBase
{

	/**
	 * loads the ads list view
	 */
	public function indexAction()
	{

        $ads = Ads::find(array(
            "application_id = {$this->session->get('auth-identity')['Application_ID']}",
            "order" =>"id Desc"
        ));

        $currentPage = isset($_GET['page']) ? $_GET['page'] : 1 ;
        $paginator = new PaginatorModel(
            [
                "data"  => $ads,
                "limit" => 10,
                "page"  => $currentPage,
            ]
        );

        $this->view->page = $paginator->getPaginate();
	}

	/**
	 * loads the ad creation form
	 */
	public function createAction()
	{
		$this->view->modules = Modules::find(array(
		    "application_id={$this->session->get('auth-identity')['Application_ID']}"
        ));
	}

	/**
	 * stores ads resource in database
	 */
	public function storeAction()
	{
        $this->view->disable();
		// check if request is post
    	if ($this->request->isPost()) {
            //Content ID
            //$this->request->getPost("Content_ID"));
    		// save form
    		$data = $this->request->getPost();
            $validator = new AdsValidation();

            $messages = $validator->validate($data);
            if (count($messages)) {
                $result = [];
                if (count($messages)) {
                    foreach ($messages as $message) {
                        $result = $message;
                    }
                }

                $this->messages = $messages;
                $this->response->redirect('ads/create'); ;
            }

            // save form
    		$ad = new Ads;
    		$ad->title     = $data['title'];
    		$ad->des       = $data['description'];
    		$ad->width     = $data['width'];
    		$ad->height    = $data['height'];
    		$ad->module_id = $data['module_id'];
            $ad->application_id = $this->session->get('auth-identity')['Application_ID'];
    		$ad->link      = $data['link'];
    		;

    	    // check if there is any file
    	    if($this->request->hasFiles() == true){
    	        $uploads = $this->request->getUploadedFiles();

    	        // #do a loop to handle each file individually
    	        foreach($uploads as $file){
    	            
    	            $path = 'uploads/amodule/' . md5(uniqid(rand(), true)). '-' .strtolower($file->getname());

    	        	$isUploaded = FileManager::moveFile($path,  $file);

    	        	if($isUploaded){
    	        		$ad->img = $path;
    	        		$ad->save();
    	        	} 
    	        }

    	    }
    	    // return response
		    $this->response->redirect('ads'); 
    	}
	}

    public function editAction($id)
    {
        $ad = Ads::findFirst($id);

        $this->view->modules = Modules::find(array(
            "application_id ={$this->session->get('auth-identity')['Application_ID']}"
        ));

        $this->view->ad = $ad;
    }

    public function updateAction($id)
    {

        if ($this->request->isPost()) {
            // save form
            $data = $this->request->getPost();
            $ad = Ads::findFirst($id);
            $ad->title     = $data['title'];
            $ad->des       = $data['description'];
            $ad->width     = $data['width'];
            $ad->height    = $data['height'];
            $ad->module_id = $data['module_id'];
            $ad->application_id = $this->session->get('auth-identity')['Application_ID'];
            $ad->link      = $data['link'];
            $ad->save();

            // check if there is any file
            if($this->request->hasFiles() == true){
                FileManager::delete($ad->Img);
                
                $uploads = $this->request->getUploadedFiles();

                // #do a loop to handle each file individually
                foreach($uploads as $file){
                    
                    $path = 'uploads/amodule/' . md5(uniqid(rand(), true)). '-' .strtolower($file->getname());

                    $isUploaded = FileManager::moveFile($path,  $file);

                    if($isUploaded){
                        $ad->img = $path;
                        $ad->save();
                    } 
                }

            }
            // return response
            $this->response->redirect('ads'); 
        }
    }

    public function deleteAction($id)
    {
        Ads::findFirst($id)->delete();
        return $this->sendJson("deleted successfully");
    }

    public function getDepartmentsAjaxAction(){
        if($this->request->getPost("get_option")==""){return "";};
        $Module_ID=$this->request->getPost("get_option");
        $big_array = array();
        $main_depts = \DataCmsDepts::find(array("Module_ID={$Module_ID}"));
        if (count($main_depts)==0){return "";}
        foreach ($main_depts as $main_dept){
            $big_array[] = array(
              "MainDept" => $main_dept->Title,
              "Cats"=> $this->buildDeptsTree(\DataCmsDeptsRel::find(["Core_Depts_ID={$main_dept->ID}"]))
            );
        }
        return \CmsHelpers::ajaxDeptsTree($big_array);

    }

    public function getAjaxContentByModuleAction($Module_ID){
        $content = Content::find(array(
           "Module_ID={$Module_ID}"
        ));
        $response = '{"suggestions": [';
        foreach ($content as $item){
            $response.= '{ "value": "'.$item->Title.'", "data": "'.$item->ID.'" },';
        }
        $response .= '{ "value": "", "data": "" }]}';
        $json ='
        {"suggestions": [
        { "value": "'.$Module_ID.'", "data": "AE" },
        { "value": "United Kingdom",       "data": "UK" },
        { "value": "United States",        "data": "US" }
    ]
}
        ';
        return $response;
    }

    public function buildDeptsTree($depts, $parentId = 0)
    {
        $big_array=array();
        foreach ($depts as $dept) {
            if ($dept->Parent_Depts_ID == $parentId) {
                $big_array[]=  array(
                    "Dep_ID" => $dept->ID,
                    "Dep_Title" => $dept->Title,
                    "Dep_Children" => $this->buildDeptsTree(\DataCmsDeptsRel::find(),$dept->ID)
                );
            }

        }
        return $big_array;

    }

}