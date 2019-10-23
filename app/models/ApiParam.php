<?php

class ApiParam extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=10, nullable=false)
     */
    public $param_name;

    /**
     *
     * @var string
     * @Column(type="string", length=35, nullable=true)
     */
    public $param_des;

    /**
     *
     * @var string
     * @Column(type="string", length=35, nullable=true)
     */
    public $param_link;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $api_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'api_param';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ApiParam[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ApiParam
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
