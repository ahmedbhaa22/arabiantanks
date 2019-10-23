<?php

namespace Vokuro\Models;

use Vokuro\Models\CompanyBranches;
use Vokuro\Models\CompanyDepartments;
use Vokuro\Models\CompanyUser;
use Vokuro\Models\EventCompanies;
use Vokuro\Models\Events\Events;
use Vokuro\Models\Projects;

class Companies extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $description;


    public $image;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'companies';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Companies[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Find in array of id's
     */
    public static function findIn(array $identifiers)
    {
        return self::query()
            ->inWhere('id', $identifiers)
            ->execute();
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Companies
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasMany(
            "id",
            CompanyBranches::class,
            "company_id",
            [
                'alias' => "branches"
            ]
        );

        $this->hasMany(
            'id',
            CompanyPaymentMethods::class,
            'company_id',
            [
                'alias' => 'paymentMethods'
            ]
        );
    }

}
