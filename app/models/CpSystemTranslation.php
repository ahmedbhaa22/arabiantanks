<?php

class CpSystemTranslation extends \Phalcon\Mvc\Model
{

    public $id;
	public $word_key;
	public $value;
	public $lang_id; 
	
    public function getSource()
    {
        return 'cp_system_translation';
    }  

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpModulesSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpModulesSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }  
    
    
 
}
