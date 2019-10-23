<?php

namespace Vokuro\Messages\Models;

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
    public $db_type;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $chat_type;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $banner_image;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_messages_settings';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessagesSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataMessagesSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
