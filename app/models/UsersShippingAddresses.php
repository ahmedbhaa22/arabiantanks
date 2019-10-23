<?php

class UsersShippingAddresses extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=120, nullable=true)
     */
    public $address_name;

    /**
     *
     * @var string
     * @Column(type="string", length=140, nullable=true)
     */
    public $street_name;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $extra_directions;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $type;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $building_number;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $floor;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $appartment_number;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $block_number;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $area_id;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $user_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_shipping_addresses';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersShippingAddresses[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersShippingAddresses
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "area_id",
            'Models\Content',
            "ID",
            [
                'alias' => 'Area',
                'reusable' => true
            ]
        );
    }

}
