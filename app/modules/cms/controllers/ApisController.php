<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/17/2017
 * Time: 10:51 AM
 */

namespace Vokuro\Cms\Controllers;


use Models\Content;
use Models\GeneralNotifications;
use Models\UsersMobile;
use Phalcon\Http\Request;
use Vokuro\Controllers\ControllerApiBase;
use Vokuro\Models\ComparedItems;
use Vokuro\Models\ProductReviews;
use Vokuro\Maintenance\Services\RequestsProblemsApi;

class ApisController extends ControllerApiBase
{
    public function indexAction(){
        $this->view->disable();
        //$filter = json_decode(file_get_contents("php://input"),true);
        $this->response->setContentType('application/json', 'UTF-8');
        //echo json_encode($this->ApiFactory->getDataCmsKeyValues(387));
        $response['status']  = [];
        $response['content'] = [];

        if(!$this->request->isPost())
        {
            $response['status'] = $this->apiFactory->getStatus(400, 'Wrong HTTP method :' . $this->request->getMethod().':');
            echo  json_encode($response);
            return;
        }
        echo json_encode($this->CmsSearch->search());
        // echo json_encode($this->CmsSearch->searchInAction('allCmsFollowed'));

        //echo json_encode($this->CmsSearch->switchSearchAction('content_search',$search_param));
    }

    public function companyBranchesAction()
    {
        $region_id = $this->request->get('region_id');
        $lang_id= 1;
        if($this->request->get("lang_id")){
            $lang_id =   $this->request->get("lang_id");
        }

        $this->view->disable();
        $this->response->setContentType('application/json', 'UTF-8');
        $this->response->setJsonContent($this->apiFactory->getBranches($region_id,$lang_id));
        $this->response->send();
    }

    public function newsletterAction(){
        $this->view->disable();
        $response =[];
        $filter = json_decode(file_get_contents("php://input"),true);
        $params = ['mail','application_id'];
        $check_param= $this->array_keys_exists($params,$filter);
        if(!$check_param){
            $response['status'] = $this->apiFactory->getStatus(422, 'Missing required params [mail,application_id]');
        }
        if(count($response)>0){
            $response["content"]=[];
        }else{
            $response = $this->apiFactory->insertIntoNewsLetter($filter['mail'], $filter['application_id']);
        }
        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }

