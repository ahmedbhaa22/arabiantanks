<?php

class DataCmsFooter extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=255, nullable=false)
     */
    public $Title;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Image;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Layout_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Item_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Action_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
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
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Footer_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Footer;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Top;

    /**
     *
     * @var string
     * @Column(type="string", length=400, nullable=false)
     */
    public $Data;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Target_Action_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Target_Layout_ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Type;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Effect_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Selected_Pic;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Footer_Type_ID;

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
        return 'data_cms_footer';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsFooter[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsFooter
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
