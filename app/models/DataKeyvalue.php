<?php

class DataKeyvalue extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", length=244, nullable=false)
     */
    public $Paramter;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $Img;

    /**
     *
     * @var integer
     * @Column(type="integer", length=5, nullable=false)
     */
    public $CKV_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Depts_ID;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $Application_ID;

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
    public $Group_ID;
    public $Show;
    public $CKVT_ID;
    public $has_langs;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_keyvalue';
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
            "ID",
            '\DataKeyvalueLang',
            "DKV_ID",
            [
                'alias' => 'DataKeyvalueLang',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "CKV_ID",
            '\CoreKeyvalueType',
            "ID",
            [
                'alias' => 'CoreKeyvalueType',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "Group_ID",
            '\DataKeyvalueGroup',
            "ID",
            [
                'alias' => 'DataKeyvalueGroup',
                'reusable' => true
            ]
        );
		
		$this->belongsTo(
            "ID",
            '\DataKeyvalueValidationSettings',
            "dkv_id",
            [
                'alias' => 'Type',
                'reusable' => true
            ]
        );
        $this->belongsTo(
            "ID",
            '\DataKeyvalueDeptCms',
            "dkv_id",
            [
                'alias' => 'Dept',
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
            'paramter' =>'Paramter',
            'img' => 'Img',
            'application_id' => 'Application_ID',
            'depts_id' => 'Depts_ID',
            'module_id' => 'Module_ID',
            'group_id' => 'Group_ID',
            'show' => 'Show',
            'ckvt_id' => 'CKVT_ID',
            'ckv_id' => 'CKV_ID',
            'show_kv' => 'Show_Kv',
            'has_langs' => 'has_langs'
        );


    }

    public function getTitle($lang_id)
    {
        $title = $this->Paramter;
        $lang_record = \DataKeyvalueLang::findFirst([
            'DKV_ID = :id: and Lang_ID = :lang_id:',
            'bind' => [
                'id'      => $this->ID,
                'lang_id' => $lang_id
            ]
        ]);

        if($lang_record)
        {
            $title = $lang_record->Title;
        }

        return $title;
    }
}
