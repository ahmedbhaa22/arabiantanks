<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Models\Content;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderItems;
use Vokuro\Cart\Models\OrderStatuses;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Models\ProductExtraFields;

class NotSoldStatisticsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$page = $this->request->get('page');
		$page = isset($page)?$page:1;

		$products_builder = $this->createProductsBuilder();
		
		$paginator = new PaginatorQueryBuilder([
			'builder' => $products_builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$export_builder = $this->createProductsBuilder();

		$ids = [];
		$all_products = $export_builder->getQuery()->execute();

		foreach($all_products as $product)
		{
			$product = $product->{'product'};
			$ids[] = $product->ID;
		}

		$manufacturers = \DataCmsDeptsRel::find([
            'Core_Depts_ID = :core_dept:',
            'bind' => [
                'core_dept' => 5
            ]
            ]);

        $root_categories = \DataCmsDeptsRel::find([
            'Core_Depts_ID = :core_dept: and Parent_Depts_ID = 0',
            'bind' => [
                'core_dept' => 4
            ]
            ]);

        $build_tree = new \Vokuro\Pentavalue\BuildDeptsTree($root_categories);

        $categories_tree_partial = $this->view->getRender('partials', 'catsTree', [
            'tree' => $build_tree->tree]);


		$this->view->page = $paginator->getPaginate();
		$this->view->export_ids = json_encode($ids);
		$this->view->manfcts = $manufacturers;
		$this->view->cats_tree = $categories_tree_partial;
	}

	private function createProductsBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(['product' => Content::class])
		->where('product.Module_ID = 8');

		$builder->leftJoin(OrderItems::class, 'order_item.item_id = product.ID and order_item.item_type_id = 1' , 'order_item');

		$builder->andWhere('order_item.item_id is null');

		$builder->columns(['product.*', 'order_item.id as order_item_id']);

		return $builder;
	}

	public function filterProductsAction()
	{
		$page = $this->request->getPost('page');
		$page = isset($page)?$page:1;

		$builder = $this->createProductsBuilder();

		$product_name = $this->request->getPost('product_name');
		$manfct_id    = $this->request->getPost('manfct_id');
		$price_from   = $this->request->getPost('price_from');
		$price_to     = $this->request->getPost('price_to');
		$depts_ids    = $this->request->getPost('depts_ids');

		$valid_product_name = (isset($product_name) && strlen($product_name) > 0)?true:false;
		$valid_manfct_id    = (isset($manfct_id) && strlen($manfct_id) > 0)?true:false;
		$valid_price_from   = (isset($price_from) && strlen($price_from) > 0)?true:false;
		$valid_price_to     = (isset($price_to) && strlen($price_to) > 0)?true:false;
		$valid_depts_ids    = (isset($depts_ids) && count($depts_ids) > 0)?true:false;

		if($valid_product_name)
		{
			$builder->andWhere('product.Title like :name:', ['name' => '%'.$product_name.'%']);
		}

		if($valid_manfct_id)
		{
			$builder->leftJoin(\DataCmsDeptsRelItem::class, 'manfct_rel_item.Item_ID = product.ID', 'manfct_rel_item');

			$builder->andWhere('manfct_rel_item.Depts_ID = :manfct_id:', ['manfct_id' => $manfct_id]);
		}

		if($valid_depts_ids)
		{
			$builder->leftJoin(\DataCmsDeptsRelItem::class, 'cat_rel_item.Item_ID = product.ID', 'cat_rel_item');

			$builder->inWhere('cat_rel_item.Depts_ID', $depts_ids);
		}

		if($valid_price_from && $valid_price_to)
		{
			$builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

			$builder->betweenWhere('p_extra.price', $price_from, $price_to);
		}
		elseif($valid_price_from && !$valid_price_to)
		{
			$builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

			$builder->andWhere('p_extra.price = :price_from:', ['price_from' => $price_from]);
		}
		elseif(!$valid_price_from && $valid_price_to)
		{
			$builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

			$builder->andWhere('p_extra.price = :price_to:', ['price_to' => $price_to]);
		}

		$paginator = new PaginatorQueryBuilder([
			'builder' => $builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$filtered_products = $this->view->getRender('not_sold_statistics/partials', 'filteredProducts',[
			'page' => $paginator->getPaginate()
		]);

		return json_encode(['content' => $filtered_products]);
	}
}