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

		$settings->android_app_key = $this->request->getPost('android_app_key');
		$settings->iphone_bundle_id = $this->request->getPost('iphone_bundle_id');
		$settings->sandbox_passphrase = $this->request->getPost('sandbox_passphrase');
		$settings->production_passphrase = $this->request->getPost('production_passphrase');
		$settings->enable_sandbox = $this->request->getPost('enable_sandbox') ?: 0;
		$settings->enable_production = $this->request->getPost('enable_production') ?: 0;
		$settings->smtp_server = $this->request->getPost('smtp_server');
		$settings->smtp_port = $this->request->getPost('smtp_port');
		$settings->smtp_username = $this->request->getPost('smtp_username');
		$settings->smtp_password = $this->request->getPost('smtp_password');
		$settings->mail_from_name = $this->request->getPost('mail_from_name');
		$settings->mail_from_email = $this->request->getPost('mail_from_email');


		foreach($this->request->getUploadedFiles() as $file)
		{
		    if($file->getKey() == "sandbox_certificate" && strlen($file->getName()) > 0)
		    {
		        
		        $path = 'notifications/files/' . rand(0, 10000) . $file->getname();

		        $isUploaded = FileManager::moveFile($path, $file);

		        if($isUploaded){
		            $settings->sandbox_certificate = $path;
		        } 
		    }

		    if($file->getKey() == "production_certificate" && strlen($file->getName()) > 0)
		    {
		        
		        $path = 'notifications/files/' . rand(0, 10000) . $file->getname();

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