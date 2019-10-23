<?php

namespace Vokuro\Models\Events;

use Models\UsersMobile;
use Vokuro\Models\EventReplies;
use Vokuro\Models\EventResponses;
use Vokuro\Models\Places;

class Events extends \Phalcon\Mvc\Model
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
     * @Column(type="string", nullable=true)
     */
    public $description;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $creator_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $start_date;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $end_date;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $event_purpose;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $schedule_type;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'events';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Events[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Events
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public static function findIn(array $identifiers)
    {
        return self::query()
            ->inWhere('id', $identifiers)
            ->execute();
    }

    public function initialize()
    {
        $this->hasManyToMany(
            "id",
            "\Vokuro\Models\Events\EventInvitations",
            "event_id", "user_id",
            "\Models\UsersMobile",
            "ID",
            [
                "alias" => "invitations"
            ]
            );

        $this->hasManyToMany(
            "id",
            "\Vokuro\Models\EventCompanies",
            "event_id", "company_id",
            "\Vokuro\Models\Companies",
            "id",
            [
                "alias" => "companies"
            ]
            );

        $this->hasMany(
            "id",
            "\Vokuro\Models\EventCompanies",
            "event_id",
            [
                'alias' => "eventCom"
            ]
        );

        $this->hasManyToMany(
            "id",
            "\Vokuro\Models\EventProjects",
            "event_id", "project_id",
            "\Vokuro\Models\Projects",
            "id",
            [
                "alias" => "projects"
            ]
            );

        $this->hasMany(
            "id",
            "\Vokuro\Models\EventProjects",
            "event_id",
            [
                'alias' => "projectsPivot"
            ]
        );

        $this->hasManyToMany(
            "id",
            "\Vokuro\Models\EventTags",
            "event_id", "tag_id",
            "\Vokuro\Models\Tags",
            "id",
            [
                "alias" => "tags"
            ]
            );

        $this->hasMany(
            "id",
            "\Vokuro\Models\EventTags",
            "tag_id",
            [
                'alias' => "tagsPivot"
            ]
        );

        $this->hasManyToMany(
            "id",
            "\Vokuro\Models\EventProcedures",
            "event_id", "procedure_id",
            "\Vokuro\Models\Procedures",
            "ID",
            [
                "alias" => "procedures"
            ]
            );

        $this->hasManyToMany(
            "id",
            "\Vokuro\Models\EventCompanyUsers",
            "event_id", "user_id",
            UsersMobile::class,
            "ID",
            [
                "alias" => "companyUsers"
            ]
            );

        $this->hasMany(
            "id",
            "\Vokuro\Models\EventCompanyUsers",
            "event_id",
            [
                "alias" => "comUsersPivot"
            ]
            );

        $this->hasMany(
            "id",
            "\Vokuro\Models\EventProcedures",
            "event_id",
            [
                'alias' => "eventProc"
            ]
        );

        $this->hasManyToMany(
            "id",
            "\Vokuro\Models\Events\EventNotificationTypes",
            "event_id", "notification_type_id",
            "\Vokuro\Models\Events\NotificationTypes",
            "id",
            [
                "alias" => "notification_types"
            ]
            );

        $this->belongsTo(
            "creator_id",
            UsersMobile::class,
            "ID",
            [
                'alias' => "creator"
            ]
        );

        $this->belongsTo(
            "notified_user",
            UsersMobile::class,
            "ID",
            [
                'alias' => "notifiedUser"
            ]
        );

        $this->belongsTo(
            "event_type",
            "\Vokuro\Models\EventTypes",
            "id",
            [
                'alias' => "type"
            ]
        );

        $this->belongsTo(
            "department_id",
            "\Vokuro\Models\EventDepartments",
            "id",
            [
                'alias' => "department"
            ]
        );

        $this->hasMany(
            "id",
            "\Vokuro\Models\Events\EventNotificationTypes",
            "event_id",
            [
                'alias' => "notificationTypesLink"
            ]
        );

        $this->hasMany(
            "id",
            "\Vokuro\Models\Events\EventInvitations",
            "event_id",
            [
                'alias' => "invitationsLink"
            ]
        );

        $this->hasMany(
            "id",
            "\Vokuro\Models\EventAttachments",
            "event_id",
            [
                'alias' => "attachments"
            ]
        );

        $this->belongsTo(
            "event_purpose",
            "\Vokuro\Models\Events\EventPurposes",
            "id",
            [
                'alias' => "purpose"
            ]
        );

        $this->belongsTo(
            "schedule_type",
            "\Vokuro\Models\Events\ScheduleTypes",
            "id",
            [
                'alias' => "scheduleType"
            ]
        );

        $this->belongsTo(
            "place_id",
            Places::class,
            "id",
            [
                'alias' => "place"
            ]
        );

        $this->hasMany(
            "id",
            EventReplies::class,
            "event_id",
            [
                'alias' => "replies",
                'params' => [
                    'order' => 'created_at DESC'  
                ]
            ]
        );

        $this->hasMany(
            "id",
            EventResponses::class,
            "event_id",
            [
                'alias' => "responses",
                'params' => [
                    'order' => 'created_at DESC'  
                ]
            ]
        );
    }

    public function getInvitations($parameters = null)
    {
        return $this->getRelated('invitations', $parameters);
    }

}
