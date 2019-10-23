<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 7/8/2018
 * Time: 9:40 PM
 */

namespace Vokuro\SalesVisits\Controllers;
use Models\TanksBranchesEmployees;
use Models\TanksRegions;
use Models\UserCategories;
use Models\UsersMobile;
use Vokuro\Cms\Services\ClientCatsService;
use Vokuro\Controllers\ControllerBase;
use Vokuro\Geo\Models\GeoContinents;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\SalesVisits\Models\TanksSalesRepsClients;
use Vokuro\SalesVisits\Requests\Clients;
use Vokuro\UsersModule\Models\UserAddresses;
use Vokuro\UsersModule\Models\UserData;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;

class ClientsController extends ControllerBase
{
    public function newAction(){
        $this->view->regions = TanksRegions::find();
        $client_cats_service = new ClientCatsService();
        $this->view->client_categories = $client_cats_service->getAllClientCats();
    }

    public function saveAction(){
        if(!$this->request->isPost()){
            die;
        }
        $name               = $this->request->getPost('name');
        $email              = $this->request->getPost('email');
        $category_id        = $this->request->getPost('client_cat');
        $mobile             = $this->request->getPost('mobile');
        $password           = 12345;
        $confirm_password   = 12345;
        $region_id          = $this->request->getPost('region');

//        if(!$email || $email==""){
//            $random = new \Phalcon\Security\Random();
//            $email= "No_EMAIL_{$random->base64Safe(8)}@arabiatanks.com";
//            $email= "NoEmail";
//        }
        if(strlen($mobile)!=10){
            $this->flashSession->error("رقم التليفون يكون 10 أرقام - Telephone Number Must be 10 Numbers");

            return $this->response->redirect($this->url_shared->get('sales_visits_module/clients/new'));
        }
//        if(UsersMobile::emailExists($email))
//        {
//            $error_msg['field'] = 'email';
//            $error_msg['message'] = 'تم التسجيل بهذا البريد الالكتروني من قبل';
//
//            $this->flashSession->error("Email Exists");
//
//            return $this->response->redirect($this->url_shared->get('sales_visits_module/clients/new'));
//
//        }
        if(UsersMobile::mobileExists($mobile))
        {
            $error_msg['field'] = 'mobile';
            $error_msg['message'] = 'تم التسجيل بهذا التليفون من قبل';

            $this->flashSession->error("الموبايل موجود");

            return $this->response->redirect($this->url_shared->get('sales_visits_module/clients/new'));

        }
        $client = new UsersMobile;
        $client->Title          = $name;
        $client->Mail           = $email;
        $client->category_id    = $category_id;
        $client->Mobile         = $mobile;
        $client->Pass           = (isset($password) && strlen($password) > 0)?$this->security->hash($password):$client->Pass;
        $client->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $client->Active         = 1;
        $client->Module_ID         = 20002;
        $client->created_by         = $this->session->get('auth-identity')['id'];;
        if(!$client->save())
        {
            foreach ($client->getMessages() as $error){
                $this->flashSession->error($error);
            }
            return $this->response->redirect($this->url_shared->get('sales_visits_module/clients/new'));
        }
        $gender = 1;
        $birthdate="10/12/1987";
        $user_data = new UserData();
        $user_data->user_id   = $client->ID;
        $user_data->gender_id = $gender;
        $user_data->birthdate = strtotime($birthdate);
        $user_data->region_id = (isset($region_id) && strlen($region_id)>0)?$region_id:null;
        $user_data->city_id   = (isset($city_id) && strlen($city_id)>0)?$city_id:null;
        $user_data->supervisor_comment = "";
        $user_data->branch_id          = (isset($branch_id)&&strlen($branch_id)>0)?$branch_id:null;
        $user_data->company_name       = "";
        $user_data->postal_code        = "";
        if(!$user_data->save())
        {
            foreach ($user_data->getMessages() as $error){
                $this->flashSession->error($error);
            }
            return $this->response->redirect($this->url_shared->get('sales_visits_module/clients/new'));
        }

        $address=[];
        $client_address = new UserAddresses();

        $client_address->user_id     = $client->ID;
        $client_address->city_id     = (isset($address['city'])&&strlen($address['city'])>0)?$address['city']:null;
        $client_address->region_id   = (isset($address['region'])&&strlen($address['region'])>0)?$address['region']:null;
        $client_address->details     = (isset($address['details']) && strlen($address['details']) > 0)?$address['details']:'no address';
        $client_address->postal_code = 0000;
        $client_address->is_main     = (isset($address['is_main']))?1:0;
        if(!$client_address->save())
        {
            foreach ($client_address->getMessages() as $error){
                $this->flashSession->error($error);
            }
            return $this->response->redirect($this->url_shared->get('sales_visits_module/clients/new'));
        }
        $this->flashSession->success("تمت اضافة عميل جديد بنجاح");

        //Assign the created client to the sales person
        $logged_in_sales_rep = $this->session->get('auth-identity')['id'];
        $sales_rep_client = new TanksSalesRepsClients();
        $sales_rep_client->client_id=$client->ID;
        $sales_rep_client->sales_rep_id=$logged_in_sales_rep;
        $sales_rep_client->save();
        return $this->response->redirect($this->url_shared->get("sales_visits_module/sales_visits/index"));

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

        $countries = GeoContinents::find();

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
        $logged_in_sales_rep = $this->session->get('auth-identity')['id'];
        $builder = $this->modelsManager->createBuilder()->from(UsersMobile::class)
            ->innerJoin("Vokuro\SalesVisits\Models\TanksSalesRepsClients","Models\UsersMobile.ID = Vokuro\SalesVisits\Models\TanksSalesRepsClients.client_id");
        $user_branch_id=$this->session->get('auth-identity')['user_info']["branch"];
        $user_rules = $this->session->get('auth-identity')["rules"];

        if(array_key_exists(8,$user_rules)){
            //Get All Sales Persons in Branch
            $employees[]=$logged_in_sales_rep;
            $branch_employees= TanksBranchesEmployees::find(["branch_id={$user_branch_id}"]);
            foreach ($branch_employees as $employee){
               $employees[] =  $employee->user_id;
            }
            $builder->inWhere("Vokuro\SalesVisits\Models\TanksSalesRepsClients.sales_rep_id",$employees);
        }
        else{
            $builder ->andWhere("Vokuro\SalesVisits\Models\TanksSalesRepsClients.sales_rep_id = {$logged_in_sales_rep}");

        }




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
            $builder->andWhere('Models\UsersMobile.category_id = :cat_id:',[
                'cat_id' => $cat_id
            ]);
        }
        else
        {
            $builder->andWhere('Models\UsersMobile.category_id is not null');
        }

        if(isset($client_name) && strlen($client_name) > 0)
        {
            $builder->andWhere('Models\UsersMobile.Title like :client_name:', [
                'client_name' => '%'.$client_name.'%'
            ]);
        }

        if(isset($email) && strlen($email) > 0)
        {
            $builder->andWhere('Models\UsersMobile.Mail = :email:', [
                'email' => $email
            ]);
        }

        if(isset($mobile) && strlen($mobile) > 0)
        {
            $builder->andWhere('Models\UsersMobile.Mobile like :mobile:', [
                'mobile' => '%'.$mobile.'%'
            ]);
        }

        if($is_active == 'true' && $not_active == 'false')
        {
            $builder->andWhere('Models\UsersMobile.Active = :active:',['active'=>1]);
        }
        elseif($is_active == 'false' && $not_active == 'true')
        {
            $builder->andWhere('Models\UsersMobile.Active = :not_active:', ['not_active'=>0]);
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


        //$builder->inWhere('Models\UsersMobile.ID', $users_ids);

        return $builder;
    }
}