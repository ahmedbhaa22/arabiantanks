<?php
class DataKeyvalueTypes extends \Phalcon\Mvc\Model
{
	public $id;
	public $type;
	
	public function getSource()
    {
        return 'data_keyvalue_types';
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