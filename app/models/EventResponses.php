<?php

namespace Vokuro\Models;

use Models\UsersMobile;
use Vokuro\Models\EventResponseTypes;

class EventResponses extends \Phalcon\Mvc\Model
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
    public $event_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $user_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $response;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $response_type;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $confirm;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'event_responses';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return EventResponses[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return EventResponses
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "event_id",
            "\Vokuro\Models\Events\Events",
            "id",
            [
                'alias' => "event"
            ]
        );

        $this->belongsTo(
            "user_id",
            UsersMobile::class,
            "ID",
            [
                'alias' => "user"
            ]
        );

        $this->belongsTo(
            "response_type",
            EventResponseTypes::class,
            "id",
            [
                'alias' => "responseType"
            ]
        );

        $this->hasMany(
            "id",
            ResponseComments::class,
            "response_id",
            [
                'alias' => "comments",
                'params' => [
                    'order' => 'created_at DESC'  
                ]
            ]
        );
    }

}
