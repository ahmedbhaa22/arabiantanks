<?php

namespace Vokuro\Cms\Controllers;

use Models\GeneralNotifications;
use Vokuro\Controllers\ControllerBase;

use DataTables\DataTable;
use Models\UsersMobile;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Vokuro\Models\Logs;

class MobileUsersController extends ControllerBase
{
    public function indexAction(){

    }

    public function editAction($ID)
    {
        if (!$this->request->isPost()) {

            $content = UsersMobile::findFirstByID($ID);
            if (!$content) {
                $this->flash->error("content was not found");

                $this->dispatcher->forward([
                    'controller' => "mobile_users",
                    'action' => 'index'
                ]);

                return;
            }

            $this->view->ID = $content->ID;
            $this->tag->setDefault("Title", $content->Title);
            $this->tag->setDefault("Active", $content->Active);
            $this->tag->setDefault("Mail", $content->Mail);
            $this->tag->setDefault("ID", $content->ID);


        }
    }

    public function saveAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "mobile_users",
                'action' => 'index'
            ]);

            return;
        }
        $ID = $this->request->getPost("ID");
        $mobile_users = UsersMobile::findFirst($ID);
        if (!$mobile_users) {
            $this->flash->error("content does not exist " . $ID);

            $this->dispatcher->forward([
                'controller' => "mobile_users",
                'action' => 'index'
            ]);

            return;
        }
        $mobile_users->Title = $this->request->getPost("Title");
        $mobile_users->Mail = $this->request->getPost("Mail");
        $mobile_users->Active = $this->request->getPost("Active");

        //For Test Only
        $mobile_users->Access_Token =" ";
        $mobile_users->Social_Avatar=" ";
        $mobile_users->Social_ID=" ";
        $mobile_users->Social_Type=" ";


        if ($mobile_users->save()) {

            $this->flashSession->success($this->getTranslation()->_("User was Updated successfully"));
            //check notification and set it = read
            $notifi = GeneralNotifications::findFirst(["external_type_id=3 AND user_id={$ID} AND is_read=0"]);
            if($notifi){
                $notifi->is_read = 1;
                $notifi->save();

            }
            return $this->response->redirect($_SERVER['HTTP_REFERER']);


        }


    }
    public function statisticsAction(){
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'UsersMobile', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";
        $parameters["Application_ID"] = $this->session->get('auth-identity')['Application_ID'];

        $mobile_users = UsersMobile::find(array(
            "Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
            "order" =>"ID Desc"
        ));

        if (count($mobile_users) == 0) {
            $this->flash->notice("The search did not find any Users");

            $this->dispatcher->forward([
                "controller" => "mobile_users",
                "action" => "index"
            ]);

            return;
        }


        $paginator = new Paginator([
            'data' => $mobile_users,
            'limit' => 10,
            'page' => $numberPage
        ]);
        $users_active = UsersMobile::find(array(
            "Active = 1 AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
        ));
        $users_males = UsersMobile::find(array(
            "Gender = 0","Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
        ));
        $users_females = UsersMobile::find(array(
            "Gender = 1 AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
        ));
        $users_web = UsersMobile::find(array(
            "Login_Type = 'web' AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
        ));
        $users_fb = UsersMobile::find(array(
            "Login_Type = 'facebook' AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
        ));
        $users_instegram = UsersMobile::find(array(
            "Login_Type = 'instegram' AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
        ));
        $users_twitter = UsersMobile::find(array(
            "Login_Type = 'twitter' AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
        ));
        $users_nonActive = UsersMobile::find(array(
            "Active != 1  AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}"
        ));


        $this->view->page = $paginator->getPaginate();
        $this->view->users_count = count($mobile_users);
        $this->view->users_active = count($users_active);
        $this->view->users_web = count($users_web);
        $this->view->users_fb = count($users_fb);
        $this->view->users_instegram = count($users_instegram);
        $this->view->users_twitter = count($users_twitter);
        $this->view->users_males = count($users_males);
        $this->view->users_females = count($users_females);
        $this->view->users_nonActive = count($users_nonActive);
        
    }

    public function statisticsByFilterAction($filter){

        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'UsersMobile', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "ID";
        $parameters["Application_ID"] = $this->session->get('auth-identity')['Application_ID'];
        $mobile_users = $this->switchusers($filter);

//        if (count($mobile_users) == 0) {
//            $this->flash->notice("The search did not find any MobileUsers");
//
//            $this->dispatcher->forward([
//                "controller" => "mobile_users",
//                "action" => "index"
//            ]);
//
//            return;
//        }


        $paginator = new Paginator([
            'data' => $mobile_users,
            'limit' => 10,
            'page' => $numberPage
        ]);

        $this->view->filter = $filter;
        $this->view->page = $paginator->getPaginate();



            
    }
    public function switchusers($filter){
        switch ($filter):
            case "201": //females
                $mobile_users = UsersMobile::find(array(
                    "Gender = 1 AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;

            case "202": //males
                $mobile_users = UsersMobile::find(array(
                    "Gender = 0  AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;
            case "203": //users
                $mobile_users = UsersMobile::find(array(
                    "Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;
            case "204": // active
                $mobile_users = UsersMobile::find(array(
                    "Active = 1 AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;
            case "205": //nonactive
                $mobile_users = UsersMobile::find(array(
                    "Active !=1 AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;
            case "206": //fb
                $mobile_users = UsersMobile::find(array(
                    "Login_Type = 'facebook' AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;

            case "207": //web
                $mobile_users = UsersMobile::find(array(
                    "Login_Type = 'web' AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;

            case "208": //twitter
                $mobile_users = UsersMobile::find(array(
                    "Login_Type = 'twitter' AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;

            case "209": //instegram
                $mobile_users = UsersMobile::find(array(
                    "Login_Type = 'instegram' AND Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;
            default:
                $mobile_users = UsersMobile::find(array(
                    "Application_ID = {$this->session->get('auth-identity')['Application_ID']}",
                    "order" =>"ID Desc"
                ));
                return $mobile_users;
        endswitch;
    }

    public function mailAction($User_ID){
        $user = UsersMobile::findFirstByID($User_ID);
        $this->view->user = $user;
    }
    public function sendmailAction(){
        $this->getDI()->getMail()->send(
            array(
                $this->request->getPost('EMail')
            ),
            "Penta Value",
            'replayform',
            array(

            )
        );

    }
    public function ajaxContentAction(){
        $this->view->disable();
        if ($this->request->isAjax()) {
            $array  = $this->modelsManager->createQuery("
SELECT * FROM Models\UsersMobile WHERE  Application_ID={$this->session->get('auth-identity')['Application_ID']} 
AND Models\UsersMobile.ID 
NOT IN 
(SELECT User_ID FROM \CpUserProfile) 
ORDER BY Models\UsersMobile.ID DESC")
                ->execute()->toArray();

            foreach ($array as $k=>$v){
                $user_id= $v['ID'];
//                $profile = \CpUserProfile::findFirst(array("User_ID={$user_id}"));
//                if($profile){
//                   continue;
//                }
                $array[$k]["Join_Date"] = date('m/d/Y', $v["Join_Date"]);
                $array[$k]["Time_Date"] = date('H:i:s', $v["Join_Date"]);
                switch($array[$k]["Gender"]){
                    case 0:
                        $array[$k]["Gender"] = "Female";
                        break;
                    default:
                        $array[$k]["Gender"] = "Male";

                }
            }
            $dataTables = new DataTable();
           // die(print_R( $array ));
            $dataTables->fromArray($array)->sendResponse();
        }

    }
    public function deleteAction($ID){
        $user = UsersMobile::findFirstByID($ID);
        if(count($user)>0){
            $user->delete();
        }else{
            return;
        }

        $profile = \CpUserProfile::findFirst(array("User_ID={$ID}"));
        if($profile){
            $profile->delete();
        }
        $log = Logs::findFirst(array("user_id ={$ID}"));
        if($log){
            $log->delete();
        }
        if ($this->request->isAjax()) {
            return;
        }
        $this->flash->success("User was deleted successfully");


    }

    public function ajaxDeleteAction(){


        if ($this->request->isAjax()) {

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

    public function filterUsersAction(){
        $numberPage = $this->request->getQuery("page", "int");
        if($this->request->isPost()){
            $User= $this->request->getPost("User");
            $Mail= $this->request->getPost("Mail");
            $Active= $this->request->getPost("Active");
            $Gender= $this->request->getPost("Gender");
        }else{
            $User= $this->request->getQuery("User");
            $Mail= $this->request->getQuery("Mail");
            $Active= $this->request->getQuery("Active","int");
            $Gender= $this->request->getQuery("Gender");
        }

        $phql= "SELECT * FROM Models\UsersMobile AS Users";
        $phql .= " WHERE Users.User LIKE '%" . $User . "%'";
        $phql .= " AND Users.Mail LIKE '%" . $Mail . "%'";
        $phql .= " AND Users.Gender LIKE '%" . $Gender . "%'";
        $phql .= " AND Users.Active  LIKE '%" . $Active . "%'";
        $phql .=  " AND Users.Application_ID={$this->session->get('auth-identity')['Application_ID']}";
        if($this->request->getPost('date_from') !=="" && $this->request->getPost('date_to') !=="" ){
            $date_from= strtotime($this->request->getPost('date_from'));
            $date_to= strtotime($this->request->getPost('date_to'));
            $phql .= " AND Users.Join_Date BETWEEN {$date_from} AND {$date_to}";
        }

        $content=$this->modelsManager->createQuery($phql)->execute();
        $paginator = new Paginator([
            'data' => $content,
            'limit' => 8,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
        $this->view->User = $User;
        $this->view->Mail = $Mail;
        $this->view->Active = $Active;


    }

    
}
