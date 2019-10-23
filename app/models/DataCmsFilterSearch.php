<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Models\Behaviors\Loggable;

class DataCmsFilterSearch extends Model{
	public $id;
	public $content;
	public $title;
	public $depts;
	public $date_from;
	public $date_to;
	public $lang_id;
	public $user_id;
	public $module_id;
	public $application_id;
    public $active;
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
}
