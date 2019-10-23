<?php
namespace Models;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
class DataCmsOrderStatusLang extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $ID;
	public $Status_Title;
	public $Status_ID;
	public $Lang_ID;
    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=false)
     */
    public $Status_Name;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_cms_order_status_lang';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrderStatusLang[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrderStatusLang
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
            'status_title' => 'Status_Title',
            'status_id' => 'Status_ID',
            'lang_id'=>'Lang_ID'
        );


    }

}
