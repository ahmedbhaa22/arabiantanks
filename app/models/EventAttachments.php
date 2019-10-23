<?php

namespace Vokuro\Models;

class EventAttachments extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $type;

    /**
     *
     * @var string
     * @Column(type="string", length=2048, nullable=false)
     */
    public $url;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'event_attachments';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return EventAttachments[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return EventAttachments
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
