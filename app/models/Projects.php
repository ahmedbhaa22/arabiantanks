<?php

namespace Vokuro\Models;

use Models\UsersMobile;
use Vokuro\Models\EventProjects;
use Vokuro\Models\Events\Events;
use Vokuro\Models\ProjectUsers;

class Projects extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=255, nullable=false)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $description;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $note;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $tag;

    /**
     *
     * @var string
     * @Column(type="string", length=1024, nullable=true)
     */
    public $source;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $client_id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $client_type;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'projects';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Projects[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Projects
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasManyToMany(
            "id",
            ProjectClient::class,
            "project_id", "client_id",
            UsersMobile::class,
            "ID",
            [
                "alias" => "clients"
            ]
        );

        $this->hasMany(
            "id",
            ProjectClient::class,
            "project_id",
            [
                'alias' => "clientsPivot"
            ]
        );

        $this->hasManyToMany(
            "id",
            EventProjects::class,
            "project_id", "event_id",
            Events::class,
            "id",
            [
                "alias" => "events"
            ]
        );

        $this->hasMany(
            "id",
            EventProjects::class,
            "project_id",
            [
                'alias' => "eventsPivot"
            ]
        );

        $this->hasManyToMany(
            "id",
            ProjectUsers::class,
            "project_id", "user_id",
            UsersMobile::class,
            "ID",
            [
                "alias" => "users"
            ]
        );

        $this->hasMany(
            "id",
            ProjectUsers::class,
            "project_id",
            [
                'alias' => "usersPivot"
            ]
        );

        $this->belongsTo(
            "client_id",
            "\Vokuro\Models\Companies",
            "id",
            [
                'alias' => "company"
            ]
        );

        $this->hasManyToMany(
            "id",
            ProjectTags::class,
            "project_id", "tag_id",
            Tags::class,
            "id",
            [
                "alias" => "tags"
            ]
        );

        $this->hasMany(
            "id",
            ProjectTags::class,
            "project_id",
            [
                'alias' => "tagsPivot"
            ]
        );
        $this->hasMany(
            "id",
            "\UsersApplicationModule",
            "Application_ID",
            [
                'alias' => "Modules"
            ]
        );
    }

}
