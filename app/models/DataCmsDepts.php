<?php
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Models\Behaviors\Loggable;
class DataCmsDepts extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=750, nullable=false)
     */
    public $Des;

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
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Target_Layout_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $Target_Action_ID;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function initialize()
    {
        $this->addBehavior(new Loggable());
        $this->hasMany(
            "ID",
            '\DataCmsDeptsRel',
            "Core_Depts_ID",
            [
                'alias' => 'Depts',
                'reusable' => true
            ]
        );
        $this->allowEmptyStringValues(
            array(
                "Title",
                "Des",
            )
        );

    }
    public function getSource()
    {
        return 'data_cms_depts';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsDepts[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsDepts
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function getTitleByLang($lang_id)
    {
        $title= DataCmsDeptsLang::findFirst(["core_dept_id={$this->ID} and lang_id={$lang_id}"]);
        if(!$title){
            return $this->Title;
        }else{
            return $title->title;
        }
    }

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'title' => 'Title',
            'des' => 'Des',
            'img' => 'Img',
            'application_id' => 'Application_ID',
            'module_id' => 'Module_ID',
            'target_layout_id' => 'Target_Layout_ID',
            'target_action_id' => 'Target_Action_ID',
        );


    }



}
