<?php

namespace Vokuro\Geo\Models;

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
    public $enable_continents;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_countries;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_states;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_city;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_regions;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $enable_streets;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'geo_settings';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return GeoSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return GeoSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasManyToMany(
            "id",
            GeoLangs::class,
            "setting_id", "lang_id",
            \Languages::class,
            "id",
            [
                "alias" => "langs"
            ]
            );

        $this->hasMany(
            "id",
            GeoLangs::class,
            "setting_id",
            [
                'alias' => "langsPivot",
            ]
        );
    }

    public function hasLang($lang_id)
    {
        $langs = $this->langs;
        $langs = array_map(function($item){
            return $item['id'];
        }, $this->langs->toArray());
        return in_array($lang_id, $langs);
    }

}
