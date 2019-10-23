<?php

class DataCmsImport extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $ID;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $Name;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Data;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Type;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Order;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $Operating_Menu;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $Content;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $Depts_ID;

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'name' => 'Name',
            'data' => 'Data',
            'type' => 'Type',
            'order' => 'Order',
            'operating_menu' => 'Operating_Menu',
            'content' => 'Content',
            'depts_id' => 'Depts_ID',
            'application_id' => 'Application_ID',
            'module_id' => 'Module_ID',
        );


    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_cms_import';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsImport[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsImport
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "Type",
            '\DataCmsImportType',
            "ID",
            [
                'alias' => 'ImportType',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "Type",
            '\DataCmsImportOrderOption',
            "ID",
            [
                'alias' => 'OrderName',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "Depts_ID",
            '\DataCmsDeptsRel',
            "ID",
            [
                'alias' => 'Dept',
                'reusable' => true
            ]
        );
    }

}
