<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderItems;
use Vokuro\Cart\Models\OrderStatuses;
use Models\UsersMobile;

class SalesCartController extends ControllerBase
{
	public  function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$carts_page = $this->request->get('carts_page');
		$carts_page = isset($carts_page)?$carts_page:1;

		$wishlist_page = $this->request->get('wishlist_page');
		$wishlist_page = isset($wishlist_page)?$wishlist_page:1;

		$tab = $this->request->get('tab');
		$tab = isset($tab)?$tab:'sum';

		$carts_builder     = $this->createCartsBuilder();
		$wishlist_builder = $this->createWishlistBuilder();

		$carts_paginator = new PaginatorQueryBuilder([
			'builder' => $carts_builder,
			'limit'   => 5,
			'page'    => $carts_page
		]);

		$wishlist_paginator = new PaginatorQueryBuilder([
			'builder' => $wishlist_builder,
			'limit'   => 5,
			'page'    => $wishlist_page
		]);

		$this->view->carts_page    = $carts_paginator->getPaginate();
		$this->view->wishlist_page = $wishlist_paginator->getPaginate();
		$this->view->tab           = $tab;
	}

	private function createCartsBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(Orders::class)
		->where('status = :status:', ['status' => OrderStatuses::cart()]);

		if($this->request->getPost())
		{
			$client_name = $this->request->getPost('cart_client_name');
			$items_count = $this->request->getPost('cart_items_count');

			$valid_client_name = (isset($client_name) && strlen($client_name) > 0)?true:false;
			$valid_items_count = (isset($items_count) && strlen($items_count) > 0)?true:false;

			// handle client name filter
			if($valid_client_name)
			{
				$clients = UsersMobile::query()->columns('ID')->where('Title like :name:', [
					'name' => '%'.$client_name.'%'
				])->execute();

				$clients_ids = [];

				foreach($clients as $client)
				{
					$clients_ids[] = current($client);
				}

				$builder->inWhere('user_id', $clients_ids);
			}

			// handle items count filter
			if($valid_items_count)
			{
				$orders_ids = [];

				$builder_result = $builder->getQuery()->execute();

				foreach($builder_result as $result)
				{
					if($result->itemsCount() == $items_count)
					{
						$orders_ids[] = $result->id;
					}
				}
				
				$builder->inWhere('id', $orders_ids);
				
			}
		}
		// order by id desc
        $builder->orderBy("Vokuro\Cart\Models\Orders.id DESC");

		return $builder;
	}

	private function createWishlistBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(Orders::class)
		->where('status = :status:', ['status' => OrderStatuses::wishlist()]);

		if($this->request->getPost())
		{
			$client_name = $this->request->getPost('wishlist_client_name');
			$items_count = $this->request->getPost('wishlist_items_number');

			$valid_client_name = (isset($client_name) && strlen($client_name) > 0)?true:false;
			$valid_items_count = (isset($items_count) && strlen($items_count) > 0)?true:false;

			// handle client name filter
			if($valid_client_name)
			{
				$clients = UsersMobile::query()->columns('ID')->where('Title like :name:', [
					'name' => '%'.$client_name.'%'
				])->execute();

				$clients_ids = [];

				foreach($clients as $client)
				{
					$clients_ids[] = current($client);
				}

				$builder->inWhere('user_id', $clients_ids);
			}

			// handle items count filter
			if($valid_items_count)
			{
				$orders_ids = [];

				$builder_result = $builder->getQuery()->execute();

				foreach($builder_result as $result)
				{
					if($result->itemsCount() == $items_count)
					{
						$orders_ids[] = $result->id;
					}
				}

				$builder->inWhere('id', $orders_ids);
			}
		}

        // order by id desc
        $builder->orderBy("Vokuro\Cart\Models\Orders.id DESC");

		return $builder;
	}
}