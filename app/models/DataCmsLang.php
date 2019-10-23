<?php

class DataCmsLang extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $data_cms_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $lang_id;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=false)
     */
    public $title;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $des;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $content;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->belongsTo(
            "lang_id",
            '\Languages',
            "id",
            [
                'alias' => 'LangDetails',
                'reusable' => true
            ]
        );
		$this->belongsTo(
            "data_cms_id",
            'Models\Content',
            "ID",
            [
                'alias' => 'Content',
                'reusable' => true
            ]
        );

        $this->allowEmptyStringValues(
            array(
                "title",
                "des",
                "content",
            )
        );
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'data_cms_lang';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsLang[]|DataCmsLang
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsLang
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
