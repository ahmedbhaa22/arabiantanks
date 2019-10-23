<?php

namespace Vokuro\Polls\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\FileManager;
use Vokuro\Polls\Models\Polls;
use Vokuro\Polls\Models\Settings;

class ManagerSettingsController extends ControllerBase
{

	public function indexAction()
	{
        $app_id = $this->auth->getIdentity()["Application_ID"];
        $settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();
        if(!$settings){
            $settings = new Settings;
            $settings->application_id = $app_id;
            $settings->save();
        }

        $this->view->settings = $settings;
	}

    public function updateAction()
    {
        $app_id = $this->auth->getIdentity()["Application_ID"];
        $settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

        if(!$settings){
            $settings = new Settings;
            $settings->application_id = $app_id;
        }


        $settings->use_fb = $this->request->getPost('use_fb');
        $settings->fb_url = $this->request->getPost('fb_url');
        $settings->fb_token = $this->request->getPost('fb_token');
        $settings->fb_api_key = $this->request->getPost('fb_api_key');
        $settings->fb_db_url = $this->request->getPost('fb_db_url');
        $settings->fb_storage = $this->request->getPost('fb_storage');
        $settings->fb_project_id = $this->request->getPost('fb_project_id');
        $settings->fb_bucket_name = $this->request->getPost('fb_bucket_name');
        $settings->fb_service_key = $this->request->getPost('fb_service_key');

        foreach($this->request->getUploadedFiles() as $file)
        {
            if($file->getKey() == "banner_image" && strlen($file->getName()) > 0)
            {
                
                $path = 'msg/img/' . rand(0, 10000) . $file->getname();

                $isUploaded = FileManager::moveFile($path, $file);

                if($isUploaded){
                    $settings->banner_image = $path;
                } 
            }
        }

        $settings->save();
        // die(var_dump($settings));
        return $this->response->redirect("manager_settings");
    }

}

