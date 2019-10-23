<?php
namespace Vokuro\Models;

use Phalcon\Mvc\Model;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;

/**
 * Vokuro\Models\Menus
 * All the users registered in the application
 */
class TanksSideMenu extends Model
{

    public $id;
    public $name;
    public $parent_id;
    public $module_type;
    public $module_id;
    public $url;
    public function getSource()
    {
        return 'tanks_side_menu';
    }
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

  
}
