<?php

namespace Vokuro\Models;

use Vokuro\Models\Tags;

class Places extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=1024, nullable=false)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $longitude;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $latitude;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'places';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Places[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Find in array of id's
     */
    public static function findIn(array $identifiers)
    {
        return self::query()
            ->inWhere('id', $identifiers)
            ->execute();
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Places
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasManyToMany(
            "id",
            PlaceTags::class,
            "place_id", "tag_id",
            Tags::class,
            "id",
            [
                "alias" => "tags"
            ]
        );

        $this->hasMany(
            "id",
            PlaceTags::class,
            "place_id",
            [
                'alias' => "tagsPivot"
            ]
        );
    }

}
