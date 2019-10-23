<?php

namespace Vokuro\Models;

class Procedures extends \Phalcon\Mvc\Model
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

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $department_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'procedures';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Procedures[]
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
     * @return Procedures
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasMany(
            "id",
            "\Vokuro\Models\ProcedureSteps",
            "procedure_id",
            [
                'alias' => "steps"
            ]
        );
    }

}
