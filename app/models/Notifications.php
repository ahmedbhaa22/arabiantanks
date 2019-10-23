<?php
namespace Vokuro\Models;

use Phalcon\Mvc\Model;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;

/**
 * Vokuro\Models\Menus
 * All the users registered in the application
 */
class Notifications extends Model
{

  	public function getSource()
  	{
  	    return 'manager_notifications'; 
  	}

}
