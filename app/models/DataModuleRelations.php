<?php

class DataModuleRelations extends \Phalcon\Mvc\Model
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
    public $module_one;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $model_two;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $application_id;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=true)
     */
    public $rel_type;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_module_relations';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataModuleRelations[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataModuleRelations
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
	public function initialize(){
		$this->belongsTo(
            "module_one",
            '\UsersApplicationModule',
            "ID",
            [
                'alias' => 'ModuleInfo',
                'reusable' => true
            ]
        );
		$this->belongsTo(
            "model_two",
            '\UsersApplicationModule',
            "ID",
            [
                'alias' => 'RelatedModuleInfo',
                'reusable' => true
            ]
        );
	}

}
