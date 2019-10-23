<?php

namespace Vokuro\Models;

class CompanyUser extends \Phalcon\Mvc\Model
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
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $company_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'company_user';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CompanyUser[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Find in array of id's
     */
    public static function findIn($col = 'id', array $identifiers)
    {
        return self::query()
            ->inWhere($col, $identifiers)
            ->execute();
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CompanyUser
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "user_id",
            "Models\UsersMobile",
            "ID"
        );

        $this->belongsTo(
            "company_id",
            "Models\Companies",
            "id"
        );
    }

}
