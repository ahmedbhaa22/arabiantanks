<?php

namespace Vokuro\Notifications\Models;

use Vokuro\Notifications\Models\FollowTypes;
use Vokuro\Notifications\Models\PushNotification;

class MessageFilters extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $message_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $follow_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'push_notification_message_filters';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationMessageFilters[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationMessageFilters
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
                    "follow_id",
                    FollowTypes::class,
                    "id",
                    [
                        'alias' => "follow"
                    ]
                );

        $this->belongsTo(
                    "message_id",
                    PushNotification::class,
                    "id",
                    [
                        'alias' => 'message'
                    ]
                );
    }

}
