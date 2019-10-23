<?php
namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Models\Behaviors\Loggable;

class DataKeyvalueDb extends Model
{
		public $ID;
	public $DKV_ID;
	public $Application_ID;
	public $Module_ID;
	public $Core_Dept_ID;
	
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
	public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'application_id' => 'Application_ID',   
            'module_id' => 'Module_ID', 
            'core_dept_id' => 'Core_Dept_ID', 
            'dkv_id' => "DKV_ID",
			);
    }
	public function initialize()
    {
        $this->addBehavior(new Loggable());
        $this->hasMany(
            "Core_Dept_ID",
            '\DataCmsDeptsRel',
            "Core_Depts_ID",
            [
                'alias' => 'Depts',
                'reusable' => true
            ]
        );
    }
}