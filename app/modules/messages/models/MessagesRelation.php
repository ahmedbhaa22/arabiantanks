<?php

namespace Vokuro\Messages\Models;

class MessagesRelation extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=10, nullable=false)
     */
    public $ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Message_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Main;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Read;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Delete;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $From_User_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $To_User_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Parent_ID;

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
        return 'data_message_relations';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessagesRelation[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessagesRelation
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "data_message_id",
            "\Vokuro\Models\DataMessages\Messages",
            "id",
            [
                'alias' => "message"
            ]
        );

        $this->belongsTo(
            "from_user_id",
            "\Models\UsersMobile",
            "ID",
            [
                'alias' => 'sender'
            ]
        );

        $this->belongsTo(
            "to_user_id",
            "\Models\UsersMobile",
            "ID",
            [
                'alias' => 'receiver'
            ]
        );

        $this->belongsTo(
            "group_id",
            Groups::class,
            "id",
            [
                'alias' => 'group'
            ]
        );
    }

}
