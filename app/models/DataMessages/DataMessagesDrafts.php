<?php

namespace Vokuro\Models\DataMessages;

class DataMessagesDrafts extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Content;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $To_User_ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $subject;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Module_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_messages_drafts';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessagesDrafts[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessagesDrafts
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "To_User_ID",
            "\Models\UsersMobile",
            "ID",
            [
                'alias' => 'receiver'
            ]
        );
    }

}
