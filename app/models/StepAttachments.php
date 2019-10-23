<?php

namespace Vokuro\Models;

class StepAttachments extends \Phalcon\Mvc\Model
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
    public $step_id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $type;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $url;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'step_attachments';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return StepAttachments[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return StepAttachments
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public static function getType($extension)
    {
        if(in_array($extension, ['jpg', 'jpeg', 'png'])){
            return 'image';
        }elseif (in_array($extension, ['mp4'])) {
            return 'video';
        }elseif (in_array($extension, ['mp3'])) {
            return 'audio';
        }
    }

}
