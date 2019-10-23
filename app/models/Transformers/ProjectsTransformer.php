<?php

namespace Vokuro\Models\Transformers;

use Vokuro\Transformer;

/**
* 
*/
class ProjectsTransformer extends Transformer
{

	public function transformResultSet($items)
	{
		// die(var_dump($items));
		if($items instanceof \Traversable){
			$result = [];
			// die(var_dump($items));
			foreach ($items as $item) {
				$result[] = $this->transform($item);
			}
			return $result;
		}

		return $this->transform($items);	
	}

	public function transform($project)
	{
		// die(var_dump($project));
		return [
			'id' => $project->id,
			'name' => $project->name,
			'description' => $project->description,
			'note' => $project->note,
			'source' => $project->source,
			'image' => $project->image,
			'start_date' => $project->start_date
		];
	}
}