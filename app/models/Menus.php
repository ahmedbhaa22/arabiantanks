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
class Menus extends Model
{

    public $id;
    public $name;
    public $icon;
    public $href;
    public $order;
    public $app_id;
    public $menu_cms_id;
    public function getSource()
    {
        return 'menus';
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
