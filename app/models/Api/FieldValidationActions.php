<?php

// created by: Ash

namespace Vokuro\Models\Api;

use Phalcon\Mvc\Model;

class FieldValidationActions extends Model
{
	public $id;
	public $name;

	public function getSource()
	{
		return "setup_field_validation_actions";
	}

	public function initialize()
	{
		// define relations
	}

	public static function register()
	{
		return 1;
	}

	public static function edit()
	{
		return 2;
	}

	public static function view()
	{
		return 3;
	}

	public static function insert()
	{
		return 4;
	}
}