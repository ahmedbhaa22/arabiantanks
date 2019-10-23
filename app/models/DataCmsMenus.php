<?php
namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
class DataCmsMenus extends Model
{

    public $id;
    public $menu_name;
    public $application_id;
    public $is_main;

    public function getSource()
    {
        return 'data_cms_menus';
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
