<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 7/4/2018
 * Time: 2:29 PM
 */

namespace Vokuro\Cms\Controllers;
use Vokuro\Controllers\ControllerBase;

class TestingController extends ControllerBase
{
    public function test_sessionAction(){
        $this->view->disable();
        var_dump($_SESSION);
    }
}