<?php

class UsersApplicationModuleLang extends \Phalcon\Mvc\Model
{
	public $id;
	public $module_id;
	public $lang_id;
	public $title;
	public function getSource()
    {
        return 'users_application_module_lang';
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