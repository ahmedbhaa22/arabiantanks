<?php

class CpUserProfile extends \Phalcon\Mvc\Model
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
    public $User_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Profile_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $banned;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=false)
     */
    public $suspended;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=true)
     */
    public $active;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=true)
     */
    public $mustChangePassword;


    public $Cp_Lang;

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'user_id' => 'User_ID',
            'profile_id' => 'Profile_ID',
            'banned' =>'banned',
            'suspended'=>'suspended',
            'active'=>'active',
            'mustChangePassword'=>'mustChangePassword',
            'cp_lang' =>'Cp_Lang',
            'scheme_file'=>'Scheme_File'

        );


    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'cp_user_profile';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpUserProfile[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpUserProfile
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "Profile_ID",
            'Vokuro\Models\Profiles',
            "id",
            [
                'alias' => 'Profiles',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "User_ID",
            'Models\UsersMobile',
            "ID",
            [
                'alias' => 'UsersMobile',
                'reusable' => true
            ]
        );
		$this->belongsTo(
            "Cp_Lang",
            '\Languages',
            "code",
            [
                'alias' => 'LangDetails',
                'reusable' => true
            ]
        );
    }
}
