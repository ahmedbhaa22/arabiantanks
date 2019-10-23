<?php

namespace Vokuro\Notifications\Models;

class Token extends \Phalcon\Mvc\Model
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
    public $User_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=256, nullable=false)
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
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Type;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Latitude;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=false)
     */
    public $Longitude;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=false)
     */
    public $Online;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=false)
     */
    public $Last_Update_Locations;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=false)
     */
    public $Last_Time_Receive_Msg;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Msg_All_Count;

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
        return 'push_notification_token';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationToken[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationToken
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
