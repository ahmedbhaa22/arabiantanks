<?php
namespace Vokuro\Models;


use Phalcon\Mvc\Model;

class DataKeyvalueEntity extends Model
{
    public function getSource()
    {
        return 'data_keyvalue_entity';
    }

    public function initialize()
    {
        // define relations
        $this->belongsTo(
            "entity_id",
            'Vokuro\Models\SetupEntities',
            "id",
            [
                'alias' => 'SetupEntities',
                'reusable' => true
            ]
        );
    }
}