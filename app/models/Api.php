<?php

class Api extends \Phalcon\Mvc\Model
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
    public $title;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $des;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $project_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $screen_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $success_response;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $fail_response;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $empty_response;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $type_method;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $api_link;
    public $group;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'api';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Api[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Api
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "screen_id",
            '\Screen',
            "id",
            [
                'alias' => 'ScreenMain',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "project_id",
            "Vokuro\Models\Projects",
            "id",
            [
                'alias' => 'ProjectDetails',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "group",
            "\ApiGroup",
            "id",
            [
                'alias' => 'Group',
                'reusable' => true
            ]
        );
        $this->hasMany(
            "id",
            "\ApiParam",
            "api_id",
            [
                'alias' => 'Param',
                'reusable' => true
            ]
        );
    }
}
