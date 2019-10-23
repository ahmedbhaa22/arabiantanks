<?php

// created by: Ash

namespace Vokuro\Models\Api;

use Phalcon\Mvc\Model;

class FieldValidationSettings extends Model
{
	public $id;
	public $action_id; // relation with setup_field_validation_actions
	public $entity_id; // relation with setup_entities
	public $field_name;
	public $entity_field_name;
	public $app_id;
	public $specific_action_id;
	public $related_entity_id;
	public $entity_is_root;

	public function getSource()
	{
		return "setup_field_validation_settings";
	}

	public function initialize()
	{
		$this->hasManyToMany(
			'id',
			FieldValidation::class,
			'field_setting_id',
			'validation_rule_id',
			FieldValidationRules::class,
			'id',
			[
				'alias' => 'rules'
			]
		);

		$this->belongsTo(
			'entity_id',
			\Vokuro\Models\SetupEntities::class,
			'id',
			[
				'alias' => 'entity'
			]
		);

		$this->belongsTo(
			'action_id',
			FieldValidationActions::class,
			'id',
			[
				'alias' => 'action'
			]
		);

		$this->belongsTo(
			'related_entity_id',
			\Vokuro\Models\SetupEntities::class,
			'id',
			[
				'alias' => 'relatedEntity'
			]
		);

		$this->belongsTo(
			'specific_action_id',
			FieldValidationSpecificActions::class,
			'id',
			[
				'alias' => 'specificAction' 
			]
		);
	}

	public static function getFieldsWithRules($fields)
	{
		$fields_with_rules = [];

		foreach($fields as $field)
		{
			$fields_with_rules[$field->field_name] = $field->rules->toArray();
		}

		return $fields_with_rules;
	}
}