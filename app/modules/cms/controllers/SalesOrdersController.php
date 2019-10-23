<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderItems;
use Vokuro\Cart\Models\OrderStatuses;
use Models\Content;
use Models\UsersMobile;
use Vokuro\Models\Tags;
use Models\EntityTags;
use Vokuro\Models\CompanyBranches;

class SalesOrdersController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{	
		$purchase_page = $this->request->get('purchase_page');
		$purchase_page = isset($purchase_page)?$purchase_page:1;

		// $returned_page = $this->request->get('returned_page');
		// $returned_page = isset($returned_page)?$returned_page:1;

		$purchase_builder = $this->createPurchaseBuilder();
		// $returned_builder = $this->createReturnedBuilder();

		$purchase_paginator = new PaginatorQueryBuilder([
			'builder' => $purchase_builder,
			'limit'   => 5,
			'page'    => $purchase_page
		]);

		// $returned_paginator = new PaginatorQueryBuilder([
		// 	'builder' => $returned_builder,
		// 	'limit'   => 5,
		// 	'page'    => $returned_page
		// ]);

		$purchase_temp_builder = $this->createPurchaseBuilder();
		// $returned_temp_builder = $this->createReturnedBuilder();

		$purchase_ids = [];
		$returned_ids = [];

		$all_purchase_ids = $purchase_temp_builder->columns('id')->getQuery()->execute();
		// $all_returned_ids = $returned_temp_builder->columns('id')->getQuery()->execute();

		foreach($all_purchase_ids as $p_id)
		{
			$purchase_ids[] = current($p_id);
		}

		// foreach($all_returned_ids as $r_id)
		// {
		// 	$returned_ids[] = current($r_id);
		// }

