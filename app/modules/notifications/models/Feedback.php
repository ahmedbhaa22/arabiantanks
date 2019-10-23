<?php

namespace Vokuro\Notifications\Models;

class Feedback extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Tokens;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Feedback;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Device_Type;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'push_feedback';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushFeedback[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PushFeedback
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
