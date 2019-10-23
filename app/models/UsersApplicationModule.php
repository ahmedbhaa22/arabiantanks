<?php

class UsersApplicationModule extends \Phalcon\Mvc\Model
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
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Package_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Orginal_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Copy_Module_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Title;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Login;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Setting;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Auth_Setting;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $BG_Iphone;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $BG_Ipad;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $BG_Android;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Base_URL;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Get_Orders_Setting;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Color;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $With_Key_Value;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Mapping_Api;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Plugin_Api;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Active;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_application_module';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationModule[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplicationModule
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function getModuleTitleByID($id){

        $query = new Query(
            "SELECT title FROM users_application_module WHERE ID=".$id,
            $this->getDI()
        );
        $module = $query->execute();
        return $module;
    }

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'application_id' => 'Application_ID',
            'package_id' => 'Package_ID',
            'orginal_id' => 'Original_ID',
            'copy_module_id' => 'Copy_Module_ID',
            'title' => 'Title',
            'login' => 'Login',
            'setting' => 'Setting',
            'auth_setting' => 'Auth_Setting',
            'bg_iphone' => 'BG_Iphone',
            'bg_ipad' => 'BG_Ipad',
            'bg_android' => 'BG_Android',
            'base_url' => 'Base_URL',
            'get_orders_setting' => 'Get_Orders_Setting',
            'color' => 'Color',
            'with_key_value' => 'With_Key_Value',
            'mapping_api' => 'Mapping_Api',
            'plugin_api' => 'Plugin_Api',
            'active' => 'Active',

        );
    }
    public function initialize()
    {
        $this->belongsTo(
            "ID",
            '\CpModulesSettings',
            "Module_ID",
            [
                'alias' => 'Settings',
                'reusable' => true
            ]
        );
		$this->belongsTo(
            "ID",
            '\UsersApplicationModuleLang',
            "module_id",
            [
                'alias' => 'Lang',
                'reusable' => true
            ]
        );
    }
}
