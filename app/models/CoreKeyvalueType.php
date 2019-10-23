<?php

class CoreKeyvalueType extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=10, nullable=false)
     */
    public $ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Title;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=false)
     */
    public $Description;

    /**
     *
     * @var string
     * @Column(type="string", length=250, nullable=false)
     */
    public $Img;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'title' => 'Title',
            'description' => 'Description',
            'img' => 'Img',
            'name' => 'name',


        );
    }
    public function getSource()
    {
        return 'core_keyvalue_type';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CoreKeyvalueType[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CoreKeyvalueType
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
