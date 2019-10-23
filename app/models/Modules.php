<?php

namespace Vokuro\Models;

use Phalcon\Mvc\Model;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;

/**
 * Vokuro\Models\Menus
 * All the users registered in the application
 */
class Modules extends Model
{
	public $ID;

  	public function getSource()
  	{
  	    return 'users_application_module'; 
  	}

  	public function initialize()
  	{

  	    $this->hasMany('ID',  __NAMESPACE__ . '\DataCms', 'Module_ID', ['alias', 'dataCms']);

  	}


}
