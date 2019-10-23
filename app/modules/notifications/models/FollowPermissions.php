<?php

namespace Vokuro\Notifications\Models;

use Vokuro\Notifications\Models\FollowTypes;
use Vokuro\Notifications\Models\Settings;

class FollowPermissions extends \Phalcon\Mvc\Model
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
    public $setting_id;

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
        return 'push_notification_follow_permissions';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationFollowPermissions[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationFollowPermissions
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
                    "setting_id",
                    Settings::class,
                    "id",
                    [
                        'alias' => 'settings'
                    ]
                );
    }

}
