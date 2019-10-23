<?php

// created by: Ash

namespace Vokuro\Models\Api;

use Phalcon\Mvc\Model;

class FieldValidationRules extends Model
{
	public $id;
	public $name;

	public function getSource()
	{
		return "setup_field_validation_rules";
	}

	public function initialize()
	{
		$this->hasManyToMany(
			'id',
			FieldValidaion::class,
			'validation_rule_id',
			'field_setting_id',
			FieldValidaitionSettings::class,
			'id',
			[
				'alias' => 'fieldsSettings'
			]
		);
	}

	public static function required()
	{
		$rule = static::getRule(1);
		return $rule ? $rule->name : 'required';
	}

	public static function email()
	{
		$rule = static::getRule(2);
		return $rule ? $rule->name : 'email';
	}

	public static function alnum()
	{
		$rule = static::getRule(3);
		return $rule ? $rule->name : 'alnum';
	}

	public static function confirmPassword()
	{
		$rule = static::getRule(4);
		return $rule ? $rule->name : 'passwordConfirm';
	}

	public static function stringLength()
	{
		$rule = static::getRule(5);
		return $rule ? $rule->name : 'stringLength';
	}

	private static function getRule($id)
	{
		return static::findFirst($id);
	}

	public static function getRulesArray()
	{
		$rules_arr = [];
		$rules_records_arr = static::find(['columns'=>'name'])->toArray();
		foreach ($rules_records_arr as $rule)
		{
			$rules_arr[] = current($rule);
		}

		return $rules_arr;
	}
}