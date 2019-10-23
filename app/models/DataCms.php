<?php

namespace Vokuro\Models;

use Phalcon\Mvc\Model\Query;

class DataCms extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", length=255, nullable=true)
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
     * @Column(type="string", nullable=true)
     */
    public $Content;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=true)
     */
    public $Order;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $User_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $Img;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Visit_Num;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $DateTime;

    /**
     *
     * @var integer
     * @Column(type="integer", length=1, nullable=false)
     */
    public $Active;

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

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Lang_ID;

    /**
     *
     * @var string
     * @Column(type="string", length=250, nullable=false)
     */
    public $Key_1;

    /**
     *
     * @var string
     * @Column(type="string", length=250, nullable=false)
     */
    public $Key_2;

    /**
     *
     * @var string
     * @Column(type="string", length=250, nullable=false)
     */
    public $Key_3;

    /**
     *
     * @var string
     * @Column(type="string", length=250, nullable=false)
     */
    public $Key_4;

    /**
     *
     * @var string
     * @Column(type="string", length=250, nullable=false)
     */
    public $Key_5;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_cms';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCms[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCms
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function getModuleTitleByID($id){

        $query = new Query(
            "SELECT Title FROM UsersApplicationModule WHERE ID=".$id,
            $this->getDI()
        );
        $module = $query->execute();
        return $module;
    }

}
