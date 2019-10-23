<?php
class DataKeyvalueDeptCms extends \Phalcon\Mvc\Model
{
    public $id;
    public $dkv_id;
    public $item_id;
    public $application_id;
    public $module_id;
    public $dept_id;
    public function getSource()
    {
        return 'data_keyvalue_dept_cms';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalue[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataKeyvalue
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
        "dkv_id",
        '\DataKeyvalueLang',
        "DKV_ID",
        [
            'alias' => 'Lang',
            'reusable' => true
        ]
    );

    }

}