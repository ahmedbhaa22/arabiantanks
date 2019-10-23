<?php

class DataModuleRelationsCms extends \Phalcon\Mvc\Model
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
    public $rel_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $item_cms_one;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $parent_cms_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_module_relations_cms';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataModuleRelationsCms[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataModuleRelationsCms
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        
        $this->belongsTo(
            "item_cms_one",
            'Models\Content',
            "ID",
            [
                'alias' => 'Offers',
                'reusable' => true
            ]
        );
		
		$this->belongsTo(
            "parent_cms_id",
            'Models\Content',
            "ID",
            [
                'alias' => 'Parent',
                'reusable' => true
            ]
        );
    }

}
