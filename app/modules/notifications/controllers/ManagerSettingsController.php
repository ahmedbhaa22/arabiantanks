<?php 

namespace Vokuro\Notifications\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\FileManager;
use Vokuro\Models\Modules;
use Vokuro\Notifications\Models\FollowPermissions;
use Vokuro\Notifications\Models\FollowTypes;
use Vokuro\Notifications\Models\PushNotification;
use Vokuro\Notifications\Models\Settings;

/**
* 
*/
class ManagerSettingsController extends ControllerBase
{
	public function indexAction()
	{
		$app_id = $this->auth->getIdentity()["Application_ID"];
		$settings =  Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

		$follow_types = FollowTypes::find();

		// die(var_dump($follow_types->count()));
		$this->view->settings = $settings;
		$this->view->follow_types = $follow_types;
	}

	public function updateAction()
	{
		$app_id = $this->auth->getIdentity()["Application_ID"];
		$settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

		if(!$settings){
			$settings = new Settings;
			$settings->application_id = $app_id;
		}

		$settings->enable_schedueling = $this->request->getPost('enable_schedueling') ?: 0;
		$settings->enable_statistics = $this->request->getPost('enable_statistics') ?: 0;
		$settings->use_default_kv = $this->request->getPost('use_default_kv') ?: 0;
		$settings->filter_mf = $this->request->getPost('filter_mf') ?: 0;
		$settings->filter_like = $this->request->getPost('filter_like') ?: 0;
		$settings->filter_favourite = $this->request->getPost('filter_favourite') ?: 0;
		$settings->filter_guests = $this->request->getPost('filter_guests') ?: 0;

		$settings->permissionsPivot->delete();
		foreach ($this->request->getPost('filter') as $key => $filter) {
			$follow = new FollowPermissions;
			$follow->setting_id = $settings->id;
			$follow->follow_id = $filter;
			$follow->save();
		}

		foreach($this->request->getUploadedFiles() as $file)
		{
		    if($file->getKey() == "banner_image" && strlen($file->getName()) > 0)
		    {
		        
		        $path = 'notifications/files/' . rand(0, 10000) . $file->getname();

		        $isUploaded = FileManager::moveFile($path, $file);

		        if($isUploaded){
		            $settings->banner_image = $path;
		        } 
		    }
		}

		
		$settings->save();

		$this->response->redirect('manager_settings');
	}
}