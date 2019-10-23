<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 3/15/2017
 * Time: 2:37 PM
 */
namespace Models;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;


class DataCmsImgThumb extends Model{
    public $id;
    public $data_cms_id;
    public $thumb_name;
    
    public function getSource()
    {
        return 'data_cms_img_thumb';
    }


    public function initialize()
    {
        $this->belongsTo(
            "data_cms_id",
            'Models\Content',
            "ID",
            [
                'alias' => 'Content',
                'reusable' => true
            ]
        );
    }

   



}