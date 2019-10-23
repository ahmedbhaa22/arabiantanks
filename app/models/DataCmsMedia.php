<?php
use Vokuro\Models\Behaviors\Loggable;
class DataCmsMedia extends \Phalcon\Mvc\Model
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
     * @Column(type="string", length=255, nullable=false)
     */
    public $Link;

    /**
     *
     * @var integer
     * @Column(type="integer", length=10, nullable=false)
     */
    public $Item_ID;

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
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $Type;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */

    public $datetime;

    public $dept_id;

    public $img_title;

    public $img_alt;

    public function getSource()
    {
        return 'data_cms_media';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsMedia[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsMedia
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->addBehavior(new Loggable());
		$this->belongsTo(
            "ID",
            'Models\DataCmsMediaThumb',
            "media_id",
            [
                'alias' => 'Thumb',
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
            'link' => 'Link',
            'module_id' => 'Module_ID',
            'item_id' => 'Item_ID',
            'img' => 'Img',
            'type' => 'Type',
            'application_id' => 'Application_ID',
            'datetime' => 'datetime',
            'dept_id' => 'dept_id',
            'img_title' => 'img_title',
            'img_alt' => 'img_alt'
        );


    }
}
