<?php

class UsersAdvanced extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Class_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $User_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Date;

	public $First_Name;
	public $Last_Name;
	public $Date_Birth;
	
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'class_id' => 'Class_ID',
            'user_id' => 'User_ID',
            'date' => 'Date',
            'first_name' => 'First_Name',
            'last_name' => 'Last_Name',
            'date_birth' => 'Date_Birth',
        );


    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_advanced';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersAdvanced[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersAdvanced
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
