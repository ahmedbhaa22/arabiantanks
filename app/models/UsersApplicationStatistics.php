<?php

class UsersApplicationStatistics extends \Phalcon\Mvc\Model
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
    public $Session_User_ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Token;

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
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Action_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Key_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Key_User_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Depts_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Source_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Author_ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Request_Data;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $DateTime;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Type_Module;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Base_Url;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Mobile;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Mobile_Type;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Duration;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $IP_ID;

    /**
     *
     * @var double
     * @Column(type="double", nullable=false)
     */
    public $Latitude;

    /**
     *
     * @var double
     * @Column(type="double", nullable=false)
     */
    public $Longitude;

    /**
     *
     * @var integer
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Online;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_application_statistics';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationStatistics[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationStatistics
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "IP_ID",
            '\UsersApplicationStatisticsIp',
            "ID",
            [
                'alias' => 'UsersApplicationStatisticsIp',
                'reusable' => true
            ]
        );

    }
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'session_user_id' => 'Session_User_ID',
            'token' => 'Token',
            'application_id' => 'Application_ID',
            'module_id' => 'Module_ID',
            'action_id' => 'Action_ID',
            'key_id' => 'Key_ID',
            'key_user_id' => 'Key_User_ID',
            'depts_id' => 'Depts_ID',
            'source_id' => 'Source_ID',
            'author_id' => 'Author_ID',
            'request_data' => 'Request_Data',
            'datetime' => 'DateTime',
            'type_module' => 'Type_Module',
            'base_url' => 'Bae_Url',
            'mobile' => 'Mobile',
            'mobile_type' => 'Mobile_Type',
            'duration' => 'Duration',
            'ip_id' => 'IP_ID',
            'latitude' => 'Latitude',
            'longitude' => 'Longitude',
            'online' => 'Online'

        );
    }

}
