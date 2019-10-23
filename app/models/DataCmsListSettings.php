<?php

class DataCmsListSettings extends \Phalcon\Mvc\Model
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
    public $Module_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Title;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Des;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Content;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Order;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Img;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Visit_Num;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $DateTime;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Active;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=false)
     */
    public $Depts;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Application_ID;
	
	public $Add;
	public $Delete;

    public function columnMap()
    {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'module_id' => 'Module_ID',
            'title' => 'Title',
            'des' => 'Des',
            'content' => 'Content',
            'order' => 'Order',
            'img' => 'Img',
            'visit_num' => 'Visit_Num',
            'datetime' => 'DateTime',
            'active' => 'Active',
            'depts' => 'Depts',
            'application_id' => 'Application_ID',
            'add' => 'Add',
            'delete'=>'Delete'
        );


    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_cms_list_settings';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsListSettings[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsListSettings
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
