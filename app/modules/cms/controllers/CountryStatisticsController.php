<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Models\Content;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderItems;
use Vokuro\Cart\Models\OrderStatuses;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Models\ProductExtraFields;
use Models\UsersMobile;
use Vokuro\UsersModule\Models\UserData;
use Vokuro\Geo\Models\GeoRegions;

class CountryStatisticsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$orders_builder = $this->createOrdersBuilder();
		// var_dump($orders_builder->getQuery()->execute()->toArray());die;
		$this->view->result  = $orders_builder->getQuery()->execute();
		$this->view->regions = GeoRegions::find();
	}

	private function createOrdersBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(['porder' => Orders::class]);

		$builder->leftJoin(OrderItems::class, 'order_item.order_id = porder.id', 'order_item');
		$builder->leftJoin(Content::class, 'product.ID = order_item.item_id', 'product');
		$builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

		$builder->inWhere('porder.status', [
			OrderStatuses::paymentConfirmed(),
			OrderStatuses::delivered()
		]);

		$builder->andWhere('order_item.item_type_id = 1');

		$builder->columns(['count(order_item.id) as total_order_items', 'sum(p_extra.price * order_item.count) as total_price', 'porder.*']);

		$builder->groupBy('porder.id')->orderBy('total_order_items desc');

		return $builder;
	}

	public function filterOrdersAction()
	{
		$builder = $this->createOrdersBuilder();

		$region_id = $this->request->getPost('region_id');
		$date_from = $this->request->getPost('date_from');
		$date_to   = $this->request->getPost('date_to');

		$valid_region_id = (isset($region_id) && strlen($region_id) > 0)?true:false;
		$valid_date_from = (isset($date_from) && strlen($date_from) > 0)?true:false;
		$valid_date_to   = (isset($date_to) && strlen($date_to) > 0)?true:false;

		if($valid_region_id)
		{
			$builder->leftJoin(UsersMobile::class, 'porder.user_id = user.ID', 'user');
			$builder->leftJoin(UserData::class, 'user.ID = user_data.user_id', 'user_data');

			$builder->andWhere('user_data.region_id = :region_id:', ['region_id' => $region_id]);
		}

		if($valid_date_from && $valid_date_to)
		{
			$date_from = date('Y-m-d', strtotime($date_from));
			$date_to   = date('Y-m-d', strtotime($date_to));

			$builder->betweenWhere("date(from_unixtime(porder.updated_at))", $date_from, $date_to);
		}
		elseif($valid_date_from && !$valid_date_to)
		{
			$date_from = date('Y-m-d', strtotime($date_from));

			$builder->andWhere("date(from_unixtime(porder.updated_at)) = :date_from:", [
				'date_from' => $date_from
			]);
		}
		elseif(!$valid_date_from && $valid_date_to)
		{
			$date_to   = date('Y-m-d', strtotime($date_to));

			$builder->andWhere("date(from_unixtime(porder.updated_at)) = :date_to:", [
				'date_to' => $date_to
			]);
		}

		$orders = $builder->getQuery()->execute();

		$filtered_orders = $this->view->getRender('country_statistics/partials', 'filteredOrders', [
			'orders' => $orders
		]);

		return json_encode(['content' => $filtered_orders]);
	}
}