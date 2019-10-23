<?php

namespace Vokuro\Polls\Models;

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
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $use_fb;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $banner_image;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $application_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'poll_settings';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
