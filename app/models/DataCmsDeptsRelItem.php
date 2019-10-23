<?php
use Vokuro\Models\Behaviors\Loggable;
class DataCmsDeptsRelItem extends \Phalcon\Mvc\Model
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
     * @Column(type="integer", length=10, nullable=true)
     */
    public $Item_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Depts_ID;

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
            'item_id' => 'Item_ID',
            'des' => 'Des',
            'depts_id' => 'Depts_ID',
            'application_id' => 'Application_ID',
            'module_id' => 'Module_ID',
        );


    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_cms_depts_rel_items';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsDeptsRelItem[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsDeptsRelItem
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->addBehavior(new Loggable());
        $this->belongsTo(
            "Item_ID",
            'Models\Content',
            "ID",
            [
                'alias' => 'Content',
                'reusable' => true
            ]
        );
		$this->belongsTo(
            "Depts_ID",
            '\DataCmsDeptsRel',
            "ID",
            [
                'alias' => 'DeptDetails',
                'reusable' => true
            ]
        );
		$this->hasMany(
            "Item_ID",
            '\DataKeyvalueUserdata',
            "Item_ID",
            [
                'alias' => 'KeyvalueUserdata',
                'reusable' => true
            ]
        );

        //GoAppRel

        $this->hasMany(
            "Item_ID",
            'Models\GoappDataCmsZones',
            "data_cms_id",
            [
                'alias' => 'Zones',
                'reusable' => true
            ]
        );
    }
}
