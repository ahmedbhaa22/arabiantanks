<?php

namespace Vokuro\Notifications\Models;

use Vokuro\Notifications\Models\PushNotification;

class PushNotificationQueue extends \Phalcon\Mvc\Model
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
    public $Msg_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=256, nullable=false)
     */
    public $Token;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Type;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'push_notification_queue';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationQueue[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationQueue
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "Msg_ID",
            PushNotification::class,
            "ID",
            [
                'alias' => "message"
            ]
        );
    }

}
