<?php

namespace Vokuro\Messages\Models;

class Groups extends \Phalcon\Mvc\Model
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
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $created_by;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $public;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_messages_groups';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessagesGroups[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessagesGroups
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasMany(
            "id",
            MessagesRelation::class,
            "group_id",
            [
                'alias' => "messageRelation"
            ]
        );

        $this->hasManyToMany(
            "id",
            GroupUsers::class,
            "group_id", "user_id",
            UsersMobile::class,
            "ID",
            [
                "alias" => "users"
            ]
            );
    }

}
