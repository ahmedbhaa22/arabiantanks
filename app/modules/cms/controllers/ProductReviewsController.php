<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Models\ProductReviews;
use Models\Content;
use Models\UsersMobile;

class ProductReviewsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$reviews = ProductReviews::find();

		$page = $this->request->get('page');
		$page = isset($page)?$page:1;

		$product_reviews_builder = $this->getProductReviewsBuilder();

		$paginator = new PaginatorQueryBuilder([
			'builder' => $product_reviews_builder,
			'limit'   => 5,
			'page'    => $page
		]);
		
		$this->view->page     = $paginator->getPaginate();
		$this->view->products = Content::find(['Module_ID = 8']);
		$this->view->lang     = $this->session->get('auth-identity')['Lang_ID'];
	}

	private function getProductReviewsBuilder()
	{
		$reviews_builder = $this->modelsManager->createBuilder()->from([
			'reviews'=>ProductReviews::class]);

		return $reviews_builder;
	}

	public function filterReviewsAction()
	{
		$builder = $this->getProductReviewsBuilder();

		$page = $this->request->getPost('page');
		$page = isset($page)?$page:1;

		$clients_builder = $this->modelsManager->createBuilder()->from(UsersMobile::class);

		$product_name = $this->request->getPost('product_name');
		$client_name  = $this->request->getPost('client_name');
		$date_from    = $this->request->getPost('date_from');
		$date_to      = $this->request->getPost('date_to');
// var_dump($client_name);die;
		$valid_product_name = (isset($product_name) && strlen($product_name) > 0)
		?true:false;
		
		$valid_client_name  = (isset($client_name) && strlen($client_name) > 0)
		?true:false;
		
		$valid_date_from    = (isset($date_from) && strlen($date_from) > 0)
		?true:false;
		
		$valid_date_to      = (isset($date_to) && strlen($date_to) > 0)
		?true:false;

		if($valid_product_name)
		{
			$builder->andWhere('reviews.product_id = :p_id:', ['p_id'=>$product_name]);
		}

		if($valid_client_name)
		{
			$builder->leftJoin(UsersMobile::class, 'user.ID = reviews.user_id', 'user');
			$builder->andWhere('user.Title like :client_name:', 
				['client_name' => '%'.$client_name.'%']);
		}

		if($valid_date_from && $valid_date_to)
		{
			$date_from = date('Y-m-d', strtotime($date_from));
			$date_to   = date('Y-m-d', strtotime($date_to));

			$builder->betweenWhere("date(from_unixtime(reviews.created_at))",
				$date_from, $date_to);
		}
		elseif($valid_date_from && !$valid_date_to)
		{
			$date_from = date('Y-m-d', strtotime($date_from));
			
			$builder->andWhere("date(from_unixtime(reviews.created_at)) = :date_from:", 
				['date_from'=>$date_from]);
		}
		elseif(!$valid_date_from && $valid_date_to)
		{
			$date_to = date('Y-m-d', strtotime($date_to));

			$builder->andWhere("date(from_unixtime(reviews.created_at)) = :date_to:", 
				['date_to'=>$date_to]);
		}

		$paginator = new PaginatorQueryBuilder([
			'builder' => $builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$reviews_partial = $this->view->getRender('product_reviews/partials', 'filteredReviews', [
			'page' => $paginator->getPaginate(),
			'lang' => $this->session->get('auth-identity')['Lang_ID']
		]);

		return json_encode(['content' => $reviews_partial]);
	}

	public function changeStatusAction()
	{
		$review_id     = $this->request->getPost('review_id');
		$review_status = $this->request->getPost('review_status');

		$review = ProductReviews::findFirst($review_id);

		if(!$review)
		{
			$this->redirectService->withMessage('error', 'الرأي غير موجود', 
				$this->url->get('product_reviews/index'));
			return;
		}

		if(isset($review_status))
		{
			$review->status_id = 2;
		}
		else
		{
			$review->status_id = 3;
		}

		if(!$review->save())
		{
			$this->redirectService->withMessage('error', 'خطأ أثناء تغيير حالة الرأي، حاول مرة أخرى',
				$this->url->get('product_reviews/index'));
			return;
		}

		$this->redirectService->withMessage('success', 'تم تغيير حالة الرأي بنجاح', 
			$this->url->get('product_reviews/index'));
		return;
	}

	public function deleteAction($id)
	{
		$response['status'] = 0;
        $response['msg']    = '';

        $review = ProductReviews::findFirst($id);

        if(!$review)
        {
            $response['msg'] = 'الرأي غير موجود';
            return json_encode($response);
        }

        if(!$review->delete())
        {
            $response['msg'] = 'خطأ أثناء حذف الرأي، حاول مرة أخرى';
            return $json_encode($response);
        }

        $response['status'] = 1;
        $response['msg']    = 'تم حذف الرأي بنجاح';

        return json_encode($response);
	}

	 public function deleteSelectedAction()
    {
        $response['status'] = 0;
        $response['msg']    = '';

        $ids = $this->request->getPost('selected_ids');
        
        $reviews = ProductReviews::query()->inWhere('id', $ids)->execute();

        foreach($reviews as $review)
        {
            if(!$review->delete())
            {
                $response['msg'] = 'خطأ أثناء حذف الرأي، حاول مرة أخرى';
                return json_encode($response);
            }
        }

        $response['status'] = 1;
        $response['msg']    = 'تم حذف الرأي بنجاح';

        return json_encode($response);
    }
}