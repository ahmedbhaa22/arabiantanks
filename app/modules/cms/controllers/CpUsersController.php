<?php

namespace Vokuro\Cms\Controllers;

use Models\TanksBranchesEmployees;
use Models\TanksCities;
use Models\TanksRegions;
use Vokuro\Cms\Services\BranchesService;
use Vokuro\Controllers\ControllerBase;

use DataTables\DataTable;

use Models\UsersMobile;

use Phalcon\Tag;

use Vokuro\Models\Profiles;

use Vokuro\Models\UserInformation;

use Vokuro\Models\UsersRules;
use Vokuro\Models\UsersUsersRules;
use Vokuro\Pentavalue\RequestValidation;
use Vokuro\Pentavalue\FileUploadService;
use Vokuro\UsersModule\Models\UserData;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Models\CompanyBranches;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;

class CpUsersController extends ControllerBase
{

    public function initialize()
    {
        parent::initialize();
        $this->redirectService->setControllerObj($this);
    }

    public function indexAction()
    {


    }


    public function editAction($User_ID)
    {
        $user_edit = UsersMobile::findFirst(["ID={$User_ID}"]);
        $access = $this->checkAccess('edit', $user_edit);
        $query = $this->modelsManager->createQuery("

        SELECT u.*, p.* FROM Models\UsersMobile u, \CpUserProfile p WHERE u.ID = {$User_ID}

        ");

        $profiles = Profiles::find();

        $user = \CpUserProfile::findFirst(array("

            User_ID={$User_ID}

        "));

        if (count($user) == 0) {

            die();

        }


        $this->tag->setDefault("User_ID", $user->User_ID);

        $this->view->user = $user;

        $this->view->profiles = $profiles;


    }

    public function newAction()
    {

        $access = $this->checkAccess('add');
        $rules = UsersRules::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        $is_admin = $this->session->get('auth-identity')['is_admin'];
        $this->view->is_admin = $is_admin;
        $this->view->rules = $rules;


    }

    public function createAction()
    {

        if (!$this->request->isPost()) {

            $this->dispatcher->forward([

                'controller' => "cp_users",

                'action' => 'index'

            ]);

            return;

        }
        //check rules
//        $user_rules = [];
//        $rules = UsersRules::find(["application_id={$this->session->get('auth-identity')['Application_ID']}"]);
//        foreach ($rules as $rule) {
//            if (isset($_POST["rule{$rule->id}"])) {
//                $user_rules[$rule->name] = $rule->id;
//            }
//        }

//        if ($this->security->checkToken()) {
//            die('ok');
//        }else{
//            die('not ok');
//        }
        if (!isset($_POST['rule']) && !isset($_POST['super_admin'])) {
            $this->flashSession->error("You Must Select A User Role");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }

        $Title = $this->request->getPost("Title");

        $User = $this->request->getPost("User");

        $Profile = 1;

        $Email = $this->request->getPost("Email");
        //Check if E-Mail is existed in the same app
        $user = UsersMobile::findFirst(["Application_ID={$this->session->get('auth-identity')['Application_ID']} AND Mail ='{$Email}'"]);
        if ($user) {
            $this->flashSession->error("E-Mail Exists With another account in this application");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        //Check if User is existed in the same app
        $user = UsersMobile::findFirst(["Application_ID={$this->session->get('auth-identity')['Application_ID']} AND User ='{$User}'"]);
        if ($user) {
            $this->flashSession->error("UserName Exists With another account in this application");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }

        $Pass = $this->security->hash($this->request->getPost('Pass'));

        $super_admin = 0;
        if (isset($_POST['super_admin']) && $this->session->get('auth-identity')['is_admin'] == 1) {
            $super_admin = 1;
        }
		
			
		
        //get permessions

        $user = new UsersMobile([

            'Title' => $this->request->getPost('Title'),

            'User' => $this->request->getPost('User'),

            'Mail' => $this->request->getPost("Email"),

            'Pass' => $this->security->hash($this->request->getPost('Pass')),

            'Img' => 'user_img/noprofile.jpg',

            'Access_Token' => "",

            'Social_Avatar' => "",

            'Login_Type' => "web",

            'Social_ID' => "",

            'Social_Type' => '',

            'Join_Date' => time(),

            'Application_ID' => $this->session->get('auth-identity')['Application_ID'],

            'Module_ID' => 20002,
            'is_admin' => $super_admin,

        ]);

//        \Phalcon\Mvc\Model::setup(array(checkUserByMail

//            'notNullValidations' => false

//        ));


        if ($user->save() == false) {

            $this->flashSession->error("حدث خطأ، يجب مراجعة البيانات المدخلة");

            $messages = $user->getMessages();

            foreach ($messages as $message) {

                $this->flashSession->error($message);

            }

            return $this->response->redirect($_SERVER['HTTP_REFERER']);


        } else {

            $profiles = new \CpUserProfile();

            $profiles->User_ID = $user->ID;

            $profiles->Profile_ID = $Profile;

            if (!$profiles->save()) {

                $this->flashSession->error('Error Profile:' . $user->getMessages());

            } else {

                $this->flashSession->success("User was created successfully");
                //create permissions
                if (!isset($_POST['super_admin'])) {
                    $users_users_rules = new UsersUsersRules();
                    $users_users_rules->rule_id = $_POST['rule'];
                    $users_users_rules->user_id = $user->ID;
                    $users_users_rules->save();
                }
                return $this->response->redirect("cp_users/new");
//                foreach ($user_rules as $rule_user){
//                    $users_users_rules= new UsersUsersRules();
//                    $users_users_rules->rule_id = $rule_user;
//                    $users_users_rules->user_id = $user->ID;
//                    $users_users_rules->save();
//                }

            }


        }


    }

    public function saveAction()
    {

        if (!$this->request->isPost()) {

            $this->dispatcher->forward([

                'controller' => "cp_users",

                'action' => 'index'

            ]);


            return;

        }

        $User_ID = $this->request->getPost("User_ID");

        $Profile_ID = 1;

        $Title = $this->request->getPost("Title");

        $Profile = \CpUserProfile::findFirst(array("User_ID ={$User_ID}"));

        $Profile->Profile_ID = $Profile_ID;

        $User = UsersMobile::findFirst(array("ID ={$User_ID}"));

        $User->Title = $Title;

        $Profile->save();

        $User->save();

        $this->flash->success("تم التعديل بنجاح");

    }


    public function storeAction()

    {

        $this->view->disable();

        // check if request is post

        if ($this->request->isPost()) {

            //Content ID

            //$this->request->getPost("Content_ID"));

            // save form

            $data = $this->request->getPost();


            // save form

            // die(var_dump($_FILES));

            $user = new UsersMobile;

            $user->Title = $this->request->getPost('name');

            $user->User = $this->request->getPost('user_name');

            $user->Mail = $this->request->getPost('email');

            $user->Pass = $this->security->hash($this->request->getPost('password'));

            $user->Application_ID = 512;

            $user->Module_ID = 512;

            $user->create();


            //store image

            if ($this->request->hasFiles() == true) {

                $uploads = $this->request->getUploadedFiles();


                // #do a loop to handle each file individually

                foreach ($uploads as $file) {


                    $path = 'uploads/users/' . md5(uniqid(rand(), true)) . '-' . strtolower($file->getname());


                    $isUploaded = FileManager::moveFile($path, $file);


                    if ($isUploaded) {

                        $user->Img = $path;

                        $user->save();

                    }

                }

            }


            $info = new UserInformation;

            $info->user_id = $user->ID;

            $info->job = $this->request->getPost('job');

            $info->mobile = $this->request->getPost('mobile');

            $info->address = $this->request->getPost('address');

            $info->source = $this->request->getPost('source');

            $info->notes = $this->request->getPost('notes');

            $info->latitude = $this->request->getPost('latitude');

            $info->longitude = $this->request->getPost('longitude');

            $info->save();


            // return response

            $this->sendJson($user, 201);

        }

    }


    public function updateAction($id)

    {

        $this->view->disable();

        // check if request is post

        $user = UsersMobile::findFirst($id);

        if ($this->request->isPost()) {

            //Content ID

            //$this->request->getPost("Content_ID"));

            // save form

            $data = $this->request->getPost();


            // save form

            // die(var_dump($_FILES));

            $user->Title = $this->request->getPost('name');

            $user->User = $this->request->getPost('user_name');

            $user->Mail = $this->request->getPost('email');

            $user->Application_ID = 512;

            $user->Module_ID = 512;

            $user->create();


            //store image

            if ($this->request->hasFiles() == true) {

                FileManager::delete($user->Img);

                $uploads = $this->request->getUploadedFiles();


                // #do a loop to handle each file individually

                foreach ($uploads as $file) {


                    $path = 'uploads/users/' . md5(uniqid(rand(), true)) . '-' . strtolower($file->getname());


                    $isUploaded = FileManager::moveFile($path, $file);


                    if ($isUploaded) {

                        $user->Img = $path;

                        $user->save();

                    }

                }

            }


            $info = $user->information;

            $info->job = $this->request->getPost('job');

            $info->mobile = $this->request->getPost('mobile');

            $info->address = $this->request->getPost('address');

            $info->source = $this->request->getPost('source');

            $info->notes = $this->request->getPost('notes');

            $info->latitude = $this->request->getPost('latitude');

            $info->longitude = $this->request->getPost('longitude');

            $info->save();


            // return response

            $this->sendJson($user, 201);

        }

    }


    public function langAction()
    {

        $user_id = $this->session->get('auth-identity')['id'];

        $lang = $this->request->getQuery('lang');

        $cp_profile = \CpUserProfile::findFirst(array("User_ID={$user_id}"));

        $cp_profile->Cp_Lang = $lang;

        $cp_profile->save();

        $user = UsersMobile::findFirstByID($user_id);

        $this->session->set('auth-identity', [

            'id' => $user->ID,

            'name' => $user->Title,

            'profile' => $user->CpUserProfile->Profiles->name,

            'Application_ID' => $user->Application_ID,

            'Lang' => $user->CpUserProfile->Cp_Lang,

            'Scheme' => $user->CpUserProfile->Scheme_File,

        ]);


        return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }


    public function schemeAction()
    {

        $user_id = $this->session->get('auth-identity')['id'];

        $scheme = $this->request->getQuery('scheme');

        if (in_array($this->request->getQuery('scheme'), $this->schemes)) {

            $cp_profile = \CpUserProfile::findFirst(array("User_ID={$user_id}"));

            $cp_profile->Scheme_File = $scheme;

            $cp_profile->save();

            $user = UsersMobile::findFirstByID($user_id);

            $this->session->set('auth-identity', [

                'id' => $user->ID,

                'name' => $user->Title,

                'profile' => $user->CpUserProfile->Profiles->name,

                'Application_ID' => $user->Application_ID,

                'Lang' => $user->CpUserProfile->Cp_Lang,

                'Scheme' => $user->CpUserProfile->Scheme_File,

            ]);


            return $this->response->redirect($_SERVER['HTTP_REFERER']);

        } else {

            die("Get Out");

        }

    }


    public function ajaxContentAction()
    {
        //if ($this->request->isAjax()) {
        $this->view->disable();
        $sql = "select profile.*,users.*, users.ID as u_id from cp_user_profile as profile INNER JOIN users ON users.ID=profile.User_ID
         WHERE users.application_id=" . $this->session->get('auth-identity')['Application_ID'];
        //}
        $access = $this->checkAccess('index');
        if ($access === "only") {
            $sql .= " AND users.id={$this->session->get('auth-identity')['id']}";

        }

        $result_set = $this->db->query($sql);
        $result_set->setFetchMode(\Phalcon\Db::FETCH_ASSOC);
        $result_set = $result_set->fetchAll($result_set);
        foreach ($result_set as $k => $v) {
            $result_set[$k]["join_date"] = date('m/d/Y', $v["join_date"]);
            $result_set[$k]["time_date"] = date('H:i:s', $v["join_date"]);

        }
        $dataTables = new DataTable();
        // die(print_R( $array ));
        $dataTables->fromArray($result_set)->sendResponse();
        // }

    }

    public function ajaxDeleteAction()
    {
        $this->view->disable();
        if ($this->request->isAjax()) {
            //die(var_dump($_POST['deleteCheckbox']));
            if (isset($_POST['checkboxes'])) {
                foreach ($_POST['checkboxes'] as $ID) {
                    $this->deleteAction($ID);
                }
                return "1";
            } else {
                return "0";
            }

        }

    }

    public function deleteAction($User_ID)
    {

        $user_edit = UsersMobile::findFirst(["ID={$User_ID}"]);
        //cannot delete himself
        if ($user_edit->ID == $this->session->get('auth-identity')['id']) {
            return;
        }
        $this->checkAccess('delete', $user_edit);
        $profile = \CpUserProfile::findFirst(array("User_ID={$User_ID}"));
        if ($profile->delete()) {
            $user = UsersMobile::findFirst(array("ID={$User_ID}"));
            $user->delete();
            return;
        }
    }

    public function ajaxActiveAction()
    {
        $this->view->disable();
        if ($this->request->isAjax()) {
            if (isset($_POST['checkboxes'])) {
                foreach ($this->request->getPost("checkboxes") as $ID) {
                    $content = UsersMobile::findFirst(array("ID={$ID}"));
                    $content->Active = 1;
                    $content->save();
                }
                return "1";
            } else {
                return "0";
            }

        }

    }

    public function ajaxDeactiveAction()
    {
        $this->view->disable();

        if ($this->request->isAjax()) {
            if (isset($_POST['checkboxes'])) {
                foreach ($this->request->getPost("checkboxes") as $ID) {
                    $content = UsersMobile::findFirst(array("ID={$ID}"));
                    $content->Active = 0;
                    $content->save();
                }
                return "1";
            } else {
                return "0";
            }

        }

    }


    public function profileAction()
    {
        $user = UsersMobile::findFirst([
            'ID = :id:',
            'bind' => [
                'id' => $this->session->get('auth-identity')['id']
            ]
        ]);

        $this->view->user     = $user;
        $this->view->regions  = GeoCities::find();
        $this->view->cities   = GeoRegions::find();
        $this->view->branches = CompanyBranches::find();
        $this->view->rules    = UsersRules::find();

    }

    public function getRegionCitiesAndBranchesAction($region_id)
    {
        $cities = TanksCities::find([
            'region_id = :region_id:',
            'bind' => [
                'region_id' => $region_id
            ]
        ])->toArray();

        $branches = CompanyBranches::find([
            'region_id = :region_id:',
            'bind' => [
                'region_id' => $region_id
            ]
        ])->toArray();

        return json_encode([
            'cities'   => $cities,
            'branches' => $branches
        ]);
    }

    public function changePassAction()
    {

        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);


    }

    public function changePassPostAction()
    {

        if (!$this->request->isPost()) {

            die();

        }

        $user = UsersMobile::findFirst(["ID=" . $this->session->get('auth-identity')['id']]);

        $old_pass = $this->request->get("current");

        $new_pass = $this->request->get("password");

        $confirm_pass = $this->request->get("repassword");

        if (!$this->security->checkHash($old_pass, $user->Pass)) {

            $this->flashSession->error("Check Your Old Password");

            return $this->response->redirect("cp_users/profile");

        }

        if (strlen($new_pass) < 8) {

            $this->flashSession->error("Password Must Be At Least 8 Characters");

            return $this->response->redirect("cp_users/profile");

        }

        if ($new_pass !== $confirm_pass) {

            $this->flashSession->error("Check that the new password are the same as the confirmation password");

            return $this->response->redirect("cp_users/profile");


        }

        $user->Pass = $this->security->hash($new_pass);

        if (!$user->save()) {

            $this->flashSession->error(print_r($user->getMessages()));

            return $this->response->redirect("cp_users/profile");

        }


        $this->flashSession->success("Password Has been changed sucessfully");

        return $this->response->redirect("cp_users/profile");

    }

    public function checkAccess($action, $user = NULL)
    {
        $user_id = $this->session->get('auth-identity')['id'];
        $is_admin = $this->session->get('auth-identity')['is_admin'];
        $rules = $this->session->get('auth-identity')['rules'];
        if ($is_admin) {
            return true;
        }
        $check_access = false;
        if ($action == 'add') {
            $permissions = ['sub_admin'];
            $intersection = array_intersect($permissions, $rules);

            if (!empty($intersection)) {
                $check_access = true;
            }
        } else if ($action == 'edit') {
            if (in_array('sales', $rules) || in_array('client', $rules)) {
                if ($user->ID == $user_id) {
                    $check_access = true;
                }
            } else {
                $permissions = ['sub_admin', 'data_entry'];
                $intersection = array_intersect($permissions, $rules);
                if (!empty($intersection)) {
                    $check_access = true;
                }
            }
        } else if ($action == 'delete') {

            if (in_array('sales', $rules) || in_array('client', $rules)) {
                if ($user->ID == $user_id) {
                    $check_access = true;
                }
            } else {
                $permissions = ['sub_admin', 'data_entry'];
                $intersection = array_intersect($permissions, $rules);
                if (!empty($intersection)) {
                    $check_access = true;
                }
            }
        } else if ($action == 'index') {
            if (in_array('sales', $rules) || in_array('client', $rules) || in_array('data_entry', $rules)) {
                //if($content->User_ID == $user_id) {
                $check_access = 'only';
                // }
            } else {
                $permissions = ['sub_admin', 'data_entry'];
                $intersection = array_intersect($permissions, $rules);
                if (!empty($intersection)) {
                    $check_access = true;
                }
            }
        }
        if ($check_access == false) {
            return $this->response->redirect("index/noaccess");
        }
        return $check_access;
    }


    public function saveUserAction()
    {
        // var_dump($this->request->getPost());die;
        if(!$this->request->isPost())
        {
            $this->redirectService->withMessage('error', 'Invalid Request',
                $this->url->get('cp_users/usersList'));
            return;
        }

        $validator = new RequestValidation($this->request);

        $validator->required([
            'name', 'email', 'mobile', 'region_id',
            'city_id', 'branch_id', 'rule_id',
            'password', 'confirm_password', 'username', 'allowed_branches'
            ]);
        $validator->email(['email']);
        $validator->stringLength('password', 8, 20);
        $validator->stringLength('mobile', 10, 10);
        $validator->stringLength('mobile2', 10, 10);
        $validator->passwordConfirm('password', 'confirm_password');

        $validation_result = $validator->validate();

        if(count($validation_result))
        {
            $this->session->set('error_msgs', $validation_result);
            return $this->response->redirect($this->url->get('cp_users/usersList'));
        }

        $name      = $this->request->getPost('name');
        $email     = $this->request->getPost('email');
        $mobile    = $this->request->getPost('mobile');
        $region_id = $this->request->getPost('region_id');
        $city_id   = $this->request->getPost('city_id');
        $branch_id = $this->request->getPost('branch_id');
        $rule_id   = $this->request->getPost('rule_id');
        $password  = $this->request->getPost('password');
        $user_name = $this->request->getPost('username');

        // handle uploading images if exists
        $upload_file_service = new FileUploadService('uploads/users');
        $uploaded_file_path = '';

        $upload_file_result = $upload_file_service->upload($this->request);

        if(count($upload_file_result) > 0)
        {
            $uploaded_file_path = $upload_file_result[0];
        }

        $user = new UsersMobile;

        $user->Application_ID = 1;
        $user->Module_ID      = 1;
        $user->Title          = $name;
        $user->Mail           = $email;
        $user->Mobile         = $mobile;
        $user->Pass           = $this->security->hash($password);
        $user->User           = $user_name;
        $user->Join_Date           = time();
        if(strlen($uploaded_file_path) > 0)
        {
            $user->Img = $uploaded_file_path;
        }

        if(!$user->save())
        {
            $this->session->set('error_msgs', $this->messagesArray($user->getMessages()));
            return $this->response->redirect($this->url->get('cp_users/usersList'));
        }
        //To Make User Access the cp panel

        $profiles = new \CpUserProfile();

        $profiles->User_ID = $user->ID;

        $profiles->Profile_ID = 1;

        if (!$profiles->save()) {

            $this->flashSession->error('Error Profile:' . $user->getMessages());

        }
        ///
        $user_data = new UserData;

        $user_data->user_id   = $user->ID;
        $user_data->region_id = $region_id;
        $user_data->city_id   = $city_id;
        $user_data->branch_id = $branch_id;

        $user_data_save = $user_data->save();

        $user_rel_rules = new UsersUsersRules;

        $user_rel_rules->user_id = $user->ID;
        $user_rel_rules->rule_id = $rule_id;

        $user_rule_save = $user_rel_rules->save();

        if(!$user_data_save)
        {
            $this->session->set('error_msgs', $this->messagesArray($user_data->getMessages()));
            return $this->response->redirect($this->url->get('cp_users/usersList'));
        }

        if(!$user_rule_save)
        {
            $this->session->set('error_msgs', $this->messagesArray($user_rel_rules->getMessages()));
            return $this->response->redirect($this->url->get('cp_users/usersList'));
        }

        //Allowed Branches

        foreach ($this->request->getPost("allowed_branches") as $allowed_branch){
            $user_allowed_branch = new TanksBranchesEmployees();
            $user_allowed_branch->user_id = $user->ID;
            $user_allowed_branch->branch_id= $allowed_branch;
            if(!$user_allowed_branch->save()){
                $this->session->set('error_msgs', $this->messagesArray($user_allowed_branch->getMessages()));
            }


        }

        $this->redirectService->withMessage('success', 'تم إنشاء المستخدم بنجاح', 
            $this->url->get('cp_users/usersList'));
        return;
    }

    public function editProfileAction()
    {
        if(!$this->request->isPost())
        {
            $this->redirectService->withMessage('error', 'Invalid Request',
                $this->url->get('users_application_module'));
            return;
        }

        $from_action = $this->request->getPost('from_action');

        $user_id   = $this->request->getPost('user_id');

        $user = UsersMobile::findFirst([
            'ID = :id:',
            'bind' => [
                'id' => $user_id
                ]
            ]);

        if(!$user)
        {
            if($from_action == 'users_list')
            {
                $this->redirectService->withMessage('error', 'Invalid user', 
                $this->url->get('cp_users/usersList'));
                return;
            }
            elseif($from_action == 'user_view')
            {
                $this->redirectService->withMessage('error', 'Invalid user', 
                $this->url->get('cp_users/viewUser/'.$user_id));
                return;
            }
            
            $this->redirectService->withMessage('error', 'Invalid user', 
                $this->url->get('cp_users/profile'));
            return;
        }

        $validator = new RequestValidation($this->request);

        $validator->required(
            ['name', 'email', 'region_id', 'city_id', 'branch_id', 'rule_id', 'mobile']);
        $validator->email(['email']);

        if($this->request->getPost('new_password') != null && strlen($this->request->getPost('new_password')) > 0)
        {
            $validator->required(['old_password']);
            $validator->stringLength('new_password', 8, 20);
        }

        $validation_result = $validator->validate();

        if(count($validation_result))
        {
            if($from_action == 'users_list')
            {
                $this->session->set('error_msgs', $validation_result);
                return $this->response->redirect($this->url->get('cp_users/usersList'));
            }
            elseif($from_action == 'user_view')
            {
                $this->session->set('error_msgs', $validation_result);
                return $this->response->redirect($this->url->get('cp_users/viewUser/'.$user_id));
            }

            $this->session->set('error_msgs', $validation_result);
            return $this->response->redirect($this->url->get('cp_users/profile'));
        }

        $name      = $this->request->getPost('name');
        $email     = $this->request->getPost('email');
        $region_id = $this->request->getPost('region_id');
        $city_id   = $this->request->getPost('city_id');
        $branch_id = $this->request->getPost('branch_id');
        $rule_id   = $this->request->getPost('rule_id');
        $mobile    = $this->request->getPost('mobile');
        $mobile2   = $this->request->getPost('mobile2');
        $old_password  = $this->request->getPost('old_password');
        $new_password  = $this->request->getPost('new_password');

        if(isset($old_password) && isset($new_password) && strlen($old_password) >0 && strlen($new_password) > 0)
        {
            if(!$this->security->checkHash($old_password, $user->Pass))
            {
                if($from_action == 'users_list')
                {
                    $this->redirectService->withMessage('error', 'كلمة المرور غير صحيحة', 
                    $this->url->get('cp_users/usersList'));
                    return;
                }
                elseif($from_action == 'user_view')
                {
                   $this->redirectService->withMessage('error', 'كلمة المرور غير صحيحة', 
                    $this->url->get('cp_users/viewUser/'.$user_id));
                    return; 
                }

                $this->redirectService->withMessage('error', 'كلمة المرور غير صحيحة', 
                    $this->url->get('cp_users/profile'));
                return;
            }

            $user->Pass   = $this->security->hash($new_password);
        }

        $upload_file_service = new FileUploadService('uploads/users');
        $uploaded_file_path = '';

        $upload_file_result = $upload_file_service->upload($this->request);

        if(count($upload_file_result) > 0)
        {
            $uploaded_file_path = $upload_file_result[0];
        }

        $user->Title  = $name;
        $user->Mail   = $email;
        $user->Mobile = $mobile;

        if(strlen($uploaded_file_path) > 0)
        {
            $user->Img = $uploaded_file_path;
        }

        if(!$user->save())
        {
            if($from_action == 'users_list')
            {
                $this->session->set('error_msgs', $this->messagesArray($user->getMessages()));
                return $this->response->redirect($this->url->get('cp_users/usersList'));
            }
            elseif($from_action == 'user_view')
            {
                $this->session->set('error_msgs', $this->messagesArray($user->getMessages()));
                return $this->response->redirect($this->url->get('cp_users/viewUser/'.$user_id));
            }

            $this->session->set('error_msgs', $this->messagesArray($user->getMessages()));
            return $this->response->redirect($this->url->get('cp_users/profile'));
        }

        $user_data = UserData::findFirst([
                'user_id = :user_id:',
                'bind' => [
                    'user_id' => $user_id
                ]
            ]);

        if(!$user_data)
        {
            $user_data = new UserData;
        }

        $user_data->user_id   = $user_id;
        $user_data->city_id   = $city_id;
        $user_data->region_id = $region_id;
        $user_data->branch_id = $branch_id;

        $user_rule = UsersUsersRules::findFirst([
                'user_id = :user_id:',
                'bind' => [
                    'user_id' => $user_id
                ]
            ]);

        if(!$user_rule)
        {
            $user_rule = new UsersUsersRules;
        }

        $user_rule->user_id = $user_id;
        $user_rule->rule_id = $rule_id;

        $user_data_save = $user_data->save();
        $user_rule_save = $user_rule->save();

        if(!$user_data_save)
        {
            if($from_action == 'users_list')
            {
            $this->session->set('error_msgs', $this->messagesArray($user_data->getMessages()));
            return $this->response->redirect($this->url->get('cp_users/usersList'));
            }
            elseif($from_action == 'user_view')
            {
                $this->session->set('error_msgs', $this->messagesArray($user_data->getMessages()));
                return $this->response->redirect($this->url->get('cp_users/viewUser/'.$user_id));
            }

            $this->session->set('error_msgs', $this->messagesArray($user_data->getMessages()));
            return $this->response->redirect($this->url->get('cp_users/profile'));
        }

        if(!$user_rule_save)
        {
            if($from_action == 'users_list')
            {
                $this->session->set('error_msgs', $this->messagesArray($user_rule->getMessages()));
                return $this->response->redirect($this->url->get('cp_users/usersList'));
            }
            elseif($from_action == 'user_view')
            {
                $this->session->set('error_msgs', $this->messagesArray($user_rule->getMessages()));
                return $this->response->redirect($this->url->get('cp_users/viewUser/'.$user_id));
            }

            $this->session->set('error_msgs', $this->messagesArray($user_rule->getMessages()));
            return $this->response->redirect($this->url->get('cp_users/profile'));
        }

        if($from_action == 'users_list')
        {
             $this->redirectService->withMessage('success', 'تم تعديل بيانات المستخدم بنجاح', 
            $this->url->get('cp_users/usersList'));
            return;
        }
        elseif($from_action == 'user_view')
        {
            $this->redirectService->withMessage('success', 'تم تعديل بيانات المستخدم بنجاح', 
            $this->url->get('cp_users/viewUser/'.$user_id));
            return;
        }

        $this->redirectService->withMessage('success', 'تم تعديل بيانات المستخدم بنجاح', 
            $this->url->get('cp_users/profile'));
        return;
    }

    public function usersListAction($page=1)
    {
        $page = ($this->request->get('page') == null)?1:$this->request->get('page');

        $users_builder = $this->modelsManager->createBuilder()
        ->from(UsersMobile::class)->where('category_id is null')->orderBy("Models\UsersMobile.ID DESC");

        $paginator = new PaginatorQueryBuilder([
            "builder" => $users_builder,
            "limit"   => 20,
            "page"    => $page
            ]);

        $this->view->page = $paginator->getPaginate();
        $this->view->regions = TanksRegions::find();
        $this->view->cities  = TanksCities::find();
        $this->view->branches = CompanyBranches::find();
        $this->view->rules = UsersRules::find();
    }

    public function deleteSystemUserAction($User_ID)
    {

        $user_edit = UsersMobile::findFirst(["ID={$User_ID}"]);
        //cannot delete himself
        if ($user_edit->ID == $this->session->get('auth-identity')['id']) {
            return json_encode(['status'=>0, 'msg'=>'ليس لديك صلاحية حذف هذا المستخدم']);
        }
        $this->checkAccess('delete', $user_edit);
        $profile = \CpUserProfile::findFirst(array("User_ID={$User_ID}"));
        
        if($profile){
            $profile->delete();
        }

        $user = UsersMobile::findFirst(array("ID={$User_ID}"));
        
        if(!$user->delete())
        {
            return json_encode(['status'=>0, 'msg'=>'خطأ أثناء الحذف، حاول مرة أخرى']);
        }

        return json_encode(['status'=>1, 'msg'=>'تم الحذف بنجاح']);
    }

    public function viewUserAction($user_id)
    {
        $user = UsersMobile::findFirst([
                'ID = :id: and category_id is null',
                'bind' => [
                    'id' => $user_id
                ]
            ]);

        if(!$user)
        {
            $this->redirectService->withMessage('error', 'Invalid user', 
                $this->url->get('cp_users/usersList'));
            return;
        }

        $this->view->regions = GeoRegions::find();
        $this->view->cities  = GeoCities::find();
        $this->view->branches = CompanyBranches::find();
        $this->view->rules = UsersRules::find();
        $this->view->user = $user;
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

    public function getBranchesListAction($region){
       $branch = $this->TanksBranches->getBranch();
        echo "";

    }
}