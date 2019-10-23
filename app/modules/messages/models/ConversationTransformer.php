<?php 

namespace Vokuro\Messages\Models;

use Vokuro\Transformer;

/**
* 
*/
class ConversationTransformer extends Transformer
{
	
	public function transform($msg)
	{
		return [
			"basic_data" => [
				"1" => [
					"value" => $msg->id,
					"settings" => [
					  "title" => "",
					  "target_action_id" => "1",
					  "target_type" => "",
					  "target_content" => "",
					  "content_id" => 18,
					  "target_layout_id" => 2,
					  "target_url" => "https://www.messageViewURL.com/openitemview"
					]
				],
				"2" => [
					"value" => $msg->message->content,
					"settings" => [
					  "title" => "",
					  "target_action_id" => "1",
					  "target_type" => "",
					  "target_content" => "text",
					  "content_id" => 18,
					  "target_layout_id" => 2,
					  "target_url" => ""
					]
				],
				"3" => [
				  "value" => $msg->sender->Title,
				  "settings" => [
				    "title" => "",
				    "target_action_id" => "1",
				    "target_type" => "",
				    "target_content" => "",
				    "content_id" => 18,
				    "target_layout_id" => 2,
				    "target_url" => ""
				  ]
				],
				"4" => [
					"value" => $msg->message->created_at,
					"settings" => []
				]
			],
			"basic_button" => [
				[
					"title" => "view",
					"target_action_id" => "1",
					"target_type" => "popup",
					"target_content" => "block",
					"content_id" => 18,
					"target_layout_id" => "2",
					"target_url" => "http://",
					"icon" => ""
				],
				[
					"title" => "edit",
					"target_action_id" => "1",
					"target_type" => "redirect",
					"target_content" => "page",
					"content_id" => 18,
					"target_layout_id" => "2",
					"target_url" => "http://",
					"icon" => ""
				],
				[
					"title" => "delete",
					"target_action_id" => "1",
					"target_type" => "ajax",
					"target_content" => "block",
					"content_id" => 18,
					"target_layout_id" => "2",
					"target_url" => "http://",
					"icon" => ""
				]
			]
		];
	}
}