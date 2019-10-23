<?php

class DataMessages extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Content;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Type;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Attach;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $DateTime;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Lastreplay;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Number;

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
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("cms_penta");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_messages';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessages[]|DataMessages
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessages
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
