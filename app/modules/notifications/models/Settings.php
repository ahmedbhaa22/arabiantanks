<?php

namespace Vokuro\Notifications\Models;

use Vokuro\Notifications\Models\FollowPermissions;
use Vokuro\Notifications\Models\FollowTypes;

class Settings extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $android_app_key;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $iphone_bundle_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $enable_sandbox;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $sandbox_passphrase;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $sandbox_certificate;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $enable_production;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $production_certificate;
    public $smtp_server;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'push_notification_settings';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotificationSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {

        $this->hasMany(
            "id",
            FollowPermissions::class,
            "setting_id",
            [
                "alias" => "permissionsPivot"
            ]
            );

        $this->hasManyToMany(
            "id",
            FollowPermissions::class,
            "setting_id", "follow_id",
            FollowTypes::class,
            "id",
            [
                "alias" => "permissions"
            ]
            );
    }

    public function hasPermission($type)
    {
        // current selected permissions
        $permissions = $this->permissions;
        $permissions = array_map(function($item){
            return $item['type'];
        }, $this->permissions->toArray());
        // die($type);
        // die(var_dump(in_array($type, $permissions)));
        return in_array($type->type, $permissions);
    }

}
