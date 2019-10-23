<?php 

namespace Vokuro\Polls\Models;

use Vokuro\Transformer;

/**
* 
*/
class PollsViewTransformer extends Transformer
{

	public function __construct()
	{
		$this->ansTrans = new AnswersTransformer;
	}
	
	public function transform($question)
	{
		return [
			"id" => $question->id,
			"name" => $question->text,
			"field_type" => "radio",
			"chart_type" => "pie-chart",
			"answer" => $this->ansTrans->transformResultSet($question->answers)
		];
	}
}