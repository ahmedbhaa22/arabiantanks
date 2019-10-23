<?php

namespace Vokuro\Polls\Controllers;

use Models\UsersMobile;
use Phalcon\Mvc\Controller;
use Phalcon\Security;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\PresenceOf;
use Vokuro\Controllers\ControllerBase;
use Vokuro\Polls\Controllers\ApiControllerBase;
use Vokuro\Polls\Models\Answers;
use Vokuro\Polls\Models\PollQuestionsUsers;
use Vokuro\Polls\Models\Polls;
use Vokuro\Polls\Models\PollsTransformer;
use Vokuro\Polls\Models\PollsListTransformer;
use Vokuro\Polls\Models\PollsViewTransformer;
use Vokuro\Polls\Models\Settings;

class ApiController extends ApiControllerBase
{

	private $MODULE_ID = 9;


    public function beforeExecuteRoute($dispatcher)
    {
        // validate token
        $token = $this->request->getQuery("token");

        $user = $this->jwtService->getActiveUser($token);
        // die(var_dump($user));
        if($user){
            $this->user = $user;
        }else{
            $this->sendJson(["error" => "invalid token"]);
            echo json_encode(["error" => "invalid token"]);
            die();
        }
    }

    public function loginAction(){
      $validation = new Validation();
      $validation->add('password', new PresenceOf(['message' => 'The password is required']));
      $validation->add('username', new PresenceOf(['message' => 'The username is required']));
      // die(var_dump($_POST));
      $messages = $validation->validate($_POST);

      if(count($messages)){
      	die(var_dump($messages));
        return $this->sendJson("missing params", 422);
      }


      $email = $this->request->getPost('username');
      $password = $this->request->getPost('password');
      $app_id = $this->request->getPost('application_id');

      try{
        $this->auth->check([
          "User" => $email,
          "Pass" => $password,
          "Application_ID" => $app_id
          ]);
      }catch(\Exception $e){
        return $this->sendJson("unauthorized", 403);
      }


      // die(var_dump($this->auth->getIdentity()));
      $user = UsersMobile::findFirst($this->auth->getIdentity()["id"]);
      return $this->sendJson($user);
    }

    public function groupsAction()
    {
      // $app_id = $this->auth->getIdentity()["Application_ID"];
    	$app_id = $this->user->Application_ID;

    	$depts = \DataCmsDeptsRel::find([
    		"Application_ID = {$app_id} AND Module_ID = {$this->MODULE_ID}"
    		]);

    	foreach ($depts as $dept) {

            $data_cms = $this->apiFactory->getDataCmsDeptsRelItemReturn($dept);
            $data_cms['link_share'] = "http://robo-apps.comnews.php?ID=14";
            $data_cms['sub'] = array();
            $data_cms['parameter_filter'] = array();
            $data_cms['more'] = [];
            $data_cms['media'] = [];
            
            $data[] = $data_cms;
        
    	}


    	$response = [
            "status" => $this->apiFactory->getStatus(200, "Success"),
            "content" => $data
        ];

        return $this->sendJson($response);
    }

	public function pollsAction()
	{
		$app_id = $this->user->Application_ID;


		$polls = Polls::find([
			"application_id = {$app_id}"
		]);

    $trans = new PollsListTransformer;
		$response = [
        "status" => $this->apiFactory->getStatus(200, "Success", ["validation" => [], "other" => []]),
        "content" => [
          "header" => [
            [
              "lable" => "#",
              "name" => "id",
              "id" => 1
            ],
            [
              "lable" => "سؤال الاستفتاء",
              "name" => "poll_question",
              "id" => 2
            ],
            [
              "lable" => "عدد الاجابات",
              "name" => "number_of_answers",
              "id" => 3
            ],
            [
              "lable" => "اجراءات",
              "name" => "actions",
              "id" => null
            ]
          ],
          "content" => $trans->transformResultSet($polls),
          "bulk_actions" => [
            [
              "title" => "Add New Poll",
              "target_action_id" => "1",
              "target_type" => "popup",
              "target_content" => "block",
              "content_id" => "12",
              "target_layout_id" => "2",
              "target_url" => "http://www.urltoinbox.com",
              "icon" => ""
            ]
          ]
        ],
        "summary" => [
          "filtered_by" => [],
          "count" => [
            "displayed_rows" => count($polls),
            "total_rows" => count($polls),
          ],
          "limit" => "",
          "pagination" => ""
        ]
    ];

    return $this->sendJson($response);
	}

	public function questionsAction($poll_id)
	{
		$poll = Polls::findFirst($poll_id);

		$questions = $poll->questions;

		$data = [];

		foreach ($questions as $key => $question) {
			$data[$key]["id"] = $question->id;
			$data[$key]["name"] = $question->text;

			foreach ($question->answers as $key2 => $answer) {
				$data[$key]["answer"][$key2]["id"] = $answer->id;
				$data[$key]["answer"][$key2]["name"] = $answer->text;
				$data[$key]["answer"][$key2]["image"] = $answer->photo;
				$data[$key]["answer"][$key2]["rate"] = $answer->count;
				$data[$key]["answer"][$key2]["color"] = "";
			}
		}

		$status = $this->apiFactory->getStatus(200, "Success", ["validation" => [], "other" => []]);
    $trans = new PollsViewTransformer;

		$data = [
			"status" => $status,
			"content" => [
        "groups" => $trans->transformResultSet($poll->questions)
      ]
		];

		return $this->sendJson($data);
	}

	public function voteAction()
	{
    $user_id = $this->user->ID;

    $application_id = $this->user->Application_ID;

		// $answer_id
		$data = json_decode($this->request->getPost("dataArray"), true);
		// die(var_dump($data));
		$answer = Answers::findFirst($data["answer_id"]);

		if(!$answer){
			$response = [
			    "status" => $this->apiFactory->getStatus(404, "Answer not found"),
				    "content" => []
			];

			return $this->sendJson($response);
		}

		$qid = $answer->question->id;

		$rel = PollQuestionsUsers::find([
			"user_id = {$user_id} AND question_id = {$qid}"
		]);
		
		if(count($rel)){
			// user already voted before

			$response = [
			    "status" => $this->apiFactory->getStatus(400, "User already voted before"),
			    "content" => []
			];

			return $this->sendJson($response);
		}


		// add user to answer user table
		$rel = new PollQuestionsUsers;
		$rel->user_id = $user_id;
		$rel->question_id = $qid;
		$rel->save();


		// increment answer count
		$answer = Answers::findFirst($data["answer_id"]);
		$answer->count = $answer->count + 1;
		$answer->save();

		$response = [
            "status" => $this->apiFactory->getStatus(200, "Success"),
            "content" => []
        ];

        return $this->sendJson($response);
	}


}

