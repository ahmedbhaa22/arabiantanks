<?php

namespace Vokuro\Geo\Models;

class GeoStreets extends \Phalcon\Mvc\Model
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
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $code;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $district_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'geo_streets';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return GeoStreets[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return GeoStreets
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "region_id",
            GeoRegions::class,
            "id",
            [
                'alias' => "region"
            ]
        );

        $this->hasMany(
            "id",
            GeoStreetsLang::class,
            "street_id",
            [
                'alias' => "langs"
            ]
        );
    }

    public function addLang($lang_id, $name)
    {
        $lang = new GeoStreetsLang;
        $lang->street_id = $this->id;
        $lang->name = $name;
        $lang->lang_id = $lang_id;
        $lang->save();

        return $lang;
    }

    public function addParent($parent_id)
    {
        $this->region_id = $parent_id;
    }

    public function getName()
    {
        $lang_id = $this->getDI()->getAuth()->getIdentity()['Lang'];
        $lang_id = $lang_id == 'ar' ? 2 : 1;
        
        // check if current lang has name
        $names = $this->getLangs([
            "lang_id = :lang:",
            "bind" => [
                "lang" => $lang_id
            ]
        ]);
        
        if(count($names)){
            return $names->getFirst()->name;
        }

        return $this->langs->getFirst()->name;
    }

}
