<?php

namespace Vokuro\Ads\Controllers;

use Models\Content;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;
use Vokuro\Ads\Models\Settings;
use Vokuro\Controllers\ControllerBase;
use Vokuro\FileManager;
use Vokuro\Forms\Validations\AdsValidation;
use Vokuro\Models\Ads;
use Vokuro\Models\Modules;

class ManagerSettingsController extends ControllerBase
{

	public function indexAction()
	{
        $app_id = $this->auth->getIdentity()["Application_ID"];
        $this->view->settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();
	}

    public function updateAction()
    {
        $app_id = $this->auth->getIdentity()["Application_ID"];
        $settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

        if(!$settings){
            $settings = new Settings;
            $settings->application_id = $app_id;
        }


        $settings->enable_width = $this->request->getPost('enable_width');
        $settings->enable_height = $this->request->getPost('enable_height');
        $settings->enable_start_date = $this->request->getPost('enable_start_date');
        $settings->enable_end_date = $this->request->getPost('enable_end_date');
        $settings->enable_thumbnail = $this->request->getPost('enable_thumbnail');
        $settings->enable_section = $this->request->getPost('enable_section');
        $settings->enable_is_video = $this->request->getPost('enable_is_video');
        $settings->enable_content = $this->request->getPost('enable_content');
        $settings->enable_picture = $this->request->getPost('enable_picture');

        foreach($this->request->getUploadedFiles() as $file)
        {
            if($file->getKey() == "banner_image" && strlen($file->getName()) > 0)
            {
                
                $path = 'ads/img/' . rand(0, 10000) . $file->getname();

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