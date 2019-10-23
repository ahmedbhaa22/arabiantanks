<?php

namespace Vokuro\Cms\Controllers; use Vokuro\Controllers\ControllerBase;

use Models\Content;
use Models\DataCmsOrderStatus;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Mvc\Url;
use \DataCmsOrders;
use Models\GeneralNotifications;
use Vokuro\Cart\Models\Orders;
use Phalcon\Mvc\View;
use Mpdf\Mpdf;
use Vokuro\Cart\Models\OrderStatuses;

class OrdersController extends ControllerBase
{
    public function indexAction($Module_ID){
        //get keyvalue price field
        $module_settings = \CpModulesSettings::findFirst(["Module_ID={$Module_ID}"]);
        $price_kv_id= $module_settings->kv_price_param;
        if($price_kv_id==0){
            die("This Module Does Not Have Orders");
        }
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataCmsOrders', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }
        $parameters["order"] = "ID DESC";
        $content = DataCmsOrders::find(
            array(
                "Module_ID={$Module_ID}",
                "order" => "ID Desc"
            ));
        $paginator = new Paginator([
            'data' => $content,
            'limit' => 8,
            'page' => $numberPage
        ]);
        $statuses = DataCmsOrderStatus::find(["Module_ID={$Module_ID} OR Module_ID=0"]);
        $this->view->statuses = $statuses;
        $this->view->page = $paginator->getPaginate();
        $this->view->base_uri = $this->config->application->baseUri;
        $this->view->Module_ID = $Module_ID;
    }
    public function vieworderAction($Order_ID){
        $order_exists = DataCmsOrders::findFirst($Order_ID);

        if(!$order_exists)
        {
            $this->flashSession->error('Order deleted');
            return $this->redirectBack();
        }
        $purchase = \DataCmsOrdersPurchase::find(array(
            "Order_ID={$Order_ID}"
        ));

        if(count($purchase)==0){
            $order_check = DataCmsOrders::findFirst(["ID={$Order_ID}"]);
            $order_check->delete();
            return $this->response->redirect($_SERVER['HTTP_REFERER']);

        }
        $purchase_IDs= array();
        $Module_ID = $purchase[0]->Module_ID;
        foreach ($purchase as $purchase_item){
            $purchase_IDs[]=$purchase_item->ID;
        }
        //get keyvalue price field
        $module_settings = \CpModulesSettings::findFirst(["Module_ID={$Module_ID}"]);
        $price_kv_id= $module_settings->kv_price_param;
        if($price_kv_id==0){
//            die("This Module Does Not Have Orders");
            $this->flashSession->error('No orders');
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        $this->view->price_kv_id = $price_kv_id;
        ////
        $data_kv_purchase_data = array();
        foreach ($purchase_IDs as $purchase_ID){
            $data_kv_purchase = \DataCmsOrdersKeyvalue::find(array(
                "Purchase_ID={$purchase_ID}"
            ));
            $data_kv_purchase_data[]= $data_kv_purchase;
        }
        $this->view->purchase = $purchase;
        $this->view->data_kv_purchase_data = $data_kv_purchase_data;
        $order = DataCmsOrders::findFirst(["ID={$Order_ID}"]);
        $this->view->notifi_id=0;
        $this->view->order = $order;
        if(isset($_GET['notifi'])){
            $this->view->notifi_id=$_GET['notifi'];
        }

        $this->view->lang_id=$this->session->get('auth-identity')['Lang_ID'];

    }
    public function filterAction($Module_ID){
        if (!$this->request->isPost()){
            die("Get Out");
        };
        if (isset($_POST['status'])){
            $date_from="";
            $date_to="";
            if($this->request->getPost('date_from')!=""){
                $date_from= strtotime($this->request->getPost('date_from'));
            }
            if($this->request->getPost('date_to')!=""){
                $date_to= strtotime($this->request->getPost('date_to'));
            }
            $numberPage = $this->request->getQuery("page", "int");
            if($date_from =="" && $date_to==""){
                $content = DataCmsOrders::find(
                    ["Module_ID={$Module_ID} AND Status='{$_POST['status']}' ",
                        "order" => "ID Desc"
                    ]);
            }else{
                $content = DataCmsOrders::find(
                    array(
                        "Module_ID={$Module_ID} AND Status={$_POST['status']} AND Date Between '{$date_from}' AND '{$date_to}' ",
                        "order" => "ID Desc"
                    ));
            }

            $paginator = new Paginator([
                'data' => $content,
                'limit' => 8,
                'page' => $numberPage
            ]);
            $statuses = DataCmsOrderStatus::find();
            $this->view->statuses = $statuses;
            $this->view->items = $content;
            $this->view->base_uri = $this->config->application->baseUri;
            $this->view->Module_ID = $Module_ID;
        }


    }
    public function ordersuserAction($Module_ID){
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataCmsOrders', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }
        $parameters["order"] = "ID DESC";
        $user_ID=$this->request->getQuery("id");
        $content = DataCmsOrders::find(
            array(
                "Module_ID={$Module_ID} AND User_ID={$user_ID}",
                "order" => "ID Desc"
            ));
        $paginator = new Paginator([
            'data' => $content,
            'limit' => 8,
            'page' => $numberPage
        ]);
        $statuses = DataCmsOrderStatus::find();
        $this->view->statuses = $statuses;
        $this->view->page = $paginator->getPaginate();
        $this->view->base_uri = $this->config->application->baseUri;
        $this->view->Module_ID = $Module_ID;
        $this->view->User_ID = $user_ID;
    }

    public function editPurchaseAction($Purchase_ID){
        $purchase = \DataCmsOrdersPurchase::findFirst(array(
            "ID={$Purchase_ID}"
        ));
        $this->view->purchase = $purchase;
        $this->tag->setDefault("Cost", $purchase->Cost);
        $this->tag->setDefault("ID", $purchase->ID);
    }
    public function savePurchaseAction(){
        if(!$this->request->isPost()){
            return $this->response->redirect("users_application_module/index");
        }
        if(!$this->request->getPost("ID")){
            $this->flashSession->success($this->getTranslation()->_("Request was cancelled by user"));
            return $this->response->redirect("users_application_module/index");
        }
        $Purchase_ID = $this->request->getPost("ID");

        $purchase = \DataCmsOrdersPurchase::findFirst(array(
            "ID={$Purchase_ID}"
        ));
        if(!$purchase){
            $this->flashSession->success($this->getTranslation()->_("Request was cancelled by user"));
            return $this->response->redirect("users_application_module/index");
        }
        $purchase->Cost = $this->request->getPost("Cost");
        $purchase->save();
        $this->flashSession->success($this->getTranslation()->_("Edited With Success"));

        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }
    public function updatePurchaseAjaxAction($not_id){
        $this->view->disable();
        foreach ($_POST['purchase'] as $key=>$value){
            if($value==0 || $value=""){
                return "0";
            }

        }

        foreach ($_POST['purchase'] as $key=>$value){
            $purchase = \DataCmsOrdersPurchase::findFirst(array(
                "ID={$key}"
            ));
            $purchase->Cost = $value;
            $purchase->save();
            $order_id= $purchase->Orders_ID;
            $module_id= $purchase->Module_ID;
            $user_id=$purchase->Order->User_ID;
        }
        $order = DataCmsOrders::findFirst(["ID=$order_id"]);
        $order->Status = 9 ;
        $order->save();
        //make the request notification read
        $req_not = GeneralNotifications::findFirst(["id={$not_id}"]);
        if($req_not){
            $req_not->is_read= 1;
            $req_not->save();
        }
        $notification = new GeneralNotifications();
        $notification->content = "Price List";
        $notification->application_id = $this->session->get('auth-identity')['Application_ID'];
        $notification->module_id = $module_id;
        $notification->type_id = 1;
        $notification->user_id = $user_id;
        $notification->time = time();  //date('Y-m-d G:i:s')
        $notification->external_type_id = 2;
        $notification->show_type_id = 1;
        $notification->is_read = 0;
        $notification->url = "shoppingcart/items?cart_id=".$order_id."&cart_status=3";
        $notification->order_id = $order_id;
        if(!$notification->save()){
            print_r($notification->getMessages());die;
        }

        return "1";

    }

    public function confirmAction($order_id){
        $not_id = $this->request->getQuery("not_id");
        $order = DataCmsOrders::findFirst(["ID=$order_id"]);
        $order->Status = 11 ;
        $order->save();
        //make the request notification read
        $req_not = GeneralNotifications::findFirst(["id={$not_id}"]);
        if($req_not){
            $req_not->is_read= 1;
            $req_not->save();
        }
        $module_id = $order->Module_ID;
        $user_id= $order->User_ID;
        $notification = new GeneralNotifications();
        $notification->content = "Purchase Received";
        $notification->application_id = $this->session->get('auth-identity')['Application_ID'];
        $notification->module_id = $module_id;
        $notification->type_id = 1;
        $notification->user_id = $user_id;
        $notification->time = time();  //date('Y-m-d G:i:s')
        $notification->external_type_id = 5;
        $notification->show_type_id = 1;
        $notification->is_read = 0;
        $notification->url = "shoppingcart/items?cart_id={$order->ID}&cart_status=5";
        $notification->order_id = $order_id;
        if(!$notification->save()){
            print_r($notification->getMessages());die;
        }
        $this->flashSession->success('Order Updated');
        return $this->redirectBack();
    }

    public function viewClientOrderAction($order_id)
    {
        $items_total_price  = 0;
        $offers_total_price = 0;
        $total_shipping_fee = 0;
        $total_items_cost   = 0;

        $order = Orders::findFirst($order_id);
        $order_items = $order->items;

        foreach($order_items as $item)
        {
            switch($item->item_type_id)
            {
                case 1:
                $items_total_price  += $item->count * $item->cmsDetails->extraFields->price;
                $total_items_cost   += $item->count * $item->cmsDetails->extraFields->cost;
                $total_shipping_fee += $item->cmsDetails->extraFields->shipping_fee;
                break;
                case 2:
                $offers_total_price += $item->count * $item->offerDetails->price;
                break;
            }
        }

        $this->view->order = $order;
        $this->view->total_price = $items_total_price + $offers_total_price;
        $this->view->total_cost  = $total_items_cost;
        $this->view->total_shipping_fee = $total_shipping_fee;
        $this->view->purchase_order_statuses = OrderStatuses::purchaseOrderStatusObjects();
        //Update
        $order_data = $this->ApiFactory->getOrderData($order->user_id,$order->status,$order->id);
        $this->view->order_total_data = $order_data;

    }

    public function billAction($order_id)
    {
        $items_total_price  = 0;
        $offers_total_price = 0;
        $total_shipping_fee = 0;
        $total_items_cost   = 0;
        $total_tax_cost = 0 ;

        $order = Orders::findFirst($order_id);
        $order_items = $order->items;

        foreach($order_items as $item)
        {
            switch($item->item_type_id)
            {
                case 1:
                    $items_total_price  += $item->count * $item->cmsDetails->extraFields->price;
                    $total_items_cost   += $item->count * $item->cmsDetails->extraFields->cost;
                    $total_shipping_fee += $item->cmsDetails->extraFields->shipping_fee;
                    $total_tax_cost += $this->ApiFactory->getItemTaxAmount($item->cmsDetails->ID);
                    break;
                case 2:
                    $offers_total_price += $item->count * $item->offerDetails->price;
                    break;
            }
        }

        $this->view->order = $order;
        $this->view->total_price = $items_total_price + $offers_total_price;
        $this->view->total_cost  = $total_items_cost;
        $this->view->total_shipping_fee = $total_shipping_fee;
        $this->view->purchase_order_statuses = OrderStatuses::purchaseOrderStatusObjects();
        //Update
        $order_data = $this->ApiFactory->getOrderData($order->user_id,$order->status,$order->id);
        $this->view->order_total_data = $order_data;
        $this->view->total_tax_cost =$total_tax_cost;
    }

    public function deleteOrderAction($order_id)
    {
        $response['status'] = 0;
        $response['msg']    = '';

        $order = Orders::findFirst($order_id);

        if(!$order)
        {
            $response['msg'] = 'Invalid order';
        }

        foreach($order->items as $item)
        {
            $item->delete();
        }

        if(!$order->delete())
        {
            $response['msg'] = 'Error deleting order, please try again';
        }

        $response['status'] = 1;
        $response['msg']    = 'Order deleted successfully';

        return json_encode($response);
    }

    public function exportBillAction($order_id)
    {
        $items_total_price  = 0;
        $offers_total_price = 0;
        $total_shipping_fee = 0;
        $total_items_cost   = 0;

        $order = Orders::findFirst($order_id);
        $order_items = $order->items;

        foreach($order_items as $item)
        {
            switch($item->item_type_id)
            {
                case 1:
                $items_total_price  += $item->count * $item->cmsDetails->extraFields->price;
                $total_items_cost   += $item->count * $item->cmsDetails->extraFields->cost;
                $total_shipping_fee += $item->cmsDetails->extraFields->shipping_fee;
                break;
                case 2:
                $offers_total_price += $item->count * $item->offerDetails->price;
                break;
            }
        }

        //Update
        $order_data = $this->ApiFactory->getOrderData($order->user_id,$order->status,$order->id);
        //$this->view->order_total_data = $order_data;
        
        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $bill_view_string = $this->view->getRender('partials','bill', [
            'order'              => $order,
            'total_price'        => $items_total_price + $offers_total_price,
            'total_cost'         => $total_items_cost,
            'total_shipping_fee' => $total_shipping_fee,
            'order_total_data' => $order_data
            ]);

        $pdf = new Mpdf([
            'mode' => 'utf-8',
            'format' => [190,236],
            'orientation' => 'L'
            ]);

        //$pdf->SetDirectionality('rtl');
        $pdf->autoScriptToLang = true;
        $pdf->autoLangToFont = true;
        $stylesheet = file_get_contents(BASE_PATH."/public/css/tanks_sales_pdf.css");

        $pdf->WriteHTML($stylesheet,1);
        $pdf->WriteHTML($bill_view_string,2);
        return $pdf->output();
    }

    //Tanks
    public function change_order_statusAction(){
        $order_id= $this->request->getPost("order_id");
        $status = $this->request->getPost("changed_status_id");
        $order = Orders::findFirst($order_id);
        $order->status=$status;
        if($order->save()){
           $this->flashSession->success("تم تغيير الحالة");
           $order_email= $order->user->Mail;
           $this->sendChangeStatusMail($order_email,$order->id,$order->statusDetails->display_name);
           //Send Notification For User
            $this->sendNotificationForClient($order->user_id,2,"Order {$order->id} Status Changed to {$order->statusDetails->display_name}",$order->id);

        }else{
            $this->flashSession->error("حدث خطأ");
        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }

    public function bill_testAction(){

    }

    public function sendChangeStatusMail($mail,$order_id,$status)
    {
        try {
            $this->getDI()
                ->getMail()
                ->send([
                    $mail => "ArabiaTanks"
                ], "Your Order Status", 'send_change_status_mail', [
                    'status' => $status,
                    'order_id' => $order_id,
                ]);
        }
        catch (\Exception $e){
            return false;
        }
        return true;
    }

    public function sendNotificationForClient($user_id,$external_type,$content,$order_id){
        $notification = new GeneralNotifications();
        $notification->type_id=1;
        $notification->user_id= $user_id;
        $notification->module_id=8;
        $notification->application_id= 1;
        $notification->time = time();
        $notification->external_type_id=$external_type;
        $notification->show_type_id = 1;//now
        $notification->content = $content;
        $notification->is_read = 0;
        $notification->url = "";
        $notification->order_id= $order_id;
        $notification->save();
    }
}