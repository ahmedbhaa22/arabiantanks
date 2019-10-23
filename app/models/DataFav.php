<?php

class DataFav extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Key_ID;

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
    public function getSource()
    {
        return 'data_fav';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataFav[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataFav
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
