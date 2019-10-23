<?php 

namespace Vokuro\Ads\Models;

use Vokuro\Transformer;

/**
* 
*/
class AdsTransformer extends Transformer
{

	function __construct()
	{
		$this->di = \Phalcon\DI::getDefault();
	}
	
	public function transform($ad)
	{
		$values = $this->structureKV($ad);
		if($ad->img){
			$image_path = $this->di->getShared("url")->getStatic($ad->img);
		}else{
			$image_path = null;
		}
		return [
			"id" => $ad->id,
			"name" => $ad->title,
			"description" => $ad->des,
			"image" => $image_path,
			"duration" => "",
			"content" => "",
			"created_at" => "",
			"visit_num" => "",
			"order" => "",
			"link_share" => "",
			"more" => [
				[
					"key" => "keyvalue",
					"group_name" => "",
					"value" => $values
				]
			],
			"media" => [],
            "settings"=>[]
		];
	}

	private function structureKV($ad)
	{
		return [
			$this->structureValues("link", $ad->link),
			$this->structureValues("startdate", $ad->startdate),
			$this->structureValues("enddate", $ad->enddate),
			$this->structureValues("thumbnail", $ad->thumbnail),
			$this->structureValues("is_video", $ad->is_video),
			$this->structureValues("height", $ad->height),
			$this->structureValues("width", $ad->width),
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