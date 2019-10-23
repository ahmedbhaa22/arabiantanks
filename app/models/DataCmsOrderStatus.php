<?php
namespace Models;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
class DataCmsOrderStatus extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $ID;
	public $Module_ID;
	public $Application_ID;
    public $parent_status_id;
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
        return 'data_cms_order_status';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrderStatus[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsOrderStatus
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
            'status_name' => 'Status_Name',
            'module_id' => 'Module_ID',
            'application_id'=>'Application_ID',
            'display_name'=>'display_name',
            'display_name_ar'=>'display_name_ar',
            'parent_status_id'=>'parent_status_id'
        );


    }
	public function initialize()
    {
    	$this->belongsTo(
            "ID",
            'Models\DataCmsOrderStatusLang',
            "Status_ID",
            [
                'alias' => 'Lang',
                'reusable' => true
            ]
        );
	}

    public static function wishlist()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%wishlist%'
            ]
        ])->ID;
    }

    public static function cart()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%cart%'
            ]
        ])->ID;
    }

    public static function newOrder()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%new_order%'
            ]
        ])->ID;
    }

    public static function paymentConfirmed()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%payment_confirmed%'
            ]
        ])->ID;
    }

    public static function paymentRejected()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%payment_rejected%'
            ]
        ])->ID;
    }

    public static function pending()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%pending%'
            ]
        ])->ID;
    }

    public static function shipping()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%shipping%'
            ]
        ])->ID;
    }

    public static function delivered()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%delivered%'
            ]
        ])->ID;
    }

    public static function canceled()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%canceled%'
            ]
        ])->ID;
    }

    public static function returned()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%returned%'
            ]
        ])->ID;
    }

    public static function inProgress()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%in_progress%'
            ]
        ])->ID;
    }

    public static function returnedWithPermission()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%returned_with_permission%'
            ]
        ])->ID;
    }

    public static function fixProduct()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%fix_product%'
            ]
        ])->ID;
    }

    public static function returnProduct()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%return_product%'
            ]
        ])->ID;
    }

    public static function rejectProduct()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%reject_product%'
            ]
        ])->ID;
    }

    public static function cancel()
    {
        return static::findFirst([
            'Status_Name like {name}',
            'bind' => [
                'name' => '%cancel%'
            ]
        ])->ID;
    }

}
