<?php

namespace Vokuro\Ads\Controllers;

use Models\Content;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;
use Vokuro\Ads\Models\AdsTransformer;
use Vokuro\Ads\Models\Settings;
use Vokuro\Controllers\ControllerBase;
use Vokuro\FileManager;
use Vokuro\Forms\Validations\AdsValidation;
use Vokuro\Models\Ads;
use Vokuro\Models\Modules;

class ApiController extends ApiControllerBase
{

    // public function beforeExecuteRoute($dispatcher)
    // {
    //     // validate token
    //     $token = $this->request->getQuery("token");

    //     $user = $this->jwtService->getActiveUser($token);
    //     // die(var_dump($user));
    //     if($user){
    //         $this->user = $user;
    //     }else{
    //         $this->sendJson(["error" => "invalid token"]);
    //         echo json_encode(["error" => "invalid token"]);
    //         die();
    //     }
    // }

	/**
	 * loads the ads list view
	 */
	public function indexAction()
	{
        // $app_id = $this->user->Application_ID;
        $app_id = 1;
        
        $ads = Ads::find(array(
            "application_id = {$app_id}",
            "order" =>"id Desc"
        ));

        $trans = new AdsTransformer;
        $response = [
            "status" => $this->apiFactory->getStatus(200, "Success"),
            "content" => $trans->transformResultSet($ads)
        ];

        return $this->sendJson($response);
	}

    public function viewAction($id)
    {
        $ad = Ads::findFirst($id);

        $response = [
            "status" => $this->apiFactory->getStatus(200, "Success"),
            "data" => $ad
        ];

        return $this->sendJson($response);
    }

	/**
	 * stores ads resource in database
	 */
	public function storeAction()
	{
		// check if request is post
    	if ($this->request->isPost()) {
            //Content ID

            // save form
            $data = json_decode($this->request->getPost("dataArray"), true);
            $validator = new AdsValidation();

            $messages = $validator->validate($data);

            if(count($messages)){
                $errors = [];
                foreach ($messages as $msg) {
                    $errors[] = (string)$msg;
                }

                $data = [
                    "code" => 400,
                    "message" => "Validation Error",
                    "errors" => $errors
                ];

                return $this->sendJson($data);
            }

            // save form
    		$ad = new Ads;
    		$ad->title     = $data['title'];
    		$ad->des       = $data['description'];
    		$ad->width     = $data['width'];
    		$ad->height    = $data['height'];
            $ad->module_id = $data['module_id'];
            $ad->startdate = $data['startdate'];
            $ad->enddate   = $data['enddate'];
    		$ad->is_video  = $this->request->getPost('is_video') ?: 0;
            $ad->application_id = $this->session->get('auth-identity')['Application_ID'];
    		$ad->link      = $data['link'];
            $ad->save();

            // die(var_dump($ad));

    	    // check if there is any file
    	    if(isset($data["img"])){
                $image64 = base64_decode($data["img"]);

                // $url = "product-".str_random(). '.png';

                $path = 'uploads/ads/files/' . md5(uniqid(rand(), true)) . ".jpeg";
                // dd($path . ".jpeg");
                $result = file_put_contents($path, $image64);

                $ad->img = $path;
                $ad->save();
            }

            if(isset($data["thumbnail"])){
                $image64 = base64_decode($data["thumbnail"]);

                // $url = "product-".str_random(). '.png';

                $path = 'uploads/ads/files/' . md5(uniqid(rand(), true)) . ".jpeg";
                // dd($path . ".jpeg");
                $result = file_put_contents($path, $image64);

                $ad->thumbnail = $path;
                $ad->save();
            }

    	}
	}

    public function updateAction($id)
    {

        if ($this->request->isPost()) {
            // save form
            $data = json_decode($this->request->getPost("dataArray"), true);

            $validator = new AdsValidation();

            $messages = $validator->validate($data);

            if(count($messages)){
                $errors = [];
                foreach ($messages as $msg) {
                    $errors[] = (string)$msg;
                }

                $data = [
                    "code" => 400,
                    "message" => "Validation Error",
                    "errors" => $errors
                ];

                return $this->sendJson($data);
            }

            $ad = Ads::findFirst($id);
            $ad->title     = $data['title'];
            $ad->des       = $data['description'];
            $ad->width     = $data['width'];
            $ad->height    = $data['height'];
            $ad->module_id = $data['module_id'];
            $ad->link      = $data['link'];
            $ad->startdate = $data['startdate'];
            $ad->enddate   = $data['enddate'];
            $ad->is_video  = $this->request->getPost('is_video') ?: 0;
            $ad->save();

            // check if there is any file
            if(isset($data["img"])){
                FileManager::delete($ad->img);
                $image64 = base64_decode($data["img"]);

                // $url = "product-".str_random(). '.png';

                $path = 'uploads/ads/files/' . md5(uniqid(rand(), true)) . ".jpeg";
                // dd($path . ".jpeg");
                $result = file_put_contents($path, $image64);

                $ad->img = $path;
                $ad->save();
            }

            if(isset($data["thumbnail"])){
                FileManager::delete($ad->thumbnail);
                $image64 = base64_decode($data["thumbnail"]);

                // $url = "product-".str_random(). '.png';

                $path = 'uploads/ads/files/' . md5(uniqid(rand(), true)) . ".jpeg";
                // dd($path . ".jpeg");
                $result = file_put_contents($path, $image64);

                $ad->thumbnail = $path;
                $ad->save();
            }


        }
    }

    public function deleteAction($id)
    {
        Ads::findFirst($id)->delete();

        $data = [
            "code" => 200,
            "message" => "Success"
        ];

        return $this->sendJson($data);
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