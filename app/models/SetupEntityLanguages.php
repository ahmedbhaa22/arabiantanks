<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/29/2017
 * Time: 4:33 PM
 */

namespace Vokuro\Models;


use Phalcon\Mvc\Model;

class SetupEntityLanguages extends Model
{

    public function getSource()
    {
        return 'setup_entity_languages';
    }
}