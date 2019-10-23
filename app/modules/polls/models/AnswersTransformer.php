<?php 

namespace Vokuro\Polls\Models;

use Vokuro\Transformer;

/**
* 
*/
class AnswersTransformer extends Transformer
{
	
	public function transform($ans)
	{
		return [
			"id" => $ans->id,
			"name" => $ans->text,
			"image" => $ans->photo,
			"rate" => $ans->count ?: 0,
			"color" => "",
		];
	}
}