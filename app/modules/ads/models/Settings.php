<?php

namespace Vokuro\Ads\Models;

class Settings extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_width;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_height;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_start_date;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_end_date;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_picture;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_thumbnail;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_application_ads_settings';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationAdsSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationAdsSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
