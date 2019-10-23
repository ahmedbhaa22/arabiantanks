<?php

class DataKeyvalueOptionLang extends \Phalcon\Mvc\Model
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
    public $Option_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=false)
     */
    public $Title;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Lang_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_keyvalue_option_lang';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueOptionLang[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueOptionLang
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
            'option_id' =>'Option_ID',
            'title' => 'Title',
            'lang_id' => 'Lang_ID',
        );


    }
    public function initialize()
    {
        $this->belongsTo(
            "Lang_ID",
            '\Languages',
            "id",
            [
                'alias' => 'Lang',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "Option_ID",
            '\DataKeyvalueOption',
            "ID",
            [
                'alias' => 'KvOption',
                'reusable' => true
            ]
        );
    }

}
