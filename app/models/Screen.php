<?php

class Screen extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=11, nullable=false)
     */
    public $project_id;

    public $group;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'screen';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Screen[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Screen
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->hasMany(
            "id",
            '\ScreenMedia',
            "screen_id",
            [
                'alias' => 'Screens',
                'reusable' => true
            ]
        );
        $this->hasMany(
            "id",
            '\Api',
            "screen_id",
            [
                'alias' => 'Api',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "group_id",
            '\ApiGroup',
            "id",
            [
                'alias' => 'Group',
                'reusable' => true
            ]
        );
        $this->hasMany(
            "id",
            '\ApiAppScreenAttachments',
            "screen_id",
            [
                'alias' => 'Attach',
                'reusable' => true
            ]
        );
    }
}
