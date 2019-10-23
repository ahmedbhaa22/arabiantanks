<?php
namespace Models;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;

class DataFormsResponse extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=2, nullable=false)
     */
    public $Form_ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Response;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $IP;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $User_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=false)
     */
    public $Date;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_forms_response';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataFormsResponse[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataFormsResponse
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "Form_ID",
            '\DataFormsLang',
            "Form_ID",
            [
                'alias' => 'Lang',
                'reusable' => true
            ]
        );
    }
    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'form_id' =>'Form_ID',
            'response' => 'Response',
            'ip' => 'IP',
            'user_id' => 'User_ID',
            'date' => 'Date',
        );


    }

}
