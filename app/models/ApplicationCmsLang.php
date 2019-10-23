<?php

class ApplicationCmsLang extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $application_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $lang_id;

    /**
     * Initialize method for model.
     */

    public $is_default;
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
            "lang_id",
            '\CpModulesTranslation',
            "lang_id",
            [
                'alias' => 'Strings',
                'reusable' => true
            ]
        );
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'application_cms_lang';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return AppllicationCmsLang[]|AppllicationCmsLang
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return AppllicationCmsLang
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }


}
