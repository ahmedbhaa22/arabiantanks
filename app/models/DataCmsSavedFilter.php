<?php
namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Models\Behaviors\Loggable;

class DataCmsSavedFilter extends Model
{
    public $id;
    public $filter;
    public $action;
    public $user_id;
    public $application_id;
    public $name;
    public $module_id;

    public function getSource()
    {
        return 'data_cms_saved_filter';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {

    }

    public static function get($user_id, $module_id)
    {
        return self::find([
            'user_id = {user_id} and module_id = {module_id}',
            'bind'=>[
                'user_id' => $user_id,
                'module_id' => $module_id
            ]
        ])->toArray();
    }
}