<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/28/2017
 * Time: 4:13 PM
 */

namespace Vokuro\Models;


use Phalcon\Mvc\Model;

class ContactTypes extends Model
{
    public $id;
    public $name;

    public function getSource()
    {
        return 'contact_types';
    }

    public function initialize()
    {
        // define relations
    }
}