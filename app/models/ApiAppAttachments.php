<?php

class ApiAppAttachments extends \Phalcon\Mvc\Model
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
    public $project_id;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $file;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=true)
     */
    public $des;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $type;


    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'api_app_attachments';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ApiAppAttachments[]|ApiAppAttachments
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ApiAppAttachments
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
