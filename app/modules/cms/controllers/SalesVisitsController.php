<?php

namespace Vokuro\Cms\Controllers;

use Models\TanksRegions;
use Vokuro\Cms\Services\SalesRepsService;
use Vokuro\Cms\Services\SalesVisitsService;
use Vokuro\Controllers\ControllerBase;
use Models\MissionTypes;
use Vokuro\Geo\Models\GeoCountries;
use Vokuro\Geo\Models\GeoRegions;
use Models\UserCategories;
use Vokuro\UsersModule\Models\UserData;
use Models\UsersMobile;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Pentavalue\RequestValidation;
use Models\SalesVisits;

class SalesVisitsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$visits_builder = $this->createVisitsBuilder();

		$page = $this->request->get('page');
		$page = isset($page)?$page:1;

		$paginator = new PaginatorQueryBuilder([
			'builder' => $visits_builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$this->view->page = $paginator->getPaginate();
        $regions = TanksRegions::find();
        $this->view->regions = $regions;
	}

	private function createVisitsBuilder()
	{
        $builder = $this->SalesVisitsPermissions->visits_query_builder();
        if($builder != false){
            return $builder;
        }

	}

	public function addAction()
	{
        if(!$this->SalesVisitsPermissions->check_add()){
            $this->flashSession->error("You Don't Have Permission To This Section, Please Contact System Admin");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        };
        $this->view->mission_types   = MissionTypes::find();
		$this->view->user_categories = UserCategories::find();
		$this->view->countries       = GeoCountries::find();
		$this->view->regions         = GeoRegions::find();
	}

	public function filterClientsAction()
	{
		$clients_builder = $this->createClientsBuilder();

		$page = $this->request->get('page');
		$page = isset($page)?$page:1;

		$paginator = new PaginatorQueryBuilder([
			'builder' => $clients_builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$clients_table = $this->view->getRender('sales_visits/partials', 'filteredClients', [
			'page'       => $paginator->getPaginate(),
			'category'   => $this->request->get('client_category'),
			'name'       => $this->request->get('client_name'),
			'email'      => $this->request->get('client_email'),
			'company'    => $this->request->get('company'),
			'mobile'     => $this->request->get('mobile'),
			'country'    => $this->request->get('country'),
			'region'     => $this->request->get('region'),
			'active'     => $this->request->get('active'),
			'not_active' => $this->request->get('not_active')
		]);

		return json_encode(['content' => $clients_table]);
	}

	private function createClientsBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(UsersMobile::class)
		->where('is_admin = 0');

		$cat_id       = $this->request->get('client_category');
		$client_name  = $this->request->get('client_name');
		$email        = $this->request->get('client_email');
		$company_name = $this->request->get('company');
		$mobile       = $this->request->get('mobile');
		$country_id   = $this->request->get('country');
		$region_id    = $this->request->get('region');
		$is_active    = $this->request->get('active');
		$not_active   = $this->request->get('not_active');

		if(isset($cat_id) && strlen($cat_id) > 0)
		{
			$builder->andWhere('category_id = :cat_id:',[
				'cat_id' => $cat_id
				]);
		}
		else
		{
			$builder->andWhere('category_id is not null');
		}

		if(isset($client_name) && strlen($client_name) > 0)
		{
			$builder->andWhere('Title like :client_name:', [
				'client_name' => '%'.$client_name.'%'
				]);
		}

		if(isset($email) && strlen($email) > 0)
		{
			$builder->andWhere('Mail = :email:', [
				'email' => $email
				]);
		}

		if(isset($mobile) && strlen($mobile) > 0)
		{
			$builder->andWhere('Mobile like :mobile:', [
				'mobile' => '%'.$mobile.'%'
				]);
		}

		if($is_active == 'true' && $not_active == 'false')
		{
			$builder->andWhere('Active = :active:',['active'=>1]);
		}
		elseif($is_active == 'false' && $not_active == 'true')
		{
			$builder->andWhere('Active = :not_active:', ['not_active'=>0]);
		}

		// get user data
		$user_data_builder = $this->modelsManager->createBuilder()->from(UserData::class);


		if(isset($company_name) && strlen($company_name) > 0)
		{
			$user_data_builder->andWhere('company_name like :company_name:', [
				'company_name' => '%'.$company_name.'%'
				]);
		}

		if(isset($country_id) && strlen($country_id) > 0)
		{
			$user_data_builder->andWhere('country_id = :country_id:', [
				'country_id' => $country_id
				]);
		}

		if(isset($region_id) && strlen($region_id) > 0)
		{
			$user_data_builder->andWhere('region_id = :region_id:', [
				'region_id' => $region_id
				]);
		}

		$user_data = $user_data_builder->columns('user_id')->getQuery()->execute()->toArray();
		
		$users_ids = [];

		foreach ($user_data as $ud)
		{
			$users_ids[] = current($ud);
		}

		
		$builder->inWhere('ID', $users_ids);
		
		return $builder;
	}

	public function saveAction($visit_id=null)
	{
		if(!$this->request->isPost())
		{
			$this->redirectService->withMessage('error', 'Invalid request', 
				$this->url->get('sales_visits/index'));
			return;
		}

		$from_action = $this->request->getPost('from_action');

		$validator = new RequestValidation($this->request);

		$validator->required([
			'visit_date', 'mission_type', 'client_id'
		]);

		$validation_result = $validator->validate();

		if(count($validation_result))
		{
			$this->session->set('error_msgs', $validation_result);
			
			if($from_action == 'edit')
			{
				return $this->response->redirect($this->url->get('sales_visits/edit/'.$visit_id));
			}

			return $this->response->redirect($this->url->get('sales_visits/add'));
		}

		$visit_date   = $this->request->getPost('visit_date');
		$mission_type = $this->request->getPost('mission_type');
		$comment      = $this->request->getPost('comment');
		$client_id    = $this->request->getPost('client_id');

		$visit = SalesVisits::instantiate();

		if(isset($visit_id))
		{
			$visit = SalesVisits::findFirst($visit_id);

			if(!$visit)
			{
				$visit = SalesVisits::instantiate();
			}
			else
			{
				$visit->updated_at = time();
			}
		}

		$visit->date                  = strtotime($visit_date);
		$visit->mission_type_id       = $mission_type;
		$visit->representitve_comment = $comment;
		$visit->client_id             = $client_id;
		$visit->created_by            = $this->session->get('auth-identity')['id'];

        //If Logged user is sales rep make it sales person
        $user_rules = $this->session->get('auth-identity')["rules"];
        // dd($user_rules);
        if(array_key_exists(7,$user_rules)){
            $visit->sales_person = $this->session->get('auth-identity')['id'];
        };

        if(array_key_exists(7,$user_rules)){
            $visit->sales_person_branch_id = $this->session->get('auth-identity')['user_info']["branch"];
        };

		if(!$visit->save())
		{
			if($from_action == 'edit')
			{
				$this->redirectService->withMessage('error', 'خطأ أثناء حفظ الزيارة، حاول مرة أخرى', 
					$this->url->get('sales_visits/edit/'.$visit_id));
				return;
			}

			$this->redirectService->withMessage('error', 'خطأ أثناء حفظ الزيارة، حاول مرة أخرى', 
					$this->url->get('sales_visits/add'));
			return;
		}

		$this->redirectService->withMessage('success', 'تم حفظ الزيارة بنجاح', 
			$this->url->get('sales_visits/index'));
		return;
	}

	public function editAction($visit_id)
	{
		$this->view->visit           = SalesVisits::findFirst($visit_id);
		$this->view->mission_types   = MissionTypes::find();
		$this->view->user_categories = UserCategories::find();
		$this->view->countries       = GeoCountries::find();
		$this->view->regions         = GeoRegions::find();
	}

	public function deleteAction($visit_id)
	{
		$response['status'] = 0;
		$response['msg']    = '';

		$visit = SalesVisits::findFirst($visit_id);

		if(!$visit->delete())
		{
			$response['msg'] = 'خطأ أثناء حذف الزيارة، حاول مرة أخرى';
			return json_encode($response);
		}

		$response['status'] = 1;
		$response['msg']    = 'تم حذف الزيارة بنجاح';

		return json_encode($response);
	}

	public function viewAction($visit_id)
	{
		$this->view->visit = SalesVisits::findFirst($visit_id);
	}

	public function list_repsAction(){
        $page = $this->request->getQuery("page")?:1;
        $sales_reps_service = new SalesRepsService();
        $paginator = new PaginatorQueryBuilder([
            'builder' => $sales_reps_service->search(),
            'limit'   => 10,
            'page'    => $page
        ]);

        $this->view->page = $paginator->getPaginate();
    }

    public function sales_visits_statsAction($sales_rep_id){
        $date_from=$this->request->get("date_from");
        $date_to=$this->request->get("date_to");
        $date["from"]=$date_from;
        $date["to"]=$date_to;
        $sales_visits_service = new SalesVisitsService();
        $missions_sale = $sales_visits_service->sales_rep_stats(1,$sales_rep_id,$date);
        $missions_product_view = $sales_visits_service->sales_rep_stats(2,$sales_rep_id,$date);
        $missions_expected_client = $sales_visits_service->sales_rep_stats(3,$sales_rep_id,$date);
        $missions_cash_collect = $sales_visits_service->sales_rep_stats(4,$sales_rep_id,$date);
        $this->view->missions_sale=$missions_sale[0]->id;
        $this->view->missions_product_view=$missions_product_view[0]->id;
        $this->view->missions_expected_client=$missions_expected_client[0]->id;
        $this->view->missions_cash_collect=$missions_cash_collect[0]->id;
        $this->view->date = $date;
    }
}