<?php

class ScreenMedia extends \Phalcon\Mvc\Model
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
    public $media;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $screen_id;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $type;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'screen_media';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ScreenMedia[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ScreenMedia
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->hasMany(
            "id",
            '\ApiAppScreenshotComments',
            "screen_shot",
            [
                'alias' => 'comments',
                'reusable' => true
            ]
        );
    }


}
