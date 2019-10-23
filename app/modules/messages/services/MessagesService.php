<?php 

namespace Vokuro\Messages\Services;

use Phalcon\Di;
use Vokuro\Messages\Models\DataMessagesDrafts;
use Vokuro\Messages\Models\MessagesRelation;

/**
* 
*/
class MessagesService
{
	public function getUnreadCount()
	{
		$auth = Di::getDefault()->get('auth');
		$config = Di::getDefault()->get('config');
		$user = $auth->getIdentity();
        $user_id = $user['id'];

        $application_id = $user['Application_ID'];

        $messages = MessagesRelation::find([
            // "Module_ID = {$config->Penta_Settings->Module_ID}",
            "Application_ID = {$application_id} AND Deleted != {$user_id} AND To_User_ID = {$user_id}",
            // "",
            "group" => ['Parent_ID']
            ]);

        return count($messages);
	}

	public function getDraftsCount()
	{
		$auth = Di::getDefault()->get('auth');
		$config = Di::getDefault()->get('config');
		// die(var_dump($config));
		$user = $auth->getIdentity();
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];
        $drafts = DataMessagesDrafts::find([
            "conditions" => "Application_ID = ?1 AND From_User_ID = ?2",
            "bind" => [
                // 1 => $config->Penta_Settings->Module_ID,
                1 =>$application_id,
                2 =>$user_id
            ],
        ]);

        return count($drafts);
	}

	public function getTrashedCount()
	{
		$auth = Di::getDefault()->get('auth');
		$config = Di::getDefault()->get('config');
		$user = $auth->getIdentity();
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];
        $messages = MessagesRelation::find([
            "conditions" => "Application_ID = ?1 AND Deleted = ?2",
            "bind" => [
                // 1 => $config->Penta_Settings->Module_ID,
                1 => $application_id,
                2 => $user_id
            ],
            "group" => ['Parent_ID']
            ]);

        return count($messages);
	}
}