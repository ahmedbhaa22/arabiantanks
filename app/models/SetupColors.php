<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/29/2017
 * Time: 1:39 PM
 */

namespace Vokuro\Models;


use Phalcon\Mvc\Model;

class SetupColors extends Model
{
    public $id;
    public $name;
    public $rgb_decimal_code; // sample : rgb(0,0,0)
    public $hex_code; // sample : #000000

    public function getSource()
    {
        return 'setup_colors';
    }

    public function initialize()
    {
        // define relations
    }
}