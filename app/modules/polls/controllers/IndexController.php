<?php

namespace Vokuro\Polls\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\Polls\Models\Polls;
use Vokuro\Polls\Models\Settings;
use Vokuro\Polls\Services\PollService;

class IndexController extends ControllerBase
{
	public $MODULE_ID = 9;

	public function initialize()
    {
        parent::initialize();
        $app_id = $this->auth->getIdentity()["Application_ID"];
        $settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();
        if(!$settings){
            $settings = new Settings;
            $settings->application_id = $app_id;
            $settings->save();
        }

        $this->settings = $settings;

        $this->view->settings = $settings;
    }

	public function indexAction()
	{
		if($this->settings->use_fb){
			return $this->response->redirect("index/fire");
		}
		
		$poll_service = new PollService();
        $search_param=[];
        $this->view->content = $poll_service->search($search_param);
	}

	public function fireAction()
	{
		$DEFAULT_URL = $this->settings->fb_url;
		$DEFAULT_TOKEN = $this->settings->fb_token;
		$DEFAULT_PATH = '/data';
		
		$firebase = new \Firebase\FirebaseLib($DEFAULT_URL, $DEFAULT_TOKEN);
		$questions = json_decode($firebase->get($DEFAULT_PATH), true);
		// $questions = json_decode($firebase->get($DEFAULT_PATH, array('orderBy' => '"event_id"', 'equalTo' => '2')), true);

		$final = [];
		foreach ($questions as $key => $question) {
			$final[$question["event_id"]][] = $question;
		}

		// die(var_dump($final));
		$this->view->questions = $final;
	}

}

