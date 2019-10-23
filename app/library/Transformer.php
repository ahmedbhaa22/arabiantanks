<?php 



namespace Vokuro;



/**

* 

*/

abstract class Transformer

{

	public function transformResultSet($items)
	{
		// dd($items instanceof \Traversable);
		if($items instanceof \Traversable || is_array($items)){
			// dd($items);
			$result = [];
			foreach ($items as $item) {
				// dd($item);
				$result[] = $this->transform($item);
			}
			return $result;
		}

		return $this->transform($items);	
	}

	public abstract function transform($item);

}