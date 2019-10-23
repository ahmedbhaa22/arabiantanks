<?php

namespace Vokuro\Notifications\Models;

use Vokuro\Models\DataCms;
use Vokuro\Notifications\Models\MessageFilters;

class PushNotification extends \Phalcon\Mvc\Model
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
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Brand_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=256, nullable=false)
     */
    public $Message;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $Age;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Nearby;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $Raduis;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Favourite;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Like;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Male;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Female;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Stats;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=false)
     */
    public $Send_Time;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $Finished_Time;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Module_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'push_notification';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotification[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushNotification
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasManyToMany(
            "id",
            MessageFilters::class,
            "message_id", "follow_id",
            FollowTypes::class,
            "id",
            [
                "alias" => "filters"
            ]
            );

        $this->hasOne(
            "Module_ID",
            \UsersApplicationModule::class,
            "ID",
            [
                "alias" => "module"
            ]
            );

        $this->hasOne(
            "topic_id",
            DataCms::class,
            "id",
            [
                "alias" => "topic"
            ]
            );
    }

    public function getFAIcon($type)
    {
        switch ($type) {
            case 1:
                return "apple";
                break;
            case 2:
                return "android";
                break;
            case 3:
                return "at";
                break;
            case 4:
                return "envelope";
                break;
            default:
                # code...
                break;
        }
    }

}
