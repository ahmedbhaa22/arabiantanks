<?php

class CpFormsReplies extends \Phalcon\Mvc\Model
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
    public $Forms_Response;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Date;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $User_ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Replay;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'cp_forms_replies';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpFormsReplies[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CpFormsReplies
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
            'forms_response' => 'Forms_Response',
            'date' => 'Date',
            'user_ID' => 'User_ID',
            'replay' => 'Replay',
        );


    }
}
