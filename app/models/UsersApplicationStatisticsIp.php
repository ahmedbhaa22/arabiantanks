<?php

class UsersApplicationStatisticsIp extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $IP;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Country;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $City;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $HTTP_USER_AGENT;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Token;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_application_statistics_ip';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationStatisticsIp[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationStatisticsIp
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
            'application_id' => 'Application_ID',
            'ip' => 'IP',
            'country' => 'Country',
            'city' => 'City',
            'http_user_agent' => 'Http_User_Agent',
            'token' => 'Token',

        );
    }
}
