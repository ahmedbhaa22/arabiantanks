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


class DataCmsMediaThumb extends Model{
    public $id;
    public $media_id;
    public $thumb_name;
    
    public function getSource()
    {
        return 'data_cms_media_thumb';
    }


    public function initialize()
    {
        // $this->belongsTo(
            // "media_id",
            // '\DataCmsMedia',
            // "ID",
            // [
                // 'alias' => 'Media',
                // 'reusable' => true
            // ]
        // );
    }

   



}