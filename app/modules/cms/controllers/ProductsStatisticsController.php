<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;

class ProductsStatisticsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$sections['General Statistics'] = [
			'img' => 'images/products/edit.png',
			'url' => 'general_statistics/index'
		];

		$sections['Most Selling'] = [
			'img' => 'images/products/sales-stat.png',
			'url' => 'most_selling_statistics/index'
		];

		$sections['Not Sold'] = [
			'img' => 'images/products/products.png',
			'url' => 'not_sold_statistics/index'
		];

		$sections['Country Statistics'] = [
			'img' => 'images/products/locateor.png',
			'url' => 'country_statistics/index'
		];

		$this->view->sections = $sections;
	}
}