<?php

class UsersIntro extends \Phalcon\Mvc\Model
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
    public $Title_En;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Des;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Img;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Lang_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_intro';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersIntro[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersIntro
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
