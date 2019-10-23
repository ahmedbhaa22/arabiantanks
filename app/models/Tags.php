<?php

namespace Vokuro\Models;

use Models\EntityTags;
use Models\Content;

class Tags extends \Phalcon\Mvc\Model
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
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'tags';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Tags[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Tags
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasManyToMany(
            "id",
            EntityTags::class,
            "tag_id", "item_id",
            Content::class,
            "ID",
            [
                "alias" => "products",
                "params" => [
                    "conditions" => EntityTags::class . ".entity_id = 1"
                ]
            ]
        );
    }

    public function productsCount()
    {
        return count($this->products);
    }
}
