<?php 

namespace Vokuro\Messages\Models;

use Vokuro\Transformer;

/**
* 
*/
class MessageViewTransformer extends Transformer
{
	
	public function transform($msg)
	{
		return [
			"id" => $msg->id,
			"name" => $msg->message->name,
			"content" => $msg->message->content,
			"created_at" => strtotime($msg->message->created_at),
			"from" => [
				"id" => $msg->sender->ID,
				"name" => $msg->sender->Title
			],
			"to" => [
				"id" => $msg->receiver->ID,
				"name" => $msg->receiver->Title
			],
			"media" => []
		];
	}
}