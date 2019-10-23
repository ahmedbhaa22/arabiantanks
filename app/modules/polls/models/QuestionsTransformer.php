<?php 

namespace Vokuro\Polls\Models;

use Vokuro\Transformer;

/**
* 
*/
class QuestionsTransformer extends Transformer
{
	
	public function transform($q)
	{
		$values = $this->structureKV($q);
		return [
			"id" => $q->id,
			"name" => $q->text,
			"description" => "",
			"created_at" => "",
			"image" => "",
			"duration" => "",
			"visit_num" => "",
			"order" => "",
			"link_share" => "",
			"content" => "",
			"more" => [
				[
					"key" => "keyvalue",
					"group_name" => "",
					"value" => $values
				]
			],
			"media" => []
		];
	}

	private function structureKV($q)
	{
		return [
			$this->structureValues("answer_limit", $q->answer_limit),
			$this->structureValues("total_answers", $q->total_answers),
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