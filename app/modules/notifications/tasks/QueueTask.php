<?php

use Carbon\Carbon;
use Models\UsersMobile;
use Phalcon\Cli\Task;
use Vokuro\FileManager;
use Vokuro\Notifications\Models\PushNotification;
use Vokuro\Notifications\Models\PushNotificationQueue;
use Vokuro\Notifications\Models\Token;
use Vokuro\Notifications\Models\User;
use Vokuro\Notifications\Models\UsersFollow;
use Vokuro\Notifications\Services\NotificationService;

class QueueTask extends Task
{
	
	function mainAction()
	{
		// get unqueued messages and loop them
		$now = time();
		$messages = PushNotification::query()->where("queued = 0")->andWhere("Send_Time < {$now}")->execute();
		// die(var_dump($messages));
		foreach ($messages as $message) {

			// get matching users to criteria
			$users = User::query();

			// filter gender
			if(!($message->Male && $message->Female)){
				if($message->Male){
				    $users = $users->andWhere("Gender = 1");
				}
				if($message->Female){
				    $users = $users->andWhere("Gender = 0");
				}
			}

			// filter age
			// if($message->Age){
			// 	$from = strtotime(date("Y-m-d") . " -{$message->Age} year");
			// 	$age_to = $message->Age + 1;
			// 	$to = strtotime(date("Y-m-d") . " -{$age_to} year");

			// 	$usersAdv = \UsersAdvanced::query()->where("Date_Birth > {$from}")->andWhere("Date_Birth < {$to}")->execute();
			// 	$uids = array_map(function($item){
			// 		return $item["user_id"];
			// 	}, $usersAdv->toArray());
			// 	$uids = implode(",", $uids);
			// 	if(!empty($uids)){
			// 		$users = $users->andWhere("ID IN ({$uids})");
			// 	}
			// }

			// filter custom filters
			$application_id = $message->Application_ID;
			$module_id = $message->Module_ID;
			// if($module_id){
			// 	$filters = [];
			// 	foreach ($message->filters as $key => $filter) {
			// 		// get ids for each user
			// 		$filters[] = $filter->id;
			// 	}
			// 	// die(var_dump($message->filters));
			// 	$filters = implode(",", $filters);
			// 	$users_follow = UsersFollow::query()->where("module_id = {$module_id}")->andWhere("application_id = {$application_id}")->execute();

			// 	$users_ids = array_map(function($item){
			// 		return $item["user_id"];
			// 	}, $users_follow->toArray());
			// 	if(!empty($users_ids)){
			// 		$users_ids = implode(",", $users_ids);
			// 		$users->andWhere("ID IN ({$users_ids})");
			// 	}
			// }



			$users = $users->execute();

			// get notification types / devices
			$types = explode(",", $message->notification_type);


			// add users to queue
			foreach ($users as $user) {
				foreach ($types as $type) {
				    $queue = new PushNotificationQueue;
				    $queue->Type = $type;
				    $queue->Token = $user->getQueueToken($type); // TODO: get other tokens
				    $queue->Msg_ID = $message->ID;
				    $queue->User_ID = $user->ID;
				    $queue->Token_ID = $user->getQueueTokenID($type);
				    $queue->save();
				}
			}

			if($message->send_to_guests){
				// select all tokens
				$tokens = Token::query()->where("User_ID = 0")->andWhere("Application_ID = {$message->Application_ID}")->execute();
				foreach ($tokens as $token) {
					$queue = new PushNotificationQueue;
				    $queue->Type = $token->Type;
				    $queue->Token = $token->Token;
				    $queue->Msg_ID = $message->ID;
				    $queue->Token_ID = $token->ID;
				    $queue->save();
				}
			}

			$message->queued = 1;
			$message->save();
		}
	}

}