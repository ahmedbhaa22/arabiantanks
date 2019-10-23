<?php 

namespace Vokuro\Geo\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\FileManager;
use Vokuro\Geo\Models\GeoLangs;
use Vokuro\Geo\Models\Settings;
use Vokuro\Models\Modules;

/**
* 
*/
class ManagerSettingsController extends ControllerBase
{
	public function indexAction()
	{
		$app_id = $this->auth->getIdentity()["Application_ID"];
		$settings =  Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();
		$this->view->langs = \Languages::find();
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

		$settings->enable_continents = $this->request->getPost('enable_continents') ?: 0;
		$settings->enable_countries = $this->request->getPost('enable_countries') ?: 0;
		$settings->enable_states = $this->request->getPost('enable_states') ?: 0;
		$settings->enable_city = $this->request->getPost('enable_city') ?: 0;
		$settings->enable_regions = $this->request->getPost('enable_regions') ?: 0;
		$settings->enable_streets = $this->request->getPost('enable_streets') ?: 0;

		$settings->langsPivot->delete();
		// die(var_dump($this->request->getPost()));
		foreach ($this->request->getPost('langs') as $key => $lang) {
			$new_lang = new GeoLangs;
			$new_lang->lang_id = $lang;
			$new_lang->setting_id = $settings->id;
			$new_lang->save();
			// die(var_dump($new_lang));
		}

		foreach($this->request->getUploadedFiles() as $file)
		{
		    if($file->getKey() == "banner_image" && strlen($file->getName()) > 0)
		    {
		        
		        $path = 'geo/files/' . rand(0, 10000) . $file->getname();

		        $isUploaded = FileManager::moveFile($path, $file);

		        if($isUploaded){
		            $settings->banner_image = $path;
		        } 
		    }

		    if($file->getKey() == "modal_image" && strlen($file->getName()) > 0)
		    {
		        
		        $path = 'geo/files/' . rand(0, 10000) . $file->getname();

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
