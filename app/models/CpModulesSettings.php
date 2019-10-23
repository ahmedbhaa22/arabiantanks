<?php

class CpModulesSettings extends \Phalcon\Mvc\Model
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
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Toggle_Grid;
    public $Has_Orders;
    public $Img;
    public $Content_Img;
    public $Content_Stat_Img;
    public $Module_Banner;
    public $Content_Banner;
	public $Content_Edit_Banner;
    public $kv_price_param;
    public $export_fields_json;
    public $import_export_enabled;
    public $extra_fields;
    public $has_tags;
    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'cp_modules_settings';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpModulesSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpModulesSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'module_id' => 'Module_ID',
            'toggle_grid' => 'Toggle_Grid',
            'has_orders' => 'Has_Orders',
            'has_media' =>'Has_Media',
            'img' =>'Img',
            'content_img' =>'Content_Img',
            'content_stat_img' =>'Content_Stat_Img',
            'module_banner'=>'Module_Banner',
            'content_banner'=>'Content_Banner',
            'content_edit_banner'=>'Content_Edit_Banner',
            'kv_price_param'=>'kv_price_param',
            'export_fields_json' => 'export_fields_json',
            'import_export_enabled' => 'import_export_enabled',
            'extra_fields' => 'extra_fields',
            'has_tags'=>'has_tags'
        );


    }

}
