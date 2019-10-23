<?php 

namespace Vokuro\Notifications\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\FileManager;
use Vokuro\Models\Modules;
use Vokuro\Notifications\Models\PushNotification;
use Vokuro\Notifications\Models\Settings;

/**
* 
*/
class SettingsController extends ControllerBase
{
	public function indexAction()
	{
		$this->view->settings = Settings::findFirst();
	}

	public function updateAction()
	{
		$settings = Settings::findFirst();

		if(!$settings){
			$settings = new Settings;
		}

		$settings->android_app_key = $this->request->getPost('android_app_key');
		$settings->iphone_bundle_id = $this->request->getPost('iphone_bundle_id');
		$settings->sandbox_passphrase = $this->request->getPost('sandbox_passphrase');
		$settings->production_passphrase = $this->request->getPost('production_passphrase');
		$settings->enable_sandbox = $this->request->getPost('enable_sandbox') ?: 0;
		$settings->enable_production = $this->request->getPost('enable_production') ?: 0;
		foreach($this->request->getUploadedFiles() as $file)
		{
		    if($file->getKey() == "sandbox_certificate" && strlen($file->getName()) > 0)
		    {
		        
		        $path = 'notifications/files/' . $file->getname();

		        $isUploaded = FileManager::moveFile($path, $file);

		        if($isUploaded){
		            $settings->sandbox_certificate = $path;
		        } 
		    }

		    if($file->getKey() == "production_certificate" && strlen($file->getName()) > 0)
		    {
		        
		        $path = 'notifications/files/' . $file->getname();

		        $isUploaded = FileManager::moveFile($path,  $file);

		        if($isUploaded){
		            $settings->production_certificate = $path;
		        } 
		    }
		}
		
		$settings->save();

		$this->response->redirect('settings');
	}
}