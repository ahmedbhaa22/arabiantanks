<?php

namespace Vokuro\Models\Behaviors;

use Phalcon\Di;
use Phalcon\Mvc\Model\Behavior;
use Phalcon\Mvc\Model\BehaviorInterface;
use Vokuro\Models\Logs;

/**
* Logs user action for applied model
*/
class Loggable extends Behavior implements BehaviorInterface
{
	
	public function notify($eventType, \Phalcon\Mvc\ModelInterface $model)
	{
		// get event type
		$action = $this->getAction($eventType);

		// get user
		$auth = Di::getDefault()->get('auth');
		$user = $auth->getIdentity();

		// log data
		if($action){
			$log = new Logs();
			$log->action = $action;
			$log->user_id = $user['id'];
			//$log->date = date('Y-m-d h:i:s a', time());
                        $log->date = date('Y-m-d H:i:s', time());
			$log->module_id = $model->Module_ID;
            switch (get_class($model)) {
                case "DataCmsMedia":
                    $log->Model = "Content Media";
                    break;
                case "DataCmsDeptsRelItem":
                    $log->Model = "Content Departments";
                    break;
                case "Models\Content":
                    $log->Model = "Content Details";
                    $log->link  = "content/edit/";
                    break;
                case "DataCmsDeptsRel":
                    $log->Model = "Departments Details";
                default:
                    $log->Model = get_class($model);
            }

			$log->item_id = $model->ID;
            $log->application_id = $model->Application_ID;
			$log->create();
		}
	}

	public function getAction($eventType)
	{
		switch ($eventType) {

            case "afterCreate":
            	return 'create';
            case "afterDelete":
            	return 'delete';
            case "afterUpdate":
            	return 'update';

            default:
                /* ignore the rest of events */
        }
	}
}