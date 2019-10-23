<?php

namespace Vokuro\Cms\Controllers;

use Models\TanksCities;
use Models\TanksRegions;
use Vokuro\Controllers\ControllerBase;
use Models\UsersMobile;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Models\UserCategories;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Geo\Models\GeoCountries;
use Vokuro\SalesVisits\Models\TanksSalesRepsClients;
use Vokuro\UsersModule\Models\UserData;
use Vokuro\Pentavalue\RequestValidation;
use Vokuro\UsersModule\Models\UserAddresses;
use Phalcon\Mvc\Dispatcher;
use Vokuro\Cart\Models\Orders;
use Vokuro\UsersModule\Services\TwilioSmsService;

class ClientsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
		$this->emailService->setControllerObj($this);
	}

	public function indexAction()
	{
		// return index view
	}

	public function listAction()
	{
		$page = $this->request->get('page');

		$page   = isset($page)?$page:1;
		// $limit  = 10;
		// $offset = 0;
		
		// if($page != 1)
		// {
		// 	$offset = ($page-1) * $limit;
		// }

		// $clients = UsersMobile::query()->limit($limit, $offset)->execute()->count();
		// var_dump($clients);die;

		$clients_builder = $this->getClientsBuilder();
	
		$paginator = new PaginatorQueryBuilder([
			"builder" => $clients_builder,
			"limit"   => 20,
			"page"    => $page
			]);

		$temp_builder = $this->getClientsBuilder();
		
		$all_ids = [];
		$all_clients_ids = $temp_builder->columns('ID')->getQuery()->execute();
		
		foreach($all_clients_ids as $client_id)
		{
			$all_ids[] = current($client_id);
		}

		$client_categories = UserCategories::find();

		$countries = GeoCountries::find();

		$regions = GeoRegions::find();


		$this->view->page       = $paginator->getPaginate();
		$this->view->countries  = $countries;
		$this->view->regions    = $regions;
		$this->view->categories = $client_categories;
		$this->view->all_ids    = json_encode($all_ids);
	}

	public function filterClientsAction()
	{
		$builder = $this->getClientsBuilder();
		$temp_builder = $this->getClientsBuilder();

		$page = $this->request->getPost('page');
		$page = isset($page)?$page:1;

		$cat_id       = $this->request->getPost('category_id');
		$client_name  = $this->request->getPost('client_name');
		$email        = $this->request->getPost('email');
		$last_login   = $this->request->getPost('last_login');
		$company_name = $this->request->getPost('company_name');
		$mobile       = $this->request->getPost('mobile');
		$country_id   = $this->request->getPost('country_id');
		$region_id    = $this->request->getPost('region_id');
		$is_active    = $this->request->getPost('is_active');
		$not_active   = $this->request->getPost('not_active');

		if(isset($cat_id) && strlen($cat_id) > 0)
		{
			$builder->andWhere('client.category_id = :cat_id:',[
				'cat_id' => $cat_id
				]);

			$temp_builder->andWhere('client.category_id = :cat_id:',[
				'cat_id' => $cat_id
				]);
		}

		if(isset($client_name) && strlen($client_name) > 0)
		{
			$builder->andWhere('client.Title like :client_name:', [
				'client_name' => '%'.$client_name.'%'
				]);

			$temp_builder->andWhere('client.Title like :client_name:', [
				'client_name' => '%'.$client_name.'%'
				]);
		}

		if(isset($email) && strlen($email) > 0)
		{
			$builder->andWhere('client.Mail = :email:', [
				'email' => $email
				]);

			$temp_builder->andWhere('client.Mail = :email:', [
				'email' => $email
				]);
		}

		if(isset($mobile) && strlen($mobile) > 0)
		{
			$builder->andWhere('client.Mobile like :mobile:', [
				'mobile' => '%'.$mobile.'%'
				]);

			$temp_builder->andWhere('client.Mobile like :mobile:', [
				'mobile' => '%'.$mobile.'%'
				]);
		}

		if((isset($is_active) && $is_active == 1) && (!isset($not_active) || $not_active != 1))
		{
			$builder->andWhere('client.Active = :is_active:', [
				'is_active' => 1
				]);

			$temp_builder->andWhere('client.Active = :is_active:', [
				'is_active' => 1
				]);
		}

		if((isset($not_active) && $not_active == 1) && (!isset($is_active) || $is_active != 1))
		{
			$builder->andWhere('client.Active = :not_active:', [
				'not_active' => 0
			]);

			$temp_builder->andWhere('client.Active = :not_active:', [
				'not_active' => 0
			]);
		}

		$builder->leftJoin(UserData::class, 'ud.user_id = client.ID', 'ud');

		if(isset($last_login) && strlen($last_login) > 0)
		{
			$date = date('d/m/Y', strtotime($last_login));

			$builder->andWhere('ud.last_login_date = :last_login:', [
				'last_login' => $date
				]);

			$temp_builder->andWhere('ud.last_login_date = :last_login:', [
				'last_login' => $date
				]);
		}

		if(isset($company_name) && strlen($company_name) > 0)
		{
			$builder->andWhere('ud.company_name like :company_name:', [
				'company_name' => '%'.$company_name.'%'
				]);

			$temp_builder->andWhere('ud.company_name like :company_name:', [
				'company_name' => '%'.$company_name.'%'
				]);
		}

		if(isset($country_id) && strlen($country_id) > 0)
		{
			$builder->andWhere('ud.country_id = :country_id:', [
				'country_id' => $country_id
				]);

			$temp_builder->andWhere('ud.country_id = :country_id:', [
				'country_id' => $country_id
				]);
		}

		if(isset($region_id) && strlen($region_id) > 0)
		{
			$builder->andWhere('ud.region_id = :region_id:', [
				'region_id' => $region_id
				]);

			$temp_builder->andWhere('ud.region_id = :region_id:', [
				'region_id' => $region_id
				]);
		}

		// var_dump($builder->getQuery()->execute()->toArray());die;
		$paginator = new PaginatorQueryBuilder([
			'builder' => $builder,
			'limit'   => 5,
			'page'    => $page
		]);
		
		$all_ids = [];
		$all_clients_ids = $temp_builder->columns('ID')->getQuery()->execute();
		
		foreach($all_clients_ids as $client_id)
		{
			$all_ids[] = current($client_id);
		}

		$filtered_clients = $this->view->getRender('clients/partials', 'filteredClients', [
			'page'    => $paginator->getPaginate(),
			'all_ids' => json_encode($all_ids)
		]);

		return json_encode(['content' => $filtered_clients]);
	}

	private function getClientsBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(['client'=>UsersMobile::class])
		->where('client.is_admin = 0')
		->andWhere('client.category_id is not null')
        ->orderBy("client.ID DESC");
		
		return $builder;
	}

	public function deleteAction($id)
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$client = UsersMobile::query()
		->where('ID = :id:')
		->andWhere('category_id is not null')
		->bind(['id'=>$id])->execute()->getFirst();

		if(!$client)
		{
			$response['msg'] = 'Client does not exist';
			return json_encode($response);
		}

		if($client->data)
		{
			$client->data->delete();
		}

		if(!$client->delete())
		{
			$response['msg'] = 'Unable to delete client, please try again';
			return json_encode([$response]);
		}

		$response['status'] = 1;
		$response['msg'] = 'Client deleted successfully';

		return json_encode($response);
	}

	public function deleteSelectedAction()
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$ids = $this->request->getPost('clients');
		
		$clients = UsersMobile::query()->inWhere("ID", $ids)
		->andWhere('category_id is not null')->execute();

		foreach($clients as $client)
		{
			if($client->data)
			{
				$client->data->delete();
			}

			if(!$client->delete())
			{
				$response['msg'] = 'Unable to delete client, please try again';
				return json_encode($response);
			}
		}

		$response['status'] = 1;
		$response['msg'] = 'Clients deleted successfully';

		return json_encode($response);
	}

	public function exportExcelAction()
	{
		$all_ids = $this->request->getPost('all_ids');

		if(count($all_ids) == 0)
		{
			return json_encode(['status' => 0, 'file_name' => '']);
		}
		
		$clients = UsersMobile::query()->inWhere('ID', $all_ids)->execute();
        //this because php-zip extension is not installed
        \PHPExcel_Settings::setZipClass(\PHPExcel_Settings::PCLZIP);
		$phpexcel = new \PHPExcel();

        $phpexcel->getProperties()->setCreator('Appox');
        $phpexcel->getProperties()->setTitle('Clients');
        $phpexcel->getProperties()->setSubject('Clients Data');
        $phpexcel->setActiveSheetIndex(0);
        $phpexcel->getActiveSheet()->setRightToLeft(true);

		$header_fields = ['ID', 'البريد الالكتروني', 'اسم العميل', 'تصنيف العميل', 'الشركة', 'الهاتف', 'الرمز البريدي', 'نشط', 'تاريخ التسجيل', 'النشاط الاخير'];

		$export_data = $this->prepareData($clients);

		$file_header = $this->createFileHeader();

		for ($i = 0; $i < count($header_fields); $i++) {
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
		$file_name = 'Clients_Exported_' . date('Y-m-d H-i-s') . '.xlsx';

		if(!file_exists(BASE_PATH . '/public/clients/'))
		{
			mkdir(BASE_PATH . '/public/clients/');
		}

		$file_path = BASE_PATH . '/public/clients/' . $file_name;
		ob_clean();
        $obj_writer->save($file_path);
        return json_encode(['status' => 1, 'file_name' => $file_name]);
	}

	private function prepareData($clients)
	{
		$prepared_data = [];

		foreach($clients as $client)
		{
			$prepared_data[$client->ID]['id'] = $client->ID;
			$prepared_data[$client->ID]['email'] = $client->Mail;
			$prepared_data[$client->ID]['name'] = $client->Title;
			$prepared_data[$client->ID]['cat'] = $client->category->name;
			$prepared_data[$client->ID]['company'] = $client->data?$client->data->company_name:'';
			$prepared_data[$client->ID]['mobile'] = $client->Mobile;
			$prepared_data[$client->ID]['postal'] = $client->data?$client->data->postal_code:'';
			$prepared_data[$client->ID]['active'] = ($client->Active == '1')?1:0;
			$prepared_data[$client->ID]['join_date'] = date('d/m/Y', $client->Join_Date);
			$prepared_data[$client->ID]['last_login'] = $client->data?$client->data->last_login_date:'';
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

    public function removeFileAction()
    {
    	if($this->request->isAjax())
    	{
    		unlink(BASE_PATH . '/public/clients/' . $this->request->getPost('file_name'));
    	}
    }

    public function addAction($client_id=null)
    {
    	$branches   = \Vokuro\Models\CompanyBranches::find();
    	$regions    = TanksRegions::find();
    	$cities     = TanksCities::find();
    	$categories = UserCategories::find();

    	$this->view->branches    = $branches;
    	$this->view->regions     = $regions;
    	$this->view->cities      = $cities;
    	$this->view->categories  = $categories;
    	$this->view->client_id   = $client_id;
    	$this->view->from_action = $this->dispatcher->getActionName();
    	$this->view->lang        = $this->session->get('auth-identity')['Lang_ID'];
    }

    public function saveAction($client_id=null)
    {
    	$this->session->set('error_msgs', []);
    	$this->session->set('old_client_data', []);
    	$from_action = $this->request->getPost('from_action');

    	if(!$this->request->isPost())
    	{
    		$this->response->redirect($this->url->get('clients/add'));
    	}
    	// var_dump($this->request->getPost('address_data'));die;

    	$validator = new RequestValidation($this->request);

    	if($from_action != 'edit')
    	{
    		$validation_result = $validator
			->required(['password','confirm_password'])
			->required(['name','category_id','mobile'])
			// ->required(['region_id','city_id','branch_id'])
			->stringLength('password', 8, 20)
			->passwordConfirm('password', 'confirm_password')->validate();


    		if(count($validation_result))
	    	{
	    		$this->session->set('error_msgs', $validation_result);

				return $this->response->redirect($this->url->get('clients/add'));
	    		
	    	}
    	}
    	else
    	{
    		$password           = $this->request->getPost('password');
    		$confirm_password   = $this->request->getPost('confirm_password');

    		$validator->required(['name','category_id','mobile']);

    		if(isset($password) && strlen($password) > 0 && isset($confirm_password) && strlen($confirm_password) > 0)
    		{
    			$validator->required(['password','confirm_password'])
    			->stringLength('password', 8, 20)
				->passwordConfirm('password', 'confirm_password');
    		}

    		$validation_result = $validator->validate();

			if(count($validation_result))
	    	{
	    		$this->session->set('error_msgs', $validation_result);

				return $this->response->redirect($this->url->get('clients/edit/'.$client_id));	
	    	}

    	}
		
    	$name               = $this->request->getPost('name');
    	$email              = $this->request->getPost('email')?:"";
    	$birthdate          = $this->request->getPost('birthdate');
    	$gender             = $this->request->getPost('gender');
    	$addresses          = $this->request->getPost('address_data');
    	$category_id        = $this->request->getPost('category_id');
    	$company_name       = $this->request->getPost('company_name');
    	$region_id          = $this->request->getPost('region_id');
    	$city_id            = $this->request->getPost('city_id');
    	$branch_id          = $this->request->getPost('branch_id');
    	$mobile             = $this->request->getPost('mobile');
    	$postal_code        = $this->request->getPost('postal_code');
    	$supervisor_comment = $this->request->getPost('supervisor_comment');
    	$password           = $this->request->getPost('password');
    	$confirm_password   = $this->request->getPost('confirm_password');
    	$active             = $this->request->getPost('active');
        $created_by             = $this->session->get('auth-identity')['id'];

    	if($from_action == 'add')
    	{
    		if(UsersMobile::emailExists($email) && $email!="")
			{
				$error_msg['field'] = 'email';
				$error_msg['message'] = 'تم تسجيل الدخول بهذا البريد الالكتروني من قبل';

				$this->session->set('error_msgs', [$error_msg]);

	    		if($from_action === 'add')
	    		{
	    			return $this->response->redirect($this->url->get('clients/add'));
	    		}
	    		elseif($from_action === 'edit')
	    		{
	    			return $this->response->redirect($this->url->get('clients/edit/'.$client_id));	
	    		}
			}
	
    	}
    	
    	if(isset($client_id))
    	{
    		$client = UsersMobile::findFirst($client_id);
    	}
    	else
    	{
    		$client = new UsersMobile;
            $client->created_by         = $created_by;
    	}

    	$client->Title          = $name;
    	$client->Mail           = $email;
    	$client->category_id    = $category_id;
    	$client->Mobile         = $mobile;
    	$client->Pass           = (isset($password) && strlen($password) > 0)?$this->security->hash($password):$client->Pass;
    	$client->Application_ID = $this->session->get('auth-identity')['Application_ID'];
    	$client->Module_ID      = 20002;
    	$client->Active         = isset($active)?1:0;



    	if(!$client->save())
    	{
    		$this->session->set('old_client_data', $validator->getRequestArray());
    		$this->session->set('error_msgs', $this->messagesArray($client->getMessages()));
    		return $this->response->redirect($this->url->get('clients/add'));
    	}

    	$gender = isset($gender)?1:2;
    	
    	if(isset($client_id))
    	{
    		$user_data = UserData::findFirst([
    			'user_id = :user_id:',
    			'bind' => [
    				'user_id' => $client_id
    			]
    			]);

    		if(!$user_data)
    		{
    			$user_data = new UserData;
    		}
    	}
    	else
    	{
    		$user_data = new UserData;
    	}

    	$user_data->user_id   = $client->ID;
    	$user_data->gender_id = $gender;
    	$user_data->birthdate = strtotime($birthdate);
    	$user_data->region_id = (isset($region_id) && strlen($region_id)>0)?$region_id:null;
    	$user_data->city_id   = (isset($city_id) && strlen($city_id)>0)?$city_id:null;
    	$user_data->supervisor_comment = $supervisor_comment;
    	$user_data->branch_id          = (isset($branch_id)&&strlen($branch_id)>0)?$branch_id:null;
    	$user_data->company_name       = $company_name;
    	$user_data->postal_code        = $postal_code;

    	if(!$user_data->save())
    	{
    		$this->session->set('old_client_data', $validator->getRequestArray());
    		$this->session->set('error_msgs', $this->messagesArray($user_data->getMessages()));

    		if($from_action === 'add')
    		{
    			return $this->response->redirect($this->url->get('clients/add/'.$client->ID));
    		}
    		elseif($from_action === 'edit')
    		{
    			return $this->response->redirect($this->url->get('clients/edit/'.$client_id));
    		}
    	}

    	if(count($addresses))
    	{
    		if(isset($client_id))
    		{
    			$old_addresses = UserAddresses::find([
				'user_id = {user_id}',
				'bind' => [
					'user_id' => $client_id
				]
				]);

    			foreach($old_addresses as $old_address)
    			{
    				$old_address->delete();
    			}
    		}

    		foreach($addresses as $address)
    		{
    			$client_address = new UserAddresses;

    			$client_address->user_id     = $client->ID;
    			$client_address->city_id     = (isset($address['city'])&&strlen($address['city'])>0)?$address['city']:null;
    			$client_address->region_id   = (isset($address['region'])&&strlen($address['region'])>0)?$address['region']:null;
    			$client_address->details     = (isset($address['details']) && strlen($address['details']) > 0)?$address['details']:'no address';
    			$client_address->postal_code = $postal_code;
    			$client_address->is_main     = (isset($address['is_main']))?1:0;

    			if(!$client_address->save())
    			{
    				$this->session->set('old_client_data', $validator->getRequestArray());
    				$this->session
    				->set('error_msgs', $this->messagesArray($client_address->getMessages()));

    				if($from_action === 'add')
    				{
    					return $this->response->redirect($this->url->get('clients/add/'.$client->ID));
    				}	
    				elseif($from_action === 'edit')
    				{
    					return $this->response->redirect($this->url->get('clients/edit/'.$client_id));
    				}
				}
    		}
    	}

    	// create default cart and wishlist for user if has no cart or wishlist
		Orders::getUserCart($client->ID);
		Orders::getUserWishlist($client->ID);

    	if($from_action === 'add')
    	{
    		$this->redirectService->withMessage('success', 'تم إضافة العميل بنجاح', 
    		$this->url->get('clients/list'));
    		return;
    	}
    	elseif($from_action === 'edit')
    	{
    		$this->redirectService->withMessage('success', 'تم تعديل بيانات العميل بنجاح', 
    		$this->url->get('clients/list'));
    		return;
    	}
    }

    public function editAction($client_id)
    {
    	$client = UsersMobile::findFirst($client_id);
    	$branches   = \Vokuro\Models\CompanyBranches::find();
    	$regions    = TanksRegions::find();
    	$cities     = TanksCities::find();
    	$categories = UserCategories::find();

    	$this->view->branches    = $branches;
    	$this->view->regions     = $regions;
    	$this->view->cities      = $cities;
    	$this->view->categories  = $categories;
    	$this->view->client_id   = $client_id;
    	$this->view->from_action = $this->dispatcher->getActionName();
    	$this->view->client      = $client;
    	$this->view->client_data = $client->data?$client->data:null;
    	$this->view->addresses   = $client->shippingAddresses?$client->shippingAddresses:null;
    	$this->view->lang        = $this->session->get('auth-identity')['Lang_ID'];
    }

    public function viewAction($client_id)
    {
    	$client      = UsersMobile::findFirst($client_id);
    	$client_data = $client->data?$client->data:null;
    	$addresses   = $client->shippingAddresses?$client->shippingAddresses:null;
    	$country     = $client_data?GeoCountries::findFirst($client_data->country_id)->name:null;
    	$city        = $client_data?GeoCities::findFirst($client_data->city_id)->name:null;
    	$categories  = UserCategories::find();
    	$orders      = Orders::find([
    		'user_id = :user_id:',
    		'bind' => [
    			'user_id' => $client_id
    		]
    		]);

    	$user_cart     = Orders::getUserCart($client_id);
    	$user_wishlist = Orders::getUserWishlist($client_id);
    	$countries     = GeoCountries::find();
    	$cities        = GeoCities::find();
    	$regions       = GeoRegions::find();

    	$this->view->client      = $client;
    	$this->view->client_data = $client_data;
    	$this->view->addresses   = $addresses;
    	$this->view->country     = $country;
    	$this->view->city        = $city;
    	$this->view->categories  = $categories;
    	$this->view->orders      = $orders;
    	$this->view->cart        = $user_cart;
    	$this->view->wishlist    = $user_wishlist;
    	$this->view->countries   = $countries;
    	$this->view->cities      = $cities;
    	$this->view->regions     = $regions;
    	$this->view->lang        = $this->session->get('auth-identity')['Lang_ID'];
        //Check Sales Rep
        $this->view->added_by ="";
        $tanks_sales_rep_client = TanksSalesRepsClients::findFirst(["sales_rep_id={$client->ID}"]);
        if($tanks_sales_rep_client){
            $this->view->added_by = $tanks_sales_rep_client->SalesPerson->Title;
        }
    }

    public function changeCategoryAction()
    {
    	if(!$this->request->isPost())
    	{
    		$this->redirectService->withMessage('error', 'Invalid request', 
    		$this->url->get('clients/list'));
    		return;
    	}

    	$client_id   = $this->request->getPost('client_id');
    	$category_id = $this->request->getPost('category_id');

    	$client = UsersMobile::findFirst($client_id);

    	if(!$client)
    	{
    		$this->redirectService->withMessage('error', 'Error fetching client', 
    		$this->url->get('clients/view/'.$client_id));
    		return;
    	}

    	$client->category_id = $category_id;

    	if(!$client->save())
    	{
    		$this->redirectService->withMessage('error', 'Error updating client', 
    		$this->url->get('clients/view/'.$client_id));
    		return;
    	}

    	$this->redirectService->withMessage('success', 'Category updated', 
    		$this->url->get('clients/view/'.$client_id));
    	return;
    }

    public function addAddressAction()
    {
    	if(!$this->request->isPost())
    	{
    		$this->redirectService->withMessage('error', 'Invalid Request', 
    		$this->url->get('clients/list'));
    		return;
    	}

    	$client_id = $this->request->getPost('client_id');
    	$address   = $this->request->getPost('address');
    	$country   = $this->request->getPost('country');
    	$city      = $this->request->getPost('city');
    	$region    = $this->request->getPost('region');
    	$is_main   = $this->request->getPost('is_main');
    	$is_main   = isset($is_main)?1:0;

    	if($is_main == 1)
    	{
    		$addresses = UserAddresses::find([
    			'user_id = :user_id:',
    			'bind' => [
    				'user_id' => $client_id
    			]
    			]);
    		
    		UserAddresses::makeNotMain($addresses);
    	}

    	$new_address = new UserAddresses;

    	$new_address->user_id = $client_id;
    	$new_address->details = $address;
    	$new_address->country_id    = $country;
    	$new_address->city_id       = $city;
    	$new_address->region_id     = $region;
    	$new_address->is_main       = $is_main;

    	if(!$new_address->save())
    	{
    		$this->redirectService->withMessage('error', 'Error saving address', 
    		$this->url->get('clients/view/'.$client_id));
    		return;
    	}

    	$this->redirectService->withMessage('success', 'Address added', 
		$this->url->get('clients/view/'.$client_id));
		return;
    }

    public function changePasswordAction()
    {
    	$this->session->set('error_msgs', []);

    	if(!$this->request->isPost())
    	{
    		$this->redirectService->withMessage('error', 'Invalid request', $this->url->get('clients/list'));
    		return;
    	}

    	$client_id = $this->request->getPost('client_id');
    	$password  = $this->request->getPost('password');
    	$confirm_password = $this->request->getPost('confirm_password');

    	$validator = new RequestValidation($this->request);

    	$validation_result = $validator->passwordConfirm('password','confirm_password')->validate();

    	if(count($validation_result))
    	{
    		$this->session->set('error_msgs', $validation_result);
    		return $this->response->redirect($this->url->get('clients/view/'.$client_id));
    	}

    	$client = UsersMobile::findFirst($client_id);

    	if(!$client)
    	{
    		$this->redirectService->withMessage('error', 'Invalid user', $this->url->get('clients/view/'.$client_id));
    		return;
    	}

    	$client->Pass = $this->security->hash($password);

    	if(!$client->save())
    	{
    		$this->redirectService->withMessage('error', 'Error changing password, please try again',
    			$this->url->get('clients/view/'.$client_id));
    		return;
    	}

    	$this->redirectService->withMessage('success', 'Password changed', $this->url->get('clients/view/'.$client_id));
    	return;
    }

    public function sendMessageAction()
    {
    	$client_id     = $this->request->getPost('client_id');
    	$client_name   = $this->request->getPost('client_name');
    	$client_mobile = $this->request->getPost('client_mobile');
    	$client_mail   = $this->request->getPost('client_mail');
    	$type    = $this->request->getPost('type');
    	$message = $this->request->getPost('msg');

    	switch($type)
    	{
    		case '1':
	    		$twilio = new TwilioSmsService($this->di->getConfig()['twilio']);
	    		$send_result = $twilio->send($client_mobile, $msg);

	    		if($send_result)
	    		{
	    			$this->redirectService->withMessage('success', 'Sms sent', $this->url->get('clients/view/'.$client_id));
	    			return;
	    		}

	    		$this->redirectService->withMessage('error', 'Error sending sms', $this->url->get('clients/view/'.$client_id));
				return;
	    		break;
    		case '2':
	    		$this->redirectService->withMessage('error', 'no notification', $this->url->get('clients/view/'.$client_id));
				return;
    		break;
	    		case '3':
	    		$send_result = $this->emailService->send($client_mail, $client_name, 'Tanks', 'defaultEmail',[
	    			'msg' => $message
	    			]);

	    		if($send_result)
	    		{
	    			$this->redirectService->withMessage('success', 'Email sent', $this->url->get('clients/view/'.$client_id));
	    			return;
	    		}
	    		
	    		$this->redirectService->withMessage('error', 'Error sending email', $this->url->get('clients/view/'.$client_id));
				return;
    		break;
    	}

    	$this->redirectService->withMessage('success', 'Message', $this->url->get('clients/view/'.$client_id));
		return;
    }

    private function messagesArray($messages)
    {
    	$msgs_arr = [];

    	foreach($messages as $msg)
    	{
    		$msgs_arr[] = ['field' => 'server error', 'message' => $msg->getMessage()];
    	}

    	return $msgs_arr;
    }

    public function activate_userAction($user_id){
        $user_id= (int)$user_id;
        $user = UsersMobile::findFirst(["ID={$user_id}"]);
        $user->Active=1;
        $user->save();
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }
}