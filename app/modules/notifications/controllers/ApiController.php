<?php 

namespace Vokuro\Notifications\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\Models\Modules;
use Vokuro\Notifications\Controllers\ControllerApiBase;
use Vokuro\Notifications\Models\PushNotification;
use Vokuro\Notifications\Models\Token;
use Vokuro\Notifications\Models\User;

/**
* 
*/
class ApiController extends ControllerApiBase
{
	public function tokenAction()
	{
		$this->view->disable();

		$user_id = $this->request->getPost("user_id") ?: 0;
		$device_type = $this->request->getPost('device_type'); // 1 ios, 2 android
		$device_token = $this->request->getPost('token');

		$token = new Token;
		$token->Token = $device_token;
		$token->Type = $device_type;
		$token->Token_MD5 = md5($device_token);
		$token->Application_ID = $this->request->getPost("application_id");
		$token->User_ID = 0;
		
		if($token->save()){
			return $this->sendJson(["success" => true, "message" => "Successfully added"]);
		}else{
			return $this->sendJson(["success" => false, "message" => "Error"]);
		}

		// $user = User::findFirst($user_id);
		// if($device_type == 1 && $user->iosTokens){
		// 	$token = $user->iosTokens->getFirst();
		// 	$token->Token = $token;
		// 	$token->save();
		// }else{
		// 	// create new token
		// }

		// if($device_type == 2 && $user->androidTokens){
		// 	$token = $user->androidTokens->getFirst();
		// 	$token->Token = $token;
		// 	$token->save();
		// }else{
		// 	// create new token
		// }
	}
}