    public function addReviewAction()
    {
        $this->view->disable();

        $response['status']  = [];
        $response['content'] = [];

        if(!$this->request->isPost())
        {
            $response['status'] = $this->apiFactory->getStatus(400, 'Wrong HTTP method :' . $this->request->getMethod().':');
        }
        else
        {
            $validation_result = $this->validationService->validateRequest($this->request,[
                'user_id', 'product_id', 'rating', 'review'
            ]);

            if(count($validation_result))
            {
                $response['status'] = $this->apiFactory->getStatus(422, 'Missing required params', $validation_result);
            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);

                if(!is_int($request_data['rating']))
                {
                    $response['status'] = $this->apiFactory->getStatus(422, 'Invalid param', ['rating - must be an integer']);
                }
                else
                {
                    $user_review = new ProductReviews();
                    $create_review = $user_review->addReview($request_data);

                    if($create_review['status'] != 0)
                    {
                        $response['content'][] = $create_review['content'];
                        $response['status'] = $this->apiFactory->getStatus(200, 'Review submitted successfully');
                    }
                    else
                    {
                        $response['status'] = $this->apiFactory->getStatus(409, 'Error submitting review', $create_review['messages']);
                    }
                }
            }
        }

        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }

    public function getReviewsAction($product_id)
    {
        $this->view->disable();

        $response['status']  = [];
        $response['content'] = [];

        if(!$this->request->isGet())
        {
            $response['status'] = $this->apiFactory->getStatus(400, 'Wrong HTTP method :' . $this->request->getMethod().':');
        }
        else
        {
            if(!isset($product_id))
            {
                $response['status'] = $this->apiFactory->getStatus(422, 'Missing required params', ['product_id - is required']);
            }
            else
            {
                if(!is_int((int)$product_id) || (int)$product_id === 0)
                {
                    $response['status'] = $this->apiFactory->getStatus(409, 'Invalid param value', ['product_id - must be integer']);
                }
                else
                {
                    $reviews_arr = [];

                    $reviews = ProductReviews::find([
                        'product_id = {product_id}',
                        'order' => 'id desc',
                        'bind' => [
                            'product_id' => $product_id
                        ]
                    ]);

//                   $reviews = ProductReviews::query()
//                       ->andWhere('product_id = '.$product_id)
//                       ->order('id desc')
//                       ->execute();

                    foreach($reviews as $review)
                    {
                        $user = UsersMobile::findFirst([
                            'conditions' => 'ID = {user_id}',
                            'columns'    => 'Title as name',
                            'bind' => [
                                'user_id' => $review->user_id
                            ]
                        ]);

                        $user_name = 'Guest';

                        if($user)
                        {
                            $user_name = $user->name;
                        }

                        $product = Content::findFirst([
                            'conditions' => 'ID = {product_id}',
                            'columns'    => 'Img as image',
                            'bind' => [
                                'product_id' => $review->product_id
                            ]
                        ]);

                        $review_model['id']            = $review->id;
                        $review_model['user_name']     = $user_name;
                        $review_model['product_image'] = $this->di->get('config')['application']['baseUri'].'uploads/'.$product->image;
                        $review_model['rating']        = $review->rating;
                        $review_model['review']        = $review->review;
                        $review_model['created_at']    = $review->created_at;

                        $reviews_arr[] = $review_model;
                    }

                    $response['status']  = $this->apiFactory->getStatus(200, 'Product reviews loaded');
                    $response['content'] = $reviews_arr;
                }
            }
        }

        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }

    public function compareAction($user_id, $item_id)
    {
        $this->view->disable();

        $response['status']  = [];
        $response['content'] = [];

        if(!$this->request->isPost())
        {
            $response['status'] = $this->apiFactory->getStatus(400, 'Wrong HTTP method :' . $this->request->getMethod().':');
        }
        else
        {
            if(!isset($item_id))
            {
                $response['status'] = $this->apiFactory->getStatus(422, 'Missing required params', ['product_id - is required']);
            }
            else
            {
                if(!isset($user_id))
                {
                    $response['status'] = $this->apiFactory->getStatus(422, 'Missing required params', ['user_id - is required']);

                }
                else
                {
                    if(!is_int((int)$item_id) || (int)$item_id === 0 || !is_int((int)$user_id) || (int)$user_id === 0)
                    {
                        $response['status'] = $this->apiFactory->getStatus(409, 'Invalid param value', [
                            'product_id - must be integer' , 'user_id - must be integer'
                        ]);
                    }
                    else
                    {
                        $compared_before = ComparedItems::findFirst("item_id = {$item_id} and user_id = {$user_id}");

                        if($compared_before)
                        {
                            $response['status'] = $this->apiFactory->getStatus(409, 'Item already in compare');
                        }
                        else
                        {
                            $compare = new ComparedItems();
                            $compare->item_id = $item_id;
                            $compare->user_id = $user_id;

                            if($compare->save())
                            {
                                $response['status'] = $this->apiFactory->getStatus(200, 'Item added to compare');
                            }
                            else
                            {
                                $response['status'] = $this->apiFactory->getStatus(400, 'Error adding item to compare', $compare->getMessages());
                            }
                        }
                    }
                }
            }
        }

        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }

    public function comparedItemsAction($user_id)
    {
        $this->view->disable();

        $response['status']  = [];
        $response['content'] = [];

        if(!$this->request->isGet())
        {
            $response['status'] = $this->apiFactory->getStatus(400, 'Wrong HTTP method :' . $this->request->getMethod().':');
        }
        else
        {
            if(!isset($user_id))
            {
                $response['status'] = $this->apiFactory->getStatus(422, 'Missing required params', ['user_id - is required']);
            }
            else
            {
                if(!is_int((int)$user_id) || (int)$user_id === 0)
                {
                    $response['status'] = $this->apiFactory->getStatus(409, 'Invalid param value', [
                        'user_id - must be integer'
                    ]);
                }
                else
                {
                    $compared_items = ComparedItems::get($user_id);

                    if(count($compared_items))
                    {
                        $response['content'] = $this->apiFactory->structureComparedItems($compared_items);
                    }

                    $response['status'] = $this->apiFactory->getStatus(200, 'Compared items loaded');
                }
            }
        }

        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }

    public function removeComparedAction($user_id, $item_id)
    {
        $this->view->disable();

        $response['status']  = [];
        $response['content'] = [];

        if(!$this->request->isDelete())
        {
            $response['status'] = $this->apiFactory->getStatus(400, 'Wrong HTTP method :' . $this->request->getMethod().':');
        }
        else
        {
            if(!isset($user_id) || !is_int((int)$user_id) || (int)$user_id === 0)
            {
                $response['status'] = $this->apiFactory->getStatus(422, 'Invalid param', ['user_id - is required and must be integer']);

            }
            else
            {
                if(!isset($item_id) || !is_int((int)$user_id) || (int)$user_id === 0)
                {
                    $response['status'] = $this->apiFactory->getStatus(422, 'Invalid param', ['item_id - is required and must be integer']);
                }
                else
                {
                    $compare_item = new ComparedItems();

                    $remove_item = $compare_item->remove($user_id, $item_id);

                    if($remove_item)
                    {
                        $response['status'] = $this->apiFactory->getStatus(200, 'Item removed from compare');
                    }
                    else
                    {
                        $response['status'] = $this->apiFactory->getStatus(409, 'Error removing item from compare');
                    }
                }
            }
        }

        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }



    public function formSaveAction($form_id){
        $this->view->disable();
        $response =[];
        $filter = json_decode(file_get_contents("php://input"),true);
        $params = ['name','message','ip','email'];
        $check_param= $this->array_keys_exists($params,$filter);
        if(!$check_param){
            $response['status'] = $this->apiFactory->getStatus(422, 'Missing required params [name,message,email,ip]');
        }
        if(count($response)>0){
            $response["content"]=[];
        }else{
            $fields['name']=$filter['name'];
            $fields['message']=$filter['message'];
            $fields['email']=$filter['email'];
            $fields['ip']=$filter['ip'];
            $response = $this->apiFactory->insertIntoForm(3, $fields);

            $this->sendContactUsEmail($fields['email'] . ' (' . $fields['name'] . ')',
                $fields['message']);
        }
        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();


    }

    private function sendContactUsEmail($contact_user, $message)
    {
        $contact_us_email = \DataKeyvalueUserdata::findFirst([
            'DKV_ID = :dkv:',
            'bind' => [
                'dkv' => 83,
            ]
        ])->Value;

        $this->emailService->send($contact_us_email, $contact_us_email, 'Arabia Tanks - Contact Us', 'contactUs',[
            'contact_user' => $contact_user,
            'message'      => $message
        ]);
    }

    public function array_keys_exists(array $keys, array $arr) {
        return !array_diff_key(array_flip($keys), $arr);
    }

    public function requestVisitAction()
    {
        $this->view->disable();
        $response['status']  = [];
        $response['content'] = [];

        if(!$this->request->isPost())
        {
            $response['status'] = $this->apiFactory->getStatus(400, 'Wrong HTTP method :' . $this->request->getMethod().':');
        }
        else
        {
            $validation_result = $this->validationService->validateRequest($this->request,[
                'date', 'name', 'mobile', 'location'
            ]);

            if(count($validation_result))
            {
                $response['status'] = $this->apiFactory->getStatus(422, 'Missing required params', $validation_result);

            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);
                $response = $this->apiFactory->requestVisit(2, $request_data);
            }
        }

        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }

    public function order_historyAction($order_number){
        $this->view->disable();
        $this->response->setContentType('application/json', 'UTF-8');
        $order_number = (int)$order_number;
        $request_service = new RequestsProblemsApi();
        $result = $request_service->order_history($order_number);
        $response['status']  = 200;
        $response['content'] = $result;
        echo json_encode($response);
    }

    public function notifyAction(){
        $this->view->disable();
        $response['status']  = [];
        $response['content'] = [];
        if(!$this->request->isPost()){
            die("Wrong HTTP Method");
        }
        $request = json_decode(file_get_contents("php://input"));
        //Test
        $response = $this->apiFactory->add_notification($request);
        $response['content'] = $this->request->get("user_id");
        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();

    }
    public function notification_readAction(){
        $this->view->disable();
        $response['status']  = [];
        $response['content'] = [];
        if(!$this->request->isPost()){
            die("Wrong HTTP Method");
        }
        $request = json_decode(file_get_contents("php://input"));
        //Test
        $response = $this->apiFactory->read_notification($request);
        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();

    }

    public function new_notificationsAction(){
        $this->view->disable();
        $response['status']  = [];
        $response['content'] = [];
        $request = json_decode(file_get_contents("php://input"));
        //Test
        $response = $this->apiFactory->get_new_notifications($request);
        $this->response->setContentType('application/json','UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }
}