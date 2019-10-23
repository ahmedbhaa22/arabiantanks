<?php

class CoreModuleMappingInputs extends \Phalcon\Mvc\Model
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
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Mapping_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=false)
     */
    public $Orginal_Parameter;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=false)
     */
    public $Input_Parameter;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Action_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Application_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'core_module_mapping_inputs';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CoreModuleMappingInputs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CoreModuleMappingInputs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
