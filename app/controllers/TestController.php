<?php
namespace Vokuro\Controllers;

use Phalcon\Mvc\Model\Query\Builder;
/**
 * Display the "Home" page.
 */
class TestController extends ControllerBase
{
    public $builder;
    public function initialize() {

        parent::initialize();

    }

    /**
     * Default action. Set the public layout (layouts/public.volt)
     */
    public function indexAction()
    {

    }

}
