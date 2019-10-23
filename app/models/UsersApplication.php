<?php
class UsersApplication extends \Phalcon\Mvc\Model
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
    public $Account_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Title;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Des;

    /**
     *
     * @var string
     * @Column(type="string", length=10, nullable=false)
     */
    public $Type_App_Platform;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Type_App_Lang;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Menu_Depts_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Menu_Version_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Menu_Layout_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Field_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Icon;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Splash_Screen;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $BG;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Logo;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $Date;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Color_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Ads_Setting;

    /**
     *
     * @var integer
     * @Column(type="integer", length=6, nullable=false)
     */
    public $Setting_Cache;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Setting_App;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Theme_Color_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Menu_Updated;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Push_Notifications;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Live;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $New_DZ;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Splash_Screen_iPhone;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Splash_Screen_iPad;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Splash_Screen_Android;

    /**
     *
     * @var integer
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Free;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Main_Page_Layout_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Main_Page_Api;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Entry_Point;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public $Application_Route;
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'account_id' => 'Account_ID',
            'title' => 'Title',
            'des' =>'Des',
            'type_app_platform' => 'Type_App_Platform',
            'type_app_lang' => 'Type_App_Lang',
            'menu_depts_id' => 'Menu_Depts_ID',
            'menu_version_id' => 'Menu_Version_ID',
            'menu_layout_id' => 'Menu_Layout_ID',
            'field_id' => 'Field_ID',
            'icon' => 'Icon',
            'splash_screen' => 'Splash_Screen',
            'bg' => 'BG',
            'logo' => 'Logo',
            'date' => 'Date',
            'color_id' => 'Color_ID',
            'ads_setting' => 'Ads_Setting',
            'setting_cache' => 'Setting_Cache',
            'setting_app' => 'Setting_App',
            'theme_color_id' => 'Theme_Color_ID',
            'menu_updated' => 'Menu_Updated',
            'push_notifications' => 'Push_Notifications',
            'live' => 'Live',
            'new_dz' => 'New_DZ',
            'splash_screen_iphone' => 'Splash_Screen_iPhone',
            'splash_screen_ipad' => 'Splash_Screen_iPad',
            'splash_screen_android' => 'Splash_Screen_Android',
            'free' => 'Free',
            'main_page_layout_id' => 'Main_Page_Layout_ID',
            'main_page_api' => 'Main_Page_Api',
            'entry_point' => 'Entry_Point',
            'application_route' => 'Application_Route'

        );
    }
    public function getSource()
    {
        return 'users_application';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplication[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersApplication
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->hasMany(
            "ID",
            '\UsersApplicationModule',
            "Application_ID",
            [
                'alias' => 'Modules',
                'reusable' => true
            ]
        );
		 
        $this->hasMany(
            "ID",
            '\ApplicationCmsLang',
            "application_id",
            [
                'alias' => 'Langs',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "ID",
            '\CpApplicationSettings',
            "Application_ID",
            [
                'alias' => 'Settings',
                'reusable' => true
            ]
        );
    }
}
