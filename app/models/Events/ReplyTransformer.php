<?php

namespace Vokuro\Models\Events;

use Vokuro\Models\EventReplies;
use Vokuro\Transformer;

/**
* 
*/
class ReplyTransformer extends Transformer
{
	public function transform($reply)
	{
		$current_reply = EventReplies::findFirst($reply->id);

		return [
			'id' => $current_reply->id,
			'reply' => $current_reply->reply,
			'user' => $current_reply->user,
			'created_at' => $current_reply->created_at
		];
	}
}