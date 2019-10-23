<?php
namespace Models;

use Phalcon\Mvc\Model;

class SeoSettings extends Model
{
	public $id;
	public $data_cms_id;
	public $meta;
	public $meta_description;
	public $title_description;
	public $page_title;

	public function getSource()
	{
		return 'seo_settings';
	}

	public function initialize()
	{
		$this->belongsTo(
			'data_cms_id',
			Content::class,
			'ID',
			[
				'alias' => 'item'
			]
		);
	}
}