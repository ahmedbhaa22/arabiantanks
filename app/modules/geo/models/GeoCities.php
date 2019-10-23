<?php

namespace Vokuro\Geo\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoStates;
use Vokuro\Models\Behaviors\Loggable;

class GeoCities extends Model
{
	public $id;
	public $name;
	public $code;
	public $country_id;
	
	public function getSource()
    {
        return 'geo_cities';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasMany(
            "id",
            GeoRegions::class,
            "city_id",
            [
                'alias' => "regions"
            ]
        );

        $this->belongsTo(
            "state_id",
            GeoStates::class,
            "id",
            [
                'alias' => "state"
            ]
        );

        $this->hasMany(
            "id",
            GeoCitiesLang::class,
            "city_id",
            [
                'alias' => "langs"
            ]
        );
    }

    public function addLang($lang_id, $name)
    {
        $lang = new GeoCitiesLang;
        $lang->city_id = $this->id;
        $lang->name = $name;
        $lang->lang_id = $lang_id;
        $lang->save();

        return $lang;
    }

    public function addParent($parent_id)
    {
        $this->state_id = $parent_id;
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

        return $this->name;
    }
}