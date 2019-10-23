<?php
//created_by: Ash

namespace Vokuro\Models\Api;

use Phalcon\Mvc\Model;

class FieldValidationSpecificActions extends Model
{
	public $id;
	public $name;
	public $general_action_id;

	public function getSource()
	{
		return "setup_field_validation_specific_actions";
	}

	public function initialize()
	{
		$this->belongsTo(
			'general_action_id',
			FieldValidationActions::class,
			'id',
			[
				'alias' => 'generalAction'
			]
		);
	}

	public static function  editProfile()
	{
		return static::query()->where('name = :name:')->bind(['name'=>'editProfile'])->execute()->getFirst()->id;
	}
}