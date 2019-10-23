<?php

namespace Vokuro\Forms\Validations;

use Phalcon\Validation;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\File as FileValidator;
/**
* 
*/
class AdsValidation extends Validation
{
	public function initialize()
	{
	    $this->add("title", new PresenceOf([ "title" => "The title is required"]));
	    // $this->add("description", new PresenceOf([ "description" => "The description is required"]));
	    $this->add("link", new PresenceOf([ "link" => "The link is required"]));
	    // $this->add("height", new PresenceOf([ "Height" => "The Height is required"]));
	    // $this->add("width", new PresenceOf([ "Width" => "The Width is required"]));
	    // $this->add("module_id", new PresenceOf([ "module_id" => "The module_id is required"]));
	}
}