<?php

class DataKeyvalueUserdata extends \Phalcon\Mvc\Model
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
    public $Title;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Des;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Img;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=false)
     */
    public $Value;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Time;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $DKV_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Item_ID;

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
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Lang_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_keyvalue_userdata';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueUserdata[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueUserdata
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "DKV_ID",
            '\DataKeyvalue',
            "ID",
            [
                'alias' => 'DataKeyvalue',
                'reusable' => true
            ]
        );

        $this->belongsTo(
            "Item_ID",
            'Models\Content',
            "ID",
            [
                'alias' => 'Content',
                'reusable' => true
            ]
        );

        $this->hasMany(
            "ID",
            '\DataKeyvalueUserdataLang',
            "kv_userdata_id",
            [
                'alias' => 'Langs',
                'reusable' => true
            ]
        );
        $this->allowEmptyStringValues(
            array(
                "Img",
                "Des",
                "Title",
                "",
                ""
            )
        );
    }
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'title' =>'Title',
            'des' => 'Des',
            'img' => 'Img',
            'value' => 'Value',
            'time' => 'Time',
            'dkv_id' => 'DKV_ID',
            'item_id' => 'Item_ID',
            'application_id' => 'Application_ID',
            'module_id'=>'Module_ID',
            'lang_id' => 'Lang_ID'
        );


    }

}
