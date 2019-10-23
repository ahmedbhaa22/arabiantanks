<?php

class UsersToken extends \Phalcon\Mvc\Model
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
    public $Token;

    /**
     *
     * @var string
     * @Column(type="string", length=32, nullable=false)
     */
    public $Token_MD5;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $User_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Type;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Active;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_token';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersToken[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersToken
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'token' => 'Token',
            'type_id' => 'Token_MD5',
            'user_id' => 'User_ID',
            'type' => 'Type',
            'application_id' =>'Application_ID',
            'active' => 'Active'
        );


    }
	public function initialize(){
        $this->belongsTo(
            "User_ID",
            'Models\UsersMobile',
            "ID",
            [
                'alias' => 'User',
                'reusable' => true
            ]
        );
    }

}
