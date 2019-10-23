<?php
namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Models\Behaviors\Loggable;

class EntityTags extends Model{

    public function getSource()
    {
        return 'entity_tags';
    }
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    public function initialize()
    {
        $this->belongsTo(
            "tag_id",
            'Vokuro\Models\Tags',
            "id",
            [
                'alias' => 'Tag',
                'reusable' => true
            ]
        );
    }

}