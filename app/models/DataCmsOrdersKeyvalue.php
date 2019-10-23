<?php

class DataCmsOrdersKeyvalue extends \Phalcon\Mvc\Model
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
        return 'data_cms_orders_keyvalue';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrdersKeyvalue[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrdersKeyvalue
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "Purchase_ID",
            '\DataCmsOrdersPurchase',
            "ID",
            [
                'alias' => 'Purchase',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "DKV_ID",
            '\DataKeyvalue',
            "ID",
            [
                'alias' => 'DataKeyvalue',
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
            'value' => 'Value',
            'time' => 'Time',
            'dkv_id' => 'DKV_ID',
            'purchase_id' => 'Purchase_ID',
            'module_id' => 'Module_ID',
            'application_id' => 'Application_ID',
            'lang_id' => 'Lang_ID'
        );


    }

}
