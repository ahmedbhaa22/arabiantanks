<?php 

namespace Vokuro\Messages\Controllers;

use Models\UsersMobile;
use Vokuro\Controllers\ControllerBase;
use Vokuro\Messages\Controllers\ApiControllerBase;
use Vokuro\Messages\Models\MessagesRelation;
use Vokuro\Messages\Models\ConversationTransformer;
use Vokuro\Messages\Models\MessageViewTransformer;
use Vokuro\Models\Modules;

/**
* 
*/
class ApiController extends ApiControllerBase
{
	// private $MODULE_ID = 20205;
	private $MODULE_ID = 20195;

	public function beforeExecuteRoute($dispatcher)
	{
	    // validate token
	    $token = $this->request->getQuery("token");

	    $user = $this->jwtService->getActiveUser($token);
	    // die(var_dump($user));
	    if($user){
	        $this->user = $user->toArray();
	    }else{
	        $this->sendJson(["error" => "invalid token"]);
	        echo json_encode(["error" => "invalid token"]);
	        die();
	    }
	}

	/**
	 * get list of one to one conversations
	 */
	public function messagesAction()
	{
		$user = $this->user;
        $user_id = $user['ID'];

        $application_id = $user['Application_ID'];

        $messages = MessagesRelation::find([
            "application_id = {$application_id} AND module_id = {$this->MODULE_ID} AND deleted != {$user_id} AND (to_user_id = {$user_id} OR from_user_id = {$user_id}) AND data_cms_id IS NULL",
            "group" => ['parent_id']
            ]);

        $data = [];
        foreach ($messages as $key => $msg) {
        	$data["messages"][$key]["from_user"] = $msg->sender->Title;
        	$data["messages"][$key]["from_user_id"] = $msg->sender->ID;
        	$data["messages"][$key]["to_user"] = $msg->receiver->Title;
        	$data["messages"][$key]["to_user_id"] = $msg->receiver->ID;
        	$data["messages"][$key]["chat_id"] = $msg->parent_id;
        	$data["messages"][$key]["last_message"] = $msg->message->content;
        	$data["messages"][$key]["last_message_time"] = $msg->message->created_at;
        }

        $final_array = $this->structureMessages($data["messages"]);
        $trans = new ConversationTransformer;

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
        	      "lable" => "عنوان الرسالة",
        	      "name" => "message_text",
        	      "id" => 2
        	    ],
        	    [
        	      "lable" => "مرسل من",
        	      "name" => "client",
        	      "id" => 3
        	    ],
        	    [
        	      "lable" => "تاريخ",
        	      "name" => "date",
        	      "id" => 4
        	    ],
        	    [
        	      "lable" => "اجراءات",
        	      "name" => "actions",
        	      "id" => null
        	    ]
        	  ],
        	  "content" => $trans->transformResultSet($messages),
        	  "bulk_actions" => [
			      [
			        "title" => "Inbox",
			        "target_action_id" => "1",
			        "target_type" => "popup",
			        "target_content" => "block",
			        "content_id" => 12,
			        "target_layout_id" => "2",
			        "target_url" => "http://www.urltoinbox.com",
			        "icon" => ""
			      ],
			      [
			        "title" => "Important",
			        "target_action_id" => "1",
			        "target_type" => "ajax",
			        "target_content" => "page",
			        "content_id" => 1,
			        "target_layout_id" => "2",
			        "target_url" => "http://",
			        "icon" => ""
			      ],
			      [
			        "title" => "Sent",
			        "target_action_id" => "1",
			        "target_type" => "ajax",
			        "target_content" => "page",
			        "content_id" => 1,
			        "target_layout_id" => "2",
			        "target_url" => "http://",
			        "icon" => ""
			      ],
			      [
			        "title" => "Draft",
			        "target_action_id" => "1",
			        "target_type" => "ajax",
			        "target_content" => "page",
			        "content_id" => 1,
			        "target_layout_id" => "2",
			        "target_url" => "http://",
			        "icon" => ""
			      ],
			      [
			        "title" => "Trash",
			        "target_action_id" => "1",
			        "target_type" => "ajax",
			        "target_content" => "page",
			        "content_id" => 1,
			        "target_layout_id" => "2",
			        "target_url" => "http://",
			        "icon" => ""
			      ]
			    ]
        	],
        	"summary" => [
        	  "filtered_by" => [],
        	  "count" => [
        	    "displayed_rows" => count($messages),
        	    "total_rows" => count($messages),
        	  ],
        	  "limit" => "",
        	  "pagination" => ""
        	]
        ];

        return $this->sendJson($response);
	}

	/**
	 * get messages of a conversation
	 */
	public function get_messagesAction()
	{
		$parent_id = $this->request->getQuery("conversation_id");

		$user = $this->user;
        $user_id = $user['ID'];
        $application_id = $user['Application_ID'];

        $messages = MessagesRelation::find([
            "application_id = {$application_id} AND module_id = {$this->MODULE_ID} AND parent_id = '{$parent_id}' AND (data_cms_id IS NULL)"
            ]);

        $data = [];
        foreach ($messages as $key => $msg) {
        	$data["messages"][$key]["from_user"] = $msg->sender->Title;
        	$data["messages"][$key]["from_user_id"] = $msg->sender->ID;
        	$data["messages"][$key]["to_user"] = $msg->receiver->Title;
        	$data["messages"][$key]["to_user_id"] = $msg->receiver->ID;
        	$data["messages"][$key]["last_message"] = $msg->message->content;
        	$data["messages"][$key]["last_message_time"] = $msg->message->created_at;
        }

        $trans = new MessageViewTransformer;
        $response = [
        	"status" => $this->apiFactory->getStatus(200, "Success", ["validation" => [], "other" => []]),
        	"content" => $trans->transformResultSet($messages),
        	"actions" => [
        		[
        		  "title" => "Delete",
        		  "target_action_id" => "1",
        		  "target_type" => "popup",
        		  "target_content" => "block",
        		  "content_id" => 14,
        		  "target_layout_id" => "2",
        		  "target_url" => "http://",
        		  "icon" => ""
        		],
        		[
        		  "title" => "Edit",
        		  "target_action_id" => "1",
        		  "target_type" => "popup",
        		  "target_content" => "block",
        		  "content_id" => 14,
        		  "target_layout_id" => "2",
        		  "target_url" => "http://",
        		  "icon" => ""
        		]
        	]
        ];

        return $this->sendJson($response);
	}

	/**
	 * send message
	 */
	public function send_messageAction()
	{
		$user = $this->user;
        $user_id = $user['ID'];
		$from = $user['ID'];
		$data = json_decode($this->request->getPost("dataArray"), true);
		$to = $data['to_user_id'];
        $application_id = $user['Application_ID'];
        // die(var_dump($data));
        // check for previous conversation with this user
		$parentid = $this->db->fetchOne("SELECT parent_id FROM data_message_relations where (from_user_id='".$from."' and to_user_id='".$to."' ) or (from_user_id='".$to."' and to_user_id='".$from."') ORDER BY  `data_message_relations`.`id` DESC LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
		$parentid = $parentid['parent_id'];
		
		// store the message
		$this->db->insert(
		  'data_messages',
		  array($data['message'], time(), $application_id, 20195),
		  array('content', 'created_at', 'application_id', 'module_id')
		);
		$messageid = $this->db->lastInsertId();

		// store the relation
		$this->db->insert(
		  'data_message_relations',
		  array($messageid, 0, $from, $to, $application_id, 20195),
		  array('data_message_id', 'deleted', 'from_user_id', 'to_user_id', 'application_id', 'module_id')
		);
		$relationid = $this->db->lastInsertId();
		if (!$parentid) {
		  $parentid = $relationid;
		}

		// if there was a prev conversation set the parent id, else start a new conversation
		$this->db->execute("UPDATE `data_message_relations` SET `parent_id`=".$parentid." WHERE `id`=".$relationid."");
		

		$response = [
        	"status" => $this->apiFactory->getStatus(200, "Success"),
        	"data" => []
        ];

        return $this->sendJson($response);
	}

	/**
	 * send msg in a group chat
	 */
	public function send_chat_messageAction()
	{
		$user = $this->user;
        $user_id = $user['id'];
		$from = $user['id'];
		$data = json_decode($this->request->getPost("dataArray"), true);
		$chat_id = $data['chat_id'];
        $application_id = $user['Application_ID'];

        // store the message
		$this->db->insert(
		  'data_messages',
		  array($data['message'], time(), $application_id, 20195),
		  array('content', 'created_at', 'application_id', 'module_id')
		);
		$messageid = $this->db->lastInsertId();

		// store the relation
		$this->db->insert(
		  'data_message_relations',
		  array($messageid, 0, $from, $chat_id, $application_id, 20195),
		  array('data_message_id', 'deleted', 'from_user_id', 'data_cms_id', 'application_id', 'module_id')
		);


		$response = [
        	"status" => $this->apiFactory->getStatus(200, "Success"),
        	"data" => []
        ];

        return $this->sendJson($response);
	}

	/**
	 * list messages of a chat room
	 */
	public function chat_messagesAction()
	{
		$chat_id = $this->request->getQuery("chat_id");

		$user = $this->user;
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];

        $messages = MessagesRelation::find([
            "application_id = {$application_id} AND data_cms_id = {$chat_id}"
            ]);

		$data = [];
		foreach ($messages as $key => $msg) {
			$data["messages"][$key]["from_user"] = $msg->sender->Title;
			$data["messages"][$key]["from_user_id"] = $msg->sender->ID;
			$data["messages"][$key]["last_message"] = $msg->message->content;
			$data["messages"][$key]["last_message_time"] = $msg->message->created_at;
		}

		$response = [
        	"status" => $this->apiFactory->getStatus(200, "Success"),
        	"data" => $data
        ];

        return $this->sendJson($response);
	}

	/**
	 * list chat rooms of current user
	 */
	public function chat_roomsAction()
	{
		$user = $this->user;
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];

        $user = UsersMobile::findFirst($user_id);

        $cms = $user->getCms([
        	"secured = 0 AND application_id = {$application_id}"
        	]);

        $data = [];
		foreach ($cms as $key => $chat) {
			$data["messages"][$key]["name"] = $chat->title;
			$data["messages"][$key]["created_at"] = $chat->datetime;
			$data["messages"][$key]["id"] = $chat->id;
		}

		$final_array = $this->structureMessages($data["messages"]);

		$response = [
        	"status" => $this->apiFactory->getStatus(200, "Success"),
        	"data" => $final_array
        ];

        return $this->sendJson($response);
	}

	/**
	 * list groups of current user
	 */
	public function groupsAction()
	{
		$user = $this->user;
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];

        $user = $this->user;
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];

        $user = UsersMobile::findFirst($user_id);

        $cms = $user->getCms([
        	"secured = 1 AND application_id = {$application_id}"
        	]);

        $data = [];
		foreach ($cms as $key => $chat) {
			$data["messages"][$key]["name"] = $chat->title;
			$data["messages"][$key]["id"] = $chat->id;
			$data["messages"][$key]["created_at"] = $chat->datetime;
		}

		$final_array = $this->structureMessages($data["messages"]);

		$response = [
        	"status" => $this->apiFactory->getStatus(200, "Success"),
        	"data" => $final_array
        ];

        return $this->sendJson($response);
	}

	/**
	 * leave chat room / group
	 */
	public function leave_chatAction()
	{
		$user = $this->user;
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];

        $data = json_decode($this->request->getPost("dataArray"), true);
        $chat_id = $data["chat_id"];

        $rel = \DataCmsUsers::findFirst(
        	"user_id = {$user_id} AND data_cms_id = {$chat_id}"
        	);

        $data = [];
        if($rel && $rel->delete()){
			$response = [
	        	"status" => $this->apiFactory->getStatus(200, "Success"),
	        	"data" => []
	        ];

	        return $this->sendJson($response);
        }else{
        	$response = [
	        	"status" => $this->apiFactory->getStatus(400, "Failed"),
	        	"data" => []
	        ];

	        return $this->sendJson($response);
        }
	}

	/**
	 * add to chatroom / group
	 */
	public function add_to_chatAction()
	{
		$user = $this->user;
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];
        $data = json_decode($this->request->getPost("dataArray"), true);
		$chat_id = $data["chat_id"];

		// $users_ids = json_decode($this->request->getPost("users"));

		$users_ids = $data["users"];

		foreach ($users_ids as $key => $user_id) {
			$rel = new \DataCmsUsers;
			$rel->data_cms_id = $chat_id;
			$rel->user_id = $user_id;
			$rel->save();
		}

		$response = [
        	"status" => $this->apiFactory->getStatus(200, "Success"),
        	"data" => []
        ];

        return $this->sendJson($response);
	}

	public function structureMessages($data)
	{
		$final_array = [];
		foreach ($data as $key => $value) {
			$extra_content = [
                "description" => "",
                "image" => "",
                "content" => "",
				"duration" => "",
				"langs" => [],
				"active" => "",
				"visit_num" => "",
				"order" => "",
				"link_share" => "",
				"sub" => [],
				"parameter_filter" => [],
				"more" => [],
				"media" => []
			];
			$final_array[] = array_merge($value, $extra_content);
		}

		return $final_array;
	}
}