<?php

class DataCountries extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
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
    public $Nationality;

    /**
     *
     * @var integer
     * @Column(type="integer", length=3, nullable=false)
     */
    public $Lang_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Flag_IMG;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Default;

    /**
     *
     * @var string
     * @Column(type="string", length=2, nullable=false)
     */
    public $Code;

    /**
     *
     * @var string
     * @Column(type="string", length=8, nullable=false)
     */
    public $Calling_Code;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_countries';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCountries[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCountries
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
