<?php

class CpApplicationSettings extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Application_ID;

    public $App_Banner;
    
    public function getSource()
    {
        return 'cp_application_settings';
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
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'application_id' => 'Application_ID',
            'app_banner' => 'App_Banner',
            
        );


    }

}
