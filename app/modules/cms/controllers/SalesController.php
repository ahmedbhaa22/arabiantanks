<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;

class SalesController extends ControllerBase
{
	private $application_id = 1;
	private $module_id      = 8;

	public function initialize()
	{
		parent::initialize();

		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$sections['Orders'] = [
			'img'  => 'images/products/order.png',
			'link' => 'sales_orders/index'
		];

		$sections['Shopping Cart'] = [
			'img'  => 'images/products/cart.png',
			'link' => 'sales_cart/index'
		];

//		$sections['Visits'] = [
//			'img'  => 'images/products/visit.png',
//			'link' => 'sales_visits/list_reps'
//		];

		$this->view->sections = $sections;
	}
}