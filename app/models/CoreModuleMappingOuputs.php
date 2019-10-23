<?php

class CoreModuleMappingOuputs extends \Phalcon\Mvc\Model
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
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Module_ID;

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
    public $Mapping_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Parameter;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Name_Array;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Path;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Array;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=false)
     */
    public $Array_Key;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'core_module_mapping_ouputs';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CoreModuleMappingOuputs[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CoreModuleMappingOuputs
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
