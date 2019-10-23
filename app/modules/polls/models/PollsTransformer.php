<?php 

namespace Vokuro\Polls\Models;

use Vokuro\Transformer;

/**
* 
*/
class PollsTransformer extends Transformer
{
	
	public function transform($poll)
	{
		return [
			"id" => $poll->id,
			"name" => $poll->name,
			"description" => $poll->description,
			"created_at" => $poll->created_at,
			"image" => "",
			"duration" => "",
			"visit_num" => "",
			"order" => "",
			"link_share" => "",
			"content" => "",
			"more" => [

			],
			"media" => []
		];
	}

	private function structureKV($poll)
	{
		return [
		];
	}

	private function structureValues($paramter, $value)
	{
		return [
			"id" => "",
			"paramter" => $paramter,
			"value" => $value,
			"dkv_id" => "",
			"setting_id" => ""
		];
	}
}