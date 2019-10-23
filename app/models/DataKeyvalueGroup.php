<?php

class DataKeyvalueGroup extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=244, nullable=false)
     */
    public $Paramter;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Img;

    /**
     *
     * @var integer
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Key_Value_Layout_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Cell_Press;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Depts_ID;

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
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Core;
	
	public $Is_Dept;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_keyvalue_group';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueGroup[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueGroup
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "ID",
            '\DataKeyvalueGroupLang',
            "Group_ID",
            [
                'alias' => 'GroupLang',
                'reusable' => true
            ]
        );
        $this->hasMany(
            "ID",
            '\DataKeyvalue',
            "Group_ID",
            [
                'alias' => 'KeyValue',
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
            'paramter' =>'Paramter',
            'img' => 'Img',
            'application_id' => 'Application_ID',
            'depts_id' => 'Depts_ID',
            'module_id' => 'Module_ID',
            'key_value_layout_id' => 'Key_Value_Layout_ID',
            'cell_press' => 'Cell_Press',
            'core' => 'Core',
            'is_dept'=>'Is_Dept'
        );


    }

}
