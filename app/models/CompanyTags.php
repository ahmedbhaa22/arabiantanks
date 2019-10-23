<?php

namespace Vokuro\Models;

use Vokuro\Models\Companies;

class CompanyTags extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $company_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $tag_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'company_tags';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CompanyTags[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Find in array of id's
     */
    public static function findIn($col = 'id', array $identifiers)
    {
        return self::query()
            ->inWhere($col, $identifiers)
            ->execute();
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CompanyTags
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "tag_id",
            Tags::class,
            "id"
        );

        $this->belongsTo(
            "company_id",
            Companies::class,
            "id"
        );
    }

}