		$this->view->purchase_page = $purchase_paginator->getPaginate();
		// $this->view->returned_page = $returned_paginator->getPaginate();
		$this->view->purchase_ids  = json_encode($purchase_ids);
		// $this->view->returned_ids  = json_encode($all_returned_ids);
		$this->view->purchase_order_statuses = OrderStatuses::purchaseOrderStatusObjects();
		$this->view->delivery_places         = CompanyBranches::find();
	}

	// public function filterPurchaseOrders()
	// {
	// 	$builder = $this->createPurchaseBuilder();

	// 	$page = $this->request->getPost('page');
	// 	$page = isset($page)?$page:1;

	// 	$purchase_order_statuses = OrderStatuses::purchaseOrderStatuses();

	// 	$date_from      = $this->request->getPost('date_from');
	// 	$date_to        = $this->request->getPost('date_to');
	// 	$order_status   = $this->request->getPost('order_status');
	// 	$delivery_place = $this->request->getPost('delivery_place');
	// 	$product_name   = $this->request->getPost('product_name');
	// 	$order_number   = $this->request->getPost('order_number');
	// 	$user_email     = $this->request->getPost('user_email');
	// 	$tags           = $this->request->getPost('tags');

	// 	$valid_date_from      = (isset($date_from) && strlen($date_from) > 0)?true:false;
	// 	$valid_date_to        = (isset($date_to) && strlen($date_to) > 0)?true:false;
	// 	$valid_order_status   = (isset($order_status) && strlen($order_status) > 0)?true:false;
	// 	$valid_delivery_place = (isset($delivery_place) && strlen($delivery_place) > 0)?true:false;
	// 	$valid_product_name   = (isset($product_name) && strlen($product_name) > 0)?true:false;
	// 	$valid_order_number   = (isset($order_number) && strlen($order_number) > 0)?true:false;
	// 	$valid_user_email     = (isset($user_email) && strlen($user_email) > 0)?true:false;
	// 	$valid_tags           = (isset($tags) && strlen($tags) > 0)?true:false;

	// 	// handle dates filters
	// 	if($valid_date_from && $valid_date_to)
	// 	{
	// 		$date_from = date('Y-m-d', strtotime($date_from));
	// 		$date_to   = date('Y-m-d', strtotime($date_to));

	// 		$builder->betweenWhere("date(from_unixtime(updated_at))", 
	// 			$date_from, $date_to);
	// 	}
	// 	elseif($valid_date_from && !$valid_date_to)
	// 	{
	// 		$date_from = date('Y-m-d', strtotime($date_from));

	// 		$builder->andWhere("date(from_unixtime(updated_at)) = :date_from:", 
	// 			['date_from' => $date_from]);
	// 	}
	// 	elseif(!$valid_date_from && $valid_date_to)
	// 	{
	// 		$date_to = date('Y-m-d', strtotime($date_to));

	// 		$builder->andWhere("date(from_unixtime(updated_at)) = :date_to:", 
	// 			['date_to' => $date_to]);
	// 	}
	// }

	private function createPurchaseBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(Orders::class);

		$purchase_order_statuses = OrderStatuses::purchaseOrderStatuses();

		if($this->request->getPost())
		{
			$date_from      = $this->request->getPost('date_from');
			$date_to        = $this->request->getPost('date_to');
			$order_status   = $this->request->getPost('order_status');
			$delivery_place = $this->request->getPost('delivery_place');
			$product_name   = $this->request->getPost('product_name');
			$order_number   = $this->request->getPost('order_number');
			$user_email     = $this->request->getPost('user_email');
			$tags           = $this->request->getPost('tags');

			$valid_date_from      = (isset($date_from) && strlen($date_from) > 0)?true:false;
			$valid_date_to        = (isset($date_to) && strlen($date_to) > 0)?true:false;
			$valid_order_status   = (isset($order_status) && strlen($order_status) > 0)?true:false;
			$valid_delivery_place = (isset($delivery_place) && strlen($delivery_place) > 0)?true:false;
			$valid_product_name   = (isset($product_name) && strlen($product_name) > 0)?true:false;
			$valid_order_number   = (isset($order_number) && strlen($order_number) > 0)?true:false;
			$valid_user_email     = (isset($user_email) && strlen($user_email) > 0)?true:false;
			$valid_tags           = (isset($tags) && strlen($tags) > 0)?true:false;

			$filter_orders_ids = [];

			// handle dates filters
			if($valid_date_from && $valid_date_to)
			{
				$date_from = date('d/m/Y', strtotime($date_from));
				$date_to   = date('d/m/Y', strtotime($date_to));

				$builder->betweenWhere("date_format(from_unixtime(updated_at), '%d/%m/%Y')", 
					$date_from, $date_to);
			}
			elseif($valid_date_from && !$valid_date_to)
			{
				$date_from = date('d/m/Y', strtotime($date_from));

				$builder->andWhere("date_format(from_unixtime(updated_at), '%d/%m/%Y') = :date_from:", 
					['date_from' => $date_from]);
			}
			elseif(!$valid_date_from && $valid_date_to)
			{
				$date_to = date('d/m/Y', strtotime($date_to));

				$builder->andWhere("date_format(from_unixtime(updated_at), '%d/%m/%Y') = :date_to:", 
					['date_to' => $date_to]);
			}

			// handle order status filter
			if($valid_order_status)
			{
				if($order_status == 'all')
				{
					$builder->inWhere('status', $purchase_order_statuses);
				}
				else
				{
					$builder->inWhere('status', [$order_status]);
				}
			}
			else
			{
				$builder->inWhere('status', $purchase_order_statuses);
			}

			// handle delivery place filter
			if($valid_delivery_place)
			{
				$order_items_builder = $this->modelsManager->createBuilder()->from(OrderItems::class)
			        ->columns('order_id');

				$order_items = $order_items_builder->where('delivery_place = :delivery_place:', [
					'delivery_place' => $delivery_place
				])->getQuery()->execute()->toArray();

				foreach($order_items as $item)
				{
					if(!in_array(current($item), $filter_orders_ids))
					{
						$filter_orders_ids[] = current($item);
					}
				}
			}

			// handle product name filter
			if($valid_product_name)
			{
				$products_builder = $this->modelsManager->createBuilder()->from(Content::class)
					->columns('ID');

				$products = $products_builder->where('Title like :product_name:', [
					'product_name' => $product_name
				])->getQuery()->execute()->toArray();

				$products_ids = [];

				foreach($products as $product)
				{
					$products_ids[] = current($product);
				}

				$order_items_builder = $this->modelsManager->createBuilder()->from(OrderItems::class)
					->columns('order_id');

				$order_items = $order_items_builder->inWhere('item_id', $products_ids)
					->andWhere('item_type_id = :item_type:', ['item_type' => 1])
					->getQuery()->execute()->toArray();

				foreach($order_items as $item)
				{
					if(!in_array(current($item), $filter_orders_ids))
					{
						$filter_orders_ids[] = current($item);
					}
				}
			}

			// handle order number filter
			if($valid_order_number)
			{
				$builder->andWhere('id = :order_number:', ['order_number' => $order_number]);
			}

			// handle user email filter
			if($valid_user_email)
			{
				$users_builder = $this->modelsManager->createBuilder()->from(UsersMobile::class)
					->columns('ID');

				$user = $users_builder->where('Mail = :email:', ['email' => $user_email])
					->getQuery()->execute()->getFirst();

				if($user)
				{
					$builder->andWhere('user_id = :user_id:', ['user_id' => $user->ID]);
				}
			}

			// handle tags filter
			if($valid_tags)
			{
				$tags = explode(',', $tags);
				$tags_ids = [];

				foreach($tags as $tag)
				{
					$result = Tags::findFirst([
						'name = :tag:',
						'bind' => [
							'tag' => $tag
						]
					]);

					if($result)
					{
						$tags_ids[] = $result->id;
					}
				}

				$entity_tags_builder = $this->modelsManager->createBuilder()->from(EntityTags::class)
					->columns('item_id');

				$items = $entity_tags_builder->where('entity_id = 1')
					->inWhere('tag_id', $tags_ids);

				$items_ids = [];

				foreach($items as $item)
				{
					$items_ids[] = current($item);
				}

				$order_items_builder = $this->modelsManager->createBuilder()->from(OrderItems::class)
					->columns('order_id');

				$order_items = $order_items_builder->inWhere('item_id', $items_ids)->getQuery()->execute()->toArray();

				$orders_ids = [];

				foreach($order_items as $order_item)
				{
					if(!in_array(current($order_item), $filter_orders_ids))
					{
						$filter_orders_ids[] = current($order_item);
					}
				}
			}

			if(count($filter_orders_ids))
			{
				$builder->inWhere('id', $filter_orders_ids);
			}

		}
		else
		{
			$builder->inWhere('status', $purchase_order_statuses);
		}

		//Order DESC
        $builder->orderBy("Vokuro\Cart\Models\Orders.ID DESC");

		return $builder;
	}

	private function createReturnedBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(Orders::class);

		if($this->request->getPost())
		{
		 	// handle the filter ..	
		}
	}

	public function deletePurchaseItemAction($p_item_id)
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$purchase_item = Orders::findFirst($p_item_id);

		if(!$purchase_item)
		{
			$response['msg'] = 'الطلب غير موجود';
			return json_encode($response);
		}

		foreach($purchase_item->items as $item)
		{
			if (!$item->delete())
			{
				$response['msg'] = 'خطأ أثناء حذف الطلب، حاول مرة أخرى';
				return json_encode($response);
			}
		}

		if(!$purchase_item->delete())
		{
			$response['msg'] = 'خطأ أثناء حذف الطلب، حاول مرة أخرى';
			return json_encode($response);
		}

		$response['status'] = 1;
		$response['msg']    = 'تم حذف طلب الشراء بنجاح';

		return json_encode($response);
	}

	public function deleteSelectedPurchaseItemsAction()
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$ids = $this->request->getPost('ids');
		$orders = Orders::query()->inWhere('id', $ids)->execute();

		foreach($orders as $order)
		{
			foreach($order->items as $item)
			{
				if(!$item->delete())
				{
					$response['msg'] = 'خطأ أثناء حذف الطلب، حاول مرة أخرى';
					return json_encode($response);
				}
			}

			if(!$order->delete())
			{
				$response['msg'] = 'خطأ أثناء حذف الطلب، حاول مرة أخرى';
				return json_encode($response);
			}
		}

		$response['status'] = 1;
		$response['msg']    = 'تم حذف الطلبات بنجاح';

		return json_encode($response);
	}

	public function exportPurchaseOrdersAction()
	{
		$ids = $this->request->getPost('purchase_ids');

		if(count($ids) == 1)
		{
			return json_encode(['status' => 0, 'file_name' => '']);
		}

		$orders = Orders::query()->inWhere('id', $ids)->execute();

		$phpexcel = new \PHPExcel();

        $phpexcel->getProperties()->setCreator('Appox');
        $phpexcel->getProperties()->setTitle('Purchase Orders');
        $phpexcel->getProperties()->setSubject('Purchase Orders');
        $phpexcel->setActiveSheetIndex(0);
        $phpexcel->getActiveSheet()->setRightToLeft(true);

        $header_fields = ['رقم الطلب', 'أسم العميل', 'البريد الإلكتروني', 'حالة طلب الشراء', 
				'مكان التسليم', 'تاريخ النشر', 'إجمالي الطلبية'];

		$export_data = $this->prepareData($orders);
        $file_header = $this->createFileHeader();

        for($i=0; $i < count($header_fields); $i++)
        {
            $phpexcel->getActiveSheet()->setCellValue($file_header[$i], $header_fields[$i]);
            $phpexcel->getActiveSheet()->getStyle($file_header[$i])->applyFromArray([
                'fill' => [
                    'type' => \PHPExcel_Style_Fill::FILL_SOLID,
                    'color' => [
                        'rgb' => 'D3D3D3'
                    ]
                ]
            ]);

            $phpexcel->getActiveSheet()->getStyle($file_header[$i])->getFont()->setBold(true);
        }

        $sheet_row = 2;
        foreach($export_data as $row)
        {
            $col = 0;

            foreach($row as $data)
            {
                $phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $sheet_row, $data);
                $col++;
            }

            $sheet_row++;
        }

        $obj_writer = new \PHPExcel_Writer_Excel2007($phpexcel);
        $file_name = 'Purchase_Orders_Exported_' . date('Y-m-d H-i-s') . '.xlsx';

        if(!file_exists(BASE_PATH . '/public/products/'))
        {
            mkdir(BASE_PATH . '/public/products/');
        }

        $file_path = BASE_PATH . '/public/products/' . $file_name;
        ob_clean();
        $obj_writer->save($file_path);
        return json_encode(['status' => 1, 'file_name' => $file_name]);
	}

	private function prepareData($orders)
	{
		$prepared_data = [];

		foreach($orders as $order)
		{
			$prepared_data[$order->id]['number']         = $order->id;
			$prepared_data[$order->id]['client_name']    = $order->user->Title;
			$prepared_data[$order->id]['client_email']   = $order->user->Mail;
			$prepared_data[$order->id]['order_status']   = $order->statusDetails->display_name_ar;
			$prepared_data[$order->id]['delivery_place'] = '';
			$prepared_data[$order->id]['date']           = $order->formattedDate();
			$prepared_data[$order->id]['items_count']    = $order->itemsCount();
		}

		return $prepared_data;
	}

	private function createFileHeader($start_index = -1, $header = [])
    {
        $chars = range('A', 'Z');
        $header = $header;

        if ($start_index === -1) {
            foreach ($chars as $char) {
                $header[] = $char . '1';
            }

            $this->createFileHeader($start_index + 1, $header);
        } elseif ($start_index !== 26) {
            foreach ($chars as $char) {
                $header[] = $chars[$start_index] . $char . '1';
            }

            $this->createFileHeader($start_index + 1, $header);
        }

        return $header;
    }
	// public function redirectAction()
	// {
	// 	$tab = $this->request->get('tab');
	// 	$tab = isset($tab)?$tab:'sum';

	// 	return $this->response->redirect($this->url->get('sales_orders/index/#'.$tab));
	// }
}