<?php

class UsersApplicationModuleData extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Url;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Attributes;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Account;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Search;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Data;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Dept_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Source_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Author_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Sort;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Playlist;

    /**
     *
     * @var integer
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Type;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Basic_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_application_module_data';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationModuleData[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationModuleData
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
