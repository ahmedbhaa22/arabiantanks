<?php

namespace Vokuro\Models;

class ProcedureSteps extends \Phalcon\Mvc\Model
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
    public $order;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $description;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $procedure_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'procedure_steps';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ProcedureSteps[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ProcedureSteps
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasMany(
            "id",
            "\Vokuro\Models\StepAttachments",
            "step_id",
            [
                'alias' => "attachments"
            ]
        );
    }

}
