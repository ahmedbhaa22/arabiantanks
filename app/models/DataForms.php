<?php
namespace Models;
use Phalcon\Mvc\Model;


class DataForms extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Application_ID;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Type;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Target_Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Target_Action_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Target_Layout_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Login;

    /**
     *
     * @var string
     * @Column(type="string", length=245, nullable=false)
     */
    public $Api;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Notifications;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $See_Responses;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_forms';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataForms[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataForms
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "Module_ID",
            '\UsersApplicationModule',
            "ID",
            [
                'alias' => 'Module',
                'reusable' => true
            ]
        );

        $this->belongsTo(
            "ID",
            '\DataFormsLang',
            "Form_ID",
            [
                'alias' => 'Lang',
                'reusable' => true
            ]
        );
    }
//    public function filterSearch($Title,$Type, $Module){
//        $result = $this->modelsManager->createQuery("SELECT DataForms.*,DataForms.ID AS form_id FROM DataForms
//        INNER JOIN DataFormsLang ON DataFormsLang.Form_ID = DataForms.ID
//        WHERE DataFormsLang.Title LIKE '%" . $Title . "%' AND DataForms.Module_ID={$Module} AND DataForms.Type LIKE '%" . $Type . "%'
//        ")->execute();
//        return $result;
//    }

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'type' =>'Type',
            'module_id' => 'Module_ID',
            'application_id' => 'Application_ID',
            'target_module_id' => 'Target_Module_ID',
            'target_action_id' => 'Target_Action_ID',
            'target_layout_id' => 'Target_Layout_ID',
            'login' => 'Login',
            'api' => 'Api',
            'notifications' => 'Notifications',
            'see_responses' => 'See_Responses',
        );


    }

}
