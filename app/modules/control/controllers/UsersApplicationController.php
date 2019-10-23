<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 1/29/2017
 * Time: 3:44 PM
 */


namespace Vokuro\Control\Controllers;
use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;
use Models\UsersMobile;
use Phalcon\Http\Request;
use Phalcon\Security;
use Phalcon\Mvc\Url;

class UsersApplicationController extends ModuleBase
{
    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
//        //Get the current identity
//
//        $identity = $this->auth->getIdentity();
//
//        // If there is no identity available the user is redirected
//        if (!is_array($identity)) {
//            //die("islam");
//            // die();
//
//            $this->response->redirect($this->url->get("session/login"));
//            return false;
//        }

    }
    public function newAction(){
        $languages = \Languages::find();
        $this->view->languages = $languages;

    }
    public function createAction(){
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "users_application_module",
                'action' => 'index'
            ]);

            return;
        }
        $user_app = new \UsersApplication();
        $user_app->Title = $this->request->getPost("Title");
        $user_app->Account_ID= 0;
        $user_app->Des =" ";
        $user_app->Type_App_Platform="3,2,1";
        $user_app->Type_App_Lang="1";
        $user_app->Menu_Depts_ID="9";
        $user_app->Menu_Layout_ID="5";
        $user_app->Menu_Version_ID="8";
        $user_app->Field_ID="2";
        $user_app->Icon="uploads/00c559d8245105b22c6747a15fba4ce8.png";
        $user_app->Splash_Screen="uploads/00c559d8245105b22c6747a15fba4ce8.png";
        $user_app->BG="uploads/00c559d8245105b22c6747a15fba4ce8.png";
        $user_app->Logo="uploads/00c559d8245105b22c6747a15fba4ce8.png";
        $user_app->Date=time();
        $user_app->Color_ID="9";
        $user_app->Ads_Setting='a:5:{s:4:"Type";s:1:"3";s:16:"iOS_Publisher_ID";s:0:"";s:20:"Android_Publisher_ID";s:0:"";s:12:"Ads_Provider";s:0:"";s:8:"Position";s:6:"bottom";}';
        $user_app->Setting_Cache="17";
        $user_app->Setting_App='a:5:{s:4:"Type";s:1:"3";s:16:"iOS_Publisher_ID";s:0:"";s:20:"Android_Publisher_ID";s:0:"";s:12:"Ads_Provider";s:0:"";s:8:"Position";s:6:"bottom";}';
        $user_app->Theme_Color_ID="9";
        $user_app->Menu_Updated="0";
        $user_app->Push_Notifications="0";
        $user_app->Live="0";
        $user_app->New_DZ="0";
        $user_app->Splash_Screen_iPhone="uploads/f1e1dafce1e52be704b9f7baf41714a8.png";
        $user_app->Splash_Screen_iPad="uploads/f1e1dafce1e52be704b9f7baf41714a8.png";
        $user_app->Splash_Screen_Android="uploads/f1e1dafce1e52be704b9f7baf41714a8.png";
        $user_app->Free="1";
        $user_app->Main_Page_Layout_ID="0";
        $user_app->Main_Page_Api="0";
        $user_app->Entry_Point="0";
        if (!$user_app->save()) {
            foreach ($user_app->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "users_application",
                'action' => 'new'
            ]);

            return;
        }

        $Profile=1;


        $user = new UsersMobile([
            'Title' => $this->request->getPost('UserTitle'),
            'User' => $this->request->getPost('User'),
            'Mail' => $this->request->getPost("Mail"),
            'Pass' => $this->security->hash($this->request->getPost('Pass')),
            'Img' => 'user_img/noprofile.jpg',
            'Access_Token' => "",
            'Social_Avatar' => "",
            'Login_Type' => "web",
            'Social_ID' => "",
            'Social_Type' => '',
            'Join_Date' => time(),
            'Application_ID' => $user_app->ID,
            'Module_ID' => 20002
        ]);
//        \Phalcon\Mvc\Model::setup(array(
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
            if (!$profiles->save()){
                $this->flashSession->error('Error Profile:'.$user->getMessages());
            }
            else{
                //$this->flashSession->success("User was created successfully");
            }



        }

        //choose default lang for cms

        $lang = new \ApplicationCmsLang();
        $lang->application_id = $user_app->ID;
        $lang->lang_id = $this->request->getPost("Lang");
        $lang->is_default = 1;
        $lang->save();


        $this->flash->success("Application was created successfully");

        $this->dispatcher->forward([
            'controller' => "session",
            'action' => 'login'
        ]);
    }



}