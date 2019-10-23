<?php

class ApiAppScreenshotComments extends \Phalcon\Mvc\Model
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
    public $screen_shot;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=false)
     */
    public $title;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $comment;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=true)
     */
    public $created_date;

   

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'api_app_screenshot_comments';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return ApiAppScreenshotComments[]|ApiAppScreenshotComments
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return ApiAppScreenshotComments
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
