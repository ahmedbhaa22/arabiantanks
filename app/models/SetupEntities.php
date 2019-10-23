<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/29/2017
 * Time: 4:33 PM
 */

namespace Vokuro\Models;


use Phalcon\Mvc\Model;

class SetupEntities extends Model
{
    public $id;
    public $name;
    public $table_name;
    public $model_name;
    public $displayField;
    public $load_as_keyvalue;

    public function getSource()
    {
        return 'setup_entities';
    }
}