<?php 

namespace Vokuro\Notifications\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\Models\DataCms;
use Vokuro\Models\Modules;
use Vokuro\Notifications\Models\FollowTypes;
use Vokuro\Notifications\Models\MessageFilters;
use Vokuro\Notifications\Models\PushNotification;
use Vokuro\Notifications\Models\PushNotificationQueue;
use Vokuro\Notifications\Models\Settings;
use Vokuro\Notifications\Models\Token;
use Vokuro\Notifications\Models\User;

/**
* 
*/
class IndexController extends ControllerBase
{
	public function indexAction()
	{
		$app_id = $this->session->get('auth-identity')['Application_ID'];

            $this->view->settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();
            // die(var_dump($this->view->settings->banner_image));
		if($app_id){
			$modules = Modules::find(array(
	    	    "application_id={$app_id}"
	        ));
	    	$this->view->modules = $modules;
		}else{
			$this->view->modules = [];
		}
		

		$this->view->notifications = PushNotification::query()->where("Application_ID = {$app_id}")->execute();
	}

	public function createAction()
	{
		$app_id = $this->session->get('auth-identity')['Application_ID'];

            $follow_types = FollowTypes::find();
            $this->view->follow_types = $follow_types;

		$this->view->settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();
		if($app_id){
			$modules = Modules::find(array(
	    	    "application_id={$app_id}"
	        ));
	    	$this->view->modules = $modules;
		}else{
			$this->view->modules = [];
		}
	}

	public function storeAction()
	{
		

		// check if request is post
    	if ($this->request->isPost()) {
            //validate
            $user = $this->auth->getIdentity();
    	    // add push notification message
            $notification = new PushNotification;
            $notification->Admin_ID = $this->auth->getIdentity()['id'];
            $notification->Age = $this->request->getPost('age');
            // $notification->Like = $this->request->getPost('like') ?: 0;
            // $notification->Favourite = $this->request->getPost('favourite') ?: 0;
            $notification->Male = $this->request->getPost('male') ?: 0;
            $notification->Female = $this->request->getPost('female') ?: 0;
            $notification->send_to_guests = $this->request->getPost('send_to_guests') ?: 0;
            $notification->Application_ID = $user["Application_ID"];
            $notification->Module_ID = $this->request->getPost('module_id');
            $notification->topic_id = $this->request->getPost('topic_id');
            $notification->Message = $this->request->getPost('message');
            $notification->Send_Time = strtotime(str_replace("/", "-", $this->request->getPost('send_time')));
            $notification->notification_type = implode(",", $this->request->getPost('notification_type'));

            
            if($this->request->getPost('key') && $this->request->getPost('value')){
            	$values = $this->request->getPost('value');
            	$kv_pair = [];
            	foreach ($this->request->getPost('key') as $k => $key) {
            		if(!empty($key)){
            			$kv_pair[$key] = $values[$k];
            		}
            	}

	            $notification->kv = json_encode($kv_pair);
            }

            $notification->save();

            foreach ($this->request->getPost('filter') as $key => $filter) {
                  $not_filter = new MessageFilters;
                  $not_filter->message_id = $notification->ID;
                  $not_filter->follow_id = $filter;
                  $not_filter->save();
                  // die(var_dump($not_filter));
            }

            // if(!$this->request->getPost('send_time')){
            // 	// mark it as queued and queue immediatly
            // 	$notification->queued = 1;
            // 	$notification->save();

            // 	$users = User::query();
            // 	if($notification->Male){
            // 	    $users = $users->andWhere("Gender = 1");
            // 	}
            // 	if($notification->Female){
            // 	    $users = $users->andWhere("Gender = 0");
            // 	}
            // 	// TODO: add other criteria
            // 	$users = $users->execute();

            // 	$users = User::findIn([102, 103]);

            // 	$types = explode(",", $notification->notification_type);


            // 	// add users to queue
            // 	foreach ($users as $user) {
            // 		foreach ($types as $type) {
            // 		    $queue = new PushNotificationQueue;
            // 		    $queue->Type = $type;
            // 		    $queue->Token = $user->getQueueToken($type); // TODO: get other tokens
            // 		    $queue->Msg_ID = $notification->ID;
            // 		    $queue->User_ID = $user->ID;
            // 		    $queue->save();
            // 		}
            // 	}

            // 	if($message->send_to_guests){
            // 		// select all tokens
            // 		$tokens = Token::query()->where("User_ID = 0")->andWhere("Application_ID = {$message->Application_ID}")->execute();
            // 		foreach ($tokens as $token) {
            // 			$queue = new PushNotificationQueue;
            // 		    $queue->Type = $token->Type;
            // 		    $queue->Token = $token->Token;
            // 		    $queue->Msg_ID = $message->ID;
            // 		    $queue->save();
            // 		}
            // 	}
            // }

            // die(var_dump($notification));

    	    // return response
		    return $this->response->redirect("index"); // or fail possibly
		}
	}

    public function fetch_topicsAction()
    {

        $user = $this->auth->getIdentity();
        $app_id = $user["Application_ID"];
        $module_id = $this->request->getQuery("module_id");
        
        $topics = DataCms::query()->where("application_id = {$app_id}")->andWhere("module_id = {$module_id}")->andWhere("active = 1")->execute();

        return $this->sendJson($topics);
    }
}