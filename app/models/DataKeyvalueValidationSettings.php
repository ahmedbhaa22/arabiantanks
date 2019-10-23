<?php
class DataKeyvalueValidationSettings extends \Phalcon\Mvc\Model
{
	public $id;
	public $dkv_id;
	public $kv_type;
	public $req;
	public $application_id;
	public $module_id;
	
	public function getSource()
    {
        return 'data_keyvalue_validation_settings';
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