<?php

namespace Vokuro\Models;

class UserInformation extends \Phalcon\Mvc\Model
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
    public $user_id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $mobile;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $address;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $location;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $notes;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $tag;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $source;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $job;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'user_information';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UserInformation[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UserInformation
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "user_type",
            "\Vokuro\Models\UserTypes",
            "id",
            [
                'alias' => "type"
            ]
        );
    }

}
