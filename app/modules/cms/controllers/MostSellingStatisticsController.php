<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Models\Content;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderItems;
use Vokuro\Cart\Models\OrderStatuses;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Models\CompanyBranches;

class MostSellingStatisticsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$products_builder = $this->createProductsBuilder();
		$page = $this->request->get('page');
		$page = isset($page)?$page:1;

		$paginator = new PaginatorQueryBuilder([
			'builder' => $products_builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$this->view->page = $paginator->getPaginate();
		$this->view->manfcts = \DataCmsDeptsRel::find([
            'Core_Depts_ID = :core_dept:',
            'bind' => [
                'core_dept' => 5
            ]
            ]);
		$this->view->categories = \DataCmsDeptsRel::find([
			'Core_Depts_ID = :core_dept:',
			'bind' => [
				'core_dept' => 4
			]
		]);
		$this->view->branches = CompanyBranches::find();
	}

	public function filterAction()
	{
		$page = $this->request->getPost('page');
		$page = isset($page)?$page:1;

		$products_builder = $this->createProductsBuilder();

		$start_date  = $this->request->getPost('start_date');
		$end_date    = $this->request->getPost('end_date');
		$category_id = $this->request->getPost('category_id');
		$manfct_id   = $this->request->getPost('manfct_id');
		$branch_id   = $this->request->getPost('branch_id');

		$valid_start_date  = (isset($start_date) && strlen($start_date) > 0)?true:false;
		$valid_end_date    = (isset($end_date) && strlen($end_date) > 0)?true:false;
		$valid_category_id = (isset($category_id) && strlen($category_id) > 0)?true:false;
		$valid_manfct_id   = (isset($manfct_id) && strlen($manfct_id) > 0)?true:false;
		$valid_branch_id   = (isset($branch_id) && strlen($branch_id) > 0)?true:false;

		if($valid_start_date && $valid_end_date)
		{
			$start_date = date('Y-m-d', strtotime($start_date));
			$end_date   = date('Y-m-d', strtotime($end_date));

			$products_builder->betweenWhere("date(from_unixtime(p_order.updated_at))", $start_date, $end_date);
		}
		elseif($valid_start_date && !$valid_end_date)
		{
			$start_date = date('Y-m-d', strtotime($start_date));

			$products_builder->andWhere("date(from_unixtime(p_order.updated_at)) = :start_date:", [
				'start_date' => $start_date
			]);
		}
		elseif(!$valid_start_date && $valid_end_date)
		{
			$end_date = date('Y-m-d', strtotime($end_date));

			$products_builder->andWhere("date(from_unixtime(p_order.updated_at)) = :end_date:", [
				'end_date' => $end_date
			]);
		}

		if($valid_category_id)
		{
			$products_builder->leftJoin(\DataCmsDeptsRelItem::class, 'dept_rel_item.Item_ID = product.ID', 'dept_rel_item');
			$products_builder->andWhere('dept_rel_item.Depts_ID = :category_id:', [
				'category_id' => $category_id
			]);
		}

		if($valid_manfct_id)
		{
			$products_builder->leftJoin(\DataCmsDeptsRelItem::class, 'manfct_rel_item.Item_ID = product.ID', 'manfct_rel_item');
			$products_builder->andWhere('manfct_rel_item.Depts_ID = :manfct_id:', [
				'manfct_id' => $manfct_id
			]);
		}

		if($valid_branch_id)
		{
			$products_builder->andWhere('order_item.delivery_place = :branch_id:', [
				'branch_id' => $branch_id
			]);
		}

		$paginator = new PaginatorQueryBuilder([
			'builder' => $products_builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$products_html = $this->view->getRender('most_selling_statistics/partials', 'filteredProducts', ['page' => $paginator->getPaginate()]);

		return json_encode(['content'=>$products_html]);
	}

	private function createProductsBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(['product' => Content::class])
		->where('Module_ID = 8');

		$builder->leftJoin(OrderItems::class, 'order_item.item_id = product.ID' , 'order_item');
		$builder->leftJoin(Orders::class, 'p_order.id = order_item.order_id', 'p_order');

		$builder->andWhere('order_item.item_type_id = 1')
		->andWhere('p_order.status = ' . OrderStatuses::paymentConfirmed());

		$builder->columns(['sum(order_item.count) as total_count', 'order_item.item_id', 'product.*'])
		->groupBy('order_item.item_id')
		->orderBy('total_count desc');

		return $builder;
	}
}