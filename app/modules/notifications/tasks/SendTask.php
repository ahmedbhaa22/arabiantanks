<?php

use Carbon\Carbon;
use Phalcon\Cli\Task;
use Vokuro\FileManager;
use Vokuro\Notifications\Models\Archive;
use Vokuro\Notifications\Models\PushNotification;
use Vokuro\Notifications\Models\PushNotificationQueue;
use Vokuro\Notifications\Models\TokenDelivery;
use Vokuro\Notifications\Services\NotificationService;

class SendTask extends Task
{
	
	function mainAction()
	{
		$ns = new NotificationService();
		// pull out of queue and push accordingly
		$queue = PushNotificationQueue::find();
		// echo $queue->count();
		foreach ($queue as $msg) {
			$ns->pushMessage($msg);
			
			// archive msg
			$archive = new Archive();
			$archive->User_ID = $msg->User_ID;
			$archive->Msg_ID = $msg->Msg_ID;
			$archive->Token_ID = $msg->Token_ID; // null if email or sms
			$archive->save();

			// add the same to token delivery
			$delivery = new TokenDelivery;
			$delivery->User_ID = $msg->User_ID;
			$delivery->Msg_ID = $msg->Msg_ID;
			$delivery->Token_ID = $msg->Token_ID; // null if email or sms
			$delivery->Msg_Count = 1;
			$delivery->save();

			// delete from queue
			$msg->delete();
		}
	}

}