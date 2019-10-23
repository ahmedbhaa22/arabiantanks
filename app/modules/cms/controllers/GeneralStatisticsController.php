<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Carbon\Carbon;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderItems;
use Vokuro\Cart\Models\OrderStatuses;
use Vokuro\Pentavalue\Helpers;
use Models\UsersMobile;
use Vokuro\Models\SavedSearchKeywords;

class GeneralStatisticsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$unfinished_orders = $this->getUnfinishedOrders();
		$unfinished_arr['new_order'] = null;
		$unfinished_arr['pending']   = null;

		foreach($unfinished_orders as $unfinished)
		{
			if($unfinished->status_id == OrderStatuses::newOrder())
			{
				$unfinished_arr['new_order'] = $unfinished;
			}
			elseif($unfinished->status_id == OrderStatuses::pending())
			{
				$unfinished_arr['pending'] = $unfinished;
			}
		}

		$searched_keywords = SavedSearchKeywords::find();

		$this->view->unfinished_orders    = $unfinished_arr;
		$this->view->all_orders_count     = Orders::query()->execute()->count();
		$this->view->helpers              = new Helpers;
		$this->view->seven_days_clients   = $this->getLastSevenDaysClients();
		$this->view->forteen_days_clients = $this->getLastForteenDaysClients();
		$this->view->month_clients        = $this->getLastMonthClients();
		$this->view->searched_keywords    = $searched_keywords;
	}

	private function getLastSevenDaysClients()
	{
		$builder = $this->modelsManager->createBuilder()->from(UsersMobile::class)
		->where('category_id is not null');

		$carbon = Carbon::now('Asia/Riyadh');
		
		$date_minus_seven = $carbon->subDays(7)->toDateTimeString();
		$date_minus_seven = date('Y-m-d', strtotime($day_minus_seven));
		$today            = date('Y-m-d', time());

		$builder->betweenWhere("date(from_unixtime(Join_Date))", $day_minus_seven, $today);

		return $builder->columns('count(ID) as clients_count')->getQuery()->execute();
	}

	private function getLastForteenDaysClients()
	{
		$builder = $this->modelsManager->createBuilder()->from(UsersMobile::class)
		->where('category_id is not null');

		$carbon = Carbon::now('Asia/Riyadh');

		$date_minus_forteen = $carbon->subDays(14)->toDateTimeString();
		$date_minus_forteen = date('Y-m-d', strtotime($date_minus_forteen));
		$today              = date('Y-m-d', time());

		$builder->betweenWhere("date(from_unixtime(Join_Date))", $date_minus_forteen, $today);

		return $builder->columns('count(ID) as clients_count')->getQuery()->execute();
	}

	private function getLastMonthClients()
	{
		$builder = $this->modelsManager->createBuilder()->from(UsersMobile::class)
		->where('category_id is not null');

		$carbon = Carbon::now('Asia/Riyadh');

		$date_minus_thirty = $carbon->subDays(30)->toDateTimeString();
		$date_minus_thirty = date('Y-m-d', strtotime($date_minus_thirty));
		$today             = date('Y-m-d', time());

		$builder->betweenWhere("date(from_unixtime(Join_Date))", $date_minus_thirty, $today);

		return $builder->columns('count(ID) as clients_count')->getQuery()->execute();
	}

	private function getUnfinishedOrders()
	{
		$builder = $this->modelsManager->createBuilder()->from(Orders::class);

		$builder->inWhere('status', OrderStatuses::statisticsUnfinishedOrdersStatuses());
		
		$builder->leftJoin(OrderStatuses::class, OrderStatuses::class . '.id = ' . Orders::class . '.status');

		$builder->columns([
			'count('.Orders::class.'.id) as orders_count',
			OrderStatuses::class . '.display_name_ar as display_name',
			OrderStatuses::class . '.status_name',
			Orders::class . '.status as status_id'
		]);
		
		$builder->groupBy('status_id');

		return $builder->getQuery()->execute();
	}

	public function allOrdersAction()
	{
		$carbon  = Carbon::now('Asia/Riyadh');
		$filter  = $this->request->get('all_orders_filter');
		$builder = $this->modelsManager->createBuilder()->from(Orders::class)
		->inWhere('status', OrderStatuses::statisticsAllOrdersStatuses());

		switch($filter)
		{
			case 'today':
			$today = date('Y-m-d', time());
			$builder->andWhere("date(from_unixtime(date)) = :today:", 
				[
					'today' => $today
				]);

			break;
			case 'this_week':
			$builder->andWhere("WeekOfYear(date(from_unixtime(date))) = :this_week:", 
				[
					'this_week' => $carbon->weekOfYear
				]);
			break;
			case 'this_month':
			$builder->andWhere("month(date(from_unixtime(date))) = :this_month:", 
				[
					'this_month' => $carbon->month
				]);
			break;
			case 'this_year':
			$builder->andWhere("year(date(from_unixtime(date))) = :this_year:", 
				[
					'this_year' => $carbon->year
				]);
			break;
		}

		$orders = $builder
		->columns(
			[
			'count('.Orders::class.'.id) as orders_count',
			 OrderStatuses::class.'.display_name_ar as display_name',
			 Orders::class . '.status as status_id'
			])
		->leftJoin(OrderStatuses::class, OrderStatuses::class . '.id = ' . Orders::class . '.status')
		->groupBy('status_id')
		->getQuery()->execute();

		$all_orders['new_order'] = null;
		$all_orders['pending']   = null;
		$all_orders['shipping']  = null;
		$all_orders['cancel']    = null;

		foreach($orders as $order)
		{
			if($order->status_id == OrderStatuses::newOrder())
			{
				$all_orders['new_order'] = $order;
			}
			elseif($order->status_id == OrderStatuses::pending())
			{
				$all_orders['pending'] = $order;
			}
			elseif($order->status_id == OrderStatuses::shipping())
			{
				$all_order['shipping'] = $order;
			}
			elseif($order->status_id == OrderStatuses::cancel())
			{
				$all_order['cancel'] = $order;
			}
		}
		
		return json_encode(['all_orders' => $all_orders]);
	}
}