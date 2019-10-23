<?php

class DataCmsOrders extends \Phalcon\Mvc\Model
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
    public $User_ID;
	
	/**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Address_ID;

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
     * Returns table name mapped in the model.
     *
     * @return string
     */

    public $Status;

    public $updated_at;

    public function getSource()
    {
        return 'data_cms_orders';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrders[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrders
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "User_ID",
            'Models\UsersMobile',
            "ID",
            [
                'alias' => 'UsersMobile',
                'reusable' => true
            ]
        );

        $this->belongsTo(
            "Status",
            'Models\DataCmsOrderStatus',
            "ID",
            [
                'alias' => 'OrderStatus',
                'reusable' => true
            ]
        );

        $this->hasMany(
            "ID",
            '\DataCmsOrdersPurchase',
            "Order_ID",
            [
                'alias' => 'OrderPurchase',
                'reusable' => true
            ]
        );
		$this->belongsTo(
            "Address_ID",
            '\UsersShippingAddresses',
            "id",
            [
                'alias' => 'Address',
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
            'user_id' => 'User_ID',
            'date' => 'Date',
            'application_id' => 'Application_ID',
            'module_id' => 'Module_ID',
            'status' => 'Status',
            'address_id' =>'Address_ID',
            'updated_at'=>'updated_at',
            'total_price' => 'total_price',
            'payment_receipt' => 'payment_receipt',
            'user_comment' => 'user_comment'
        );
    }

    public static function getUserCart($user_id)
    {
        $cart = null;

        $user_cart = static::findFirst([
            'User_ID = {user_id}',
            'bind' => [
                'user_id' => $user_id
            ]
        ]);

        if($user_cart)
        {
            $cart = $user_cart;
        }
        else
        {
            $user_cart = new DataCmsOrders();

            $user_cart->User_ID = $user_id;
            $user_cart->Address_ID = 0;
            $user_cart->Date = time();
            $user_cart->updated_at = time();
            $user_cart->Application_ID = 1;
            $user_cart->Module_ID = 1;
            $user_cart->Status = 2;

            $user_cart->save();

            $cart = $user_cart;
        }

        return $cart;
    }

}
