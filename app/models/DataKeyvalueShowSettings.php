<?php

class DataKeyvalueShowSettings extends \Phalcon\Mvc\Model
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
    public $dkv_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $title;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $des;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $img;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_keyvalue_show_settings';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueShowSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalueShowSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
