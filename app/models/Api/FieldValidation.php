<?php

// created by: Ash

namespace Vokuro\Models\Api;

use Phalcon\Mvc\Model;

class FieldValidation extends Model
{
	public $id;
	public $field_setting_id; // relation with setup_field_validation_settings
	public $validation_rule_id; // relation with setup_field_validation_rules
	public $confirm_password_field_name; // if the rule is confirm password
	public $min_value; // if the rule is string length
	public $max_value; // if the rule is string length

	public function getSource()
	{
		return "setup_field_validation";
	}

	public function initialize()
	{
		// define relations
	}
}