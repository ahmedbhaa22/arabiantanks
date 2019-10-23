<?php 

namespace Vokuro\Messages\Models;

use Vokuro\Transformer;

/**
* 
*/
class MessagesTransformer extends Transformer
{
	
	public function transform($msg)
	{
		return [
			"id" => $poll->id,
			"name" => $poll->name,
			"description" => $poll->description,
			"created_at" => $poll->created_at,
			"modified_at" => $poll->modified_at,
			"data_cms_depts_rel_id" => $poll->data_cms_depts_rel_id,
			"application_id" => $poll->application_id,
			"module_at" => $poll->module_id,
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
	}
}