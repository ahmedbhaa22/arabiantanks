<?php

class DataCmsSetting extends \Phalcon\Mvc\Model
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
    public $Item_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Dialog;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Color;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Bg;

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
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Action_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Target_Layout_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Target_Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Target_Action_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Footer_Layout_ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Type;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Api;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_cms_setting';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsSetting[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsSetting
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
