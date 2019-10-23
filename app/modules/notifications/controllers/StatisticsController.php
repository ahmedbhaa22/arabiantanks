<?php 

namespace Vokuro\Notifications\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\FileManager;
use Vokuro\Models\Modules;
use Vokuro\Notifications\Models\PushNotification;
use Vokuro\Notifications\Models\Settings;
use Vokuro\Notifications\Models\Token;
use Vokuro\Notifications\Models\User;
use Vokuro\Notifications\Models\UsersFollow;

/**
* 
*/
class StatisticsController extends ControllerBase
{
	public function indexAction()
	{

	}

	public function ajaxAction()
	{
		$app_id = $this->session->get('auth-identity')['Application_ID'];
		// return $this->sendJson($this->request->getPost(""));
		$data = [];

		// count age
		if($this->request->getPost('age')){
			$from = strtotime(date("Y-m-d") . " -{$this->request->getPost('age')} year");
			$age_to = $this->request->getPost('age') + 1;
			$to = strtotime(date("Y-m-d") . " -{$age_to} year");

			
			$data["age"] = $usersAdv = \UsersAdvanced::query()->where("Date_Birth > '{$from}'")->andWhere("Date_Birth < '{$to}'")->execute()->count();

		}

		// count male
		if($this->request->getPost('male')){
			$data["male"] = User::query()->where("Gender = 1")->execute()->count();
		}

		// count female
		if($this->request->getPost('female')){
			$data["female"] = User::query()->where("Gender = 0")->execute()->count();
		}

		// count guests
		if($this->request->getPost('send_to_guests')){
			$data["guests"] = Token::query()->where("User_ID = 0")->andWhere("Application_ID = {$app_id}")->execute()->count();
		}

		// count custom filters
		if($this->request->getPost('module_id') && $this->request->getPost('filter')){
			$module_id = $this->request->getPost('module_id');
			foreach($this->request->getPost('filter') as $filter){
				$data["filter"][$filter] = UsersFollow::query()->where("type = {$filter}")->andWhere("module_id = {$module_id}")->andWhere("application_id = {$app_id}")->execute()->count();
			}
		}

		return $this->sendJson($data);
	}
}