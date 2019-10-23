<?php

class DataKeyvalueOption extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $DKV_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Module_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_keyvalue_option';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueOption[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueOption
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize(){
        $this->hasMany(
            "ID",
            "\DataKeyvalueOptionLang",
            "Option_ID",
            [
                'alias' => 'DataKeyvalueOptionLang',
                'reusable' => true
            ]
        );

        $this->belongsTo(
            "ID",
            "\DataKeyvalueOptionLang",
            "Option_ID",
            [
                'alias' => 'OptionLang',
                'reusable' => true
            ]
        );
    }
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'dkv_id' =>'DKV_ID',

            'application_id' => 'Application_ID',

            'module_id' => 'Module_ID',
        );


    }

}
