<?php

class UsersMood extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Users_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Supervisor_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Mood_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Date;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Module_ID;

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'users_id' => 'Users_ID',
            'type_id' => 'Type_ID',
            'supervisor_id' => 'Supervisor_ID',
            'mood_id' => 'Mood_ID',
            'date' => 'Date',
            'application_id' =>'Application_ID',
            'module_id' => 'Module_ID'
        );


    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users_mood';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersMood[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersMood
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
