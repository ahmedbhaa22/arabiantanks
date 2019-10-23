<?php

class CpModulesTranslation extends \Phalcon\Mvc\Model
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
    public $module_id;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $word_key;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $value;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $lang_id;
	
	
	public $core_dept_id;

	

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'cp_modules_translation';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpModulesTranslation[]|CpModulesTranslation
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpModulesTranslation
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
