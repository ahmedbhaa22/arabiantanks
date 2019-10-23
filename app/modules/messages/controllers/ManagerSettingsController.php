<?php

namespace Vokuro\Messages\Controllers;

use Models\Content;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;
use Vokuro\Messages\Models\Settings;
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

    public function updateAction($id)
    {
        $app_id = $this->auth->getIdentity()["Application_ID"];
        $settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

        if(!$settings){
            $settings = new Settings;
            $settings->application_id = $app_id;
        }


        $settings->db_type = $this->request->getPost('db_type');
        $settings->chat_type = $this->request->getPost('chat_type');

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

        return $this->response->redirect("manager_settings");
    }

}