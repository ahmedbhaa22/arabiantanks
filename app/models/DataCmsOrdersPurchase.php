<?php

class DataCmsOrdersPurchase extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=10, nullable=false)
     */
    public $ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Order_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $item_id;

    public $item_type_id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Date;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Module_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Cost;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Count;

    public $updated_at;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'order_id' => 'Order_ID',
            'item_id' => 'item_id',
            'date' => 'Date',
            'module_id' => 'Module_ID',
            'application_id' => 'Application_ID',
            'cost' => 'Cost',
            'count' => 'Count',
            'updated_at'=>'updated_at',
            'item_type_id' => 'item_type_id',
            'color'=>'color',
            'delivery_place'=>'delivery_place'
        );


    }
    public function getSource()
    {
        return 'data_cms_orders_purchase';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrdersPurchase[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrdersPurchase
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "Order_ID",
            '\DataCmsOrders',
            "ID",
            [
                'alias' => 'Order',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "item_id",
            'Models\Content',
            "ID",
            [
                'alias' => 'Content',
                'reusable' => true
            ]
        );
    }

}
