<?php
namespace Vokuro\Controllers;

use Models\UsersMobile;
use Vokuro\Forms\LoginForm;
use Vokuro\Forms\SignUpForm;
use Vokuro\Forms\ForgotPasswordForm;
use Vokuro\Auth\Exception as AuthException;
use Vokuro\Models\Users;
use Vokuro\Models\ResetPasswords;
use Phalcon\Mvc\Controller;


/**
 * Controller used handle non-authenticated session actions like login/logout, user signup, and forgotten passwords
 */
class SessionController extends Controller
{

    /**
     * Default action. Set the public layout (layouts/public.volt)
     */
    public function initialize()
    {
        $this->view->setTemplateBefore('public_view');
    }

    public function indexAction()
    {

    }

    /**
     * Allow a user to signup to the system
     */
    public function signupAction()
    {
        $form = new SignUpForm();

        if ($this->request->isPost()) {

            if ($form->isValid($this->request->getPost()) != false) {

                $user = new UsersMobile([
                    'Title' => $this->request->getPost('name', 'striptags'),
                    'Mail' => $this->request->getPost('email'),
                    'User' => $this->request->getPost('User'),
                    'Pass' => $this->security->hash($this->request->getPost('password')),
                    'Img' => 'user_img/noprofile.jpg',
                    'Gender' => '-1',
                    'Access_Token' => ' ',
                    'Social_Avatar' => ' ',
                    'Login_Type' => 'web',
                    'Social_ID' => ' ',
                    'Social_Type' => ' ',
                    'Join_Date' => time(),
                    'Application_ID' => $this->config->Penta_Settings->Application_ID,
                    'Module_ID' => '20002',
                    'Active' =>'1',


                ]);

                if ($user->save()) {
                    $cp_User = new \CpUserProfile();
                    $cp_User->Profile_ID = 1;
                    $cp_User->User_ID=$user->ID;
                    $cp_User->banned='N';
                    $cp_User->active='Y';
                    $cp_User->suspended='N';
                    $cp_User->save();

                    return $this->dispatcher->forward([
                        'controller' => 'session',
                        'action' => 'login'
                    ]);
                }

                $this->flash->error($user->getMessages());
            }
        }

        $this->view->form = $form;
    }

    /**
     * Starts a session in the admin backend
     */
    public function loginAction()
    {
        $this->view->setTemplateBefore('login');

        $form = new LoginForm();

        try {

            if (!$this->request->isPost()) {

                // if ($this->auth->hasRememberMe()) {
                //     return $this->auth->loginWithRememberMe();
                // }
            } else {

                if ($form->isValid($this->request->getPost()) == false) {
                    foreach ($form->getMessages() as $message) {
                        $this->flash->error($message);
                    }
                } else {
                    $this->auth->check([
                        'User' => $this->request->getPost('User'),
                        'Pass' => $this->request->getPost('Pass'),
                        'remember' => $this->request->getPost('remember'),
                        'Application_ID'=>$this->request->getPost('Application_ID')
                    ]);
                    $Application=\UsersApplication::findFirst(["ID={$this->request->getPost('Application_ID')}"]);
                    
                    if($Application->Application_Route !== '0') {
                        return $this->response->redirect("{$Application->Application_Route}");
                    }
                    // For Tanks
                    $system = $this->request->getPost("system");
                    switch ($system){
                        case 1:
                            $logon_link = "cms_module/home/index/1";
                            break;
                        case 2:
                            $logon_link = "maintenance_module/index";
                            break;
                        case 3:
                            $logon_link = "sales_visits_module/sales_visits";
                            break;
                        default:
                            $logon_link = "cms_module/home/index/1";
                            break;
                    }
                    return $this->response->redirect($logon_link);
                }
            }
        } catch (AuthException $e) {
            $this->flash->error($e->getMessage());
        }

        $this->view->form = $form;
		if(isset($_REQUEST['app'])){ 
			$this->view->app= $_REQUEST['app'];
			
		}else{
			$this->view->app= 0;
		}
    }

    /**
     * Shows the forgot password form
     */
    public function forgotPasswordAction()
    {
        $form = new ForgotPasswordForm();

        if ($this->request->isPost()) {

            // Send emails only is config value is set to true
            if ($this->getDI()->get('config')->useMail) {

                if ($form->isValid($this->request->getPost()) == false) {
                    foreach ($form->getMessages() as $message) {
                        $this->flash->error($message);
                    }
                } else {

                    $user = UsersMobile::findFirst(["Mail='".$this->request->getPost('email')."'"]);
                    if (!$user) {
                        $this->flash->success('There is no account associated to this email');
                    } else {

                        $resetPassword = new ResetPasswords();
                        $resetPassword->usersId = $user->ID;
                        if ($resetPassword->save()) {
                            $this->flash->success('Success! Please check your messages for an email reset password');
							$this->flash->success($resetPassword->code);
                        } else {
                            foreach ($resetPassword->getMessages() as $message) {
                                $this->flash->error($message);
                            }
                        }
                    }
                }
            } else {
                $this->flash->warning('Emails are currently disabled. Change config key "useMail" to true to enable emails.');
            }
        }

        $this->view->form = $form;
    }

    /**
     * Closes the session
     */
    public function logoutAction()
    {
        //special case for gam3eya
        if($this->session->get('auth-identity')['Application_ID']==583){
            $this->auth->remove();
            return $this->response->redirect('gam3eya_module/session/login');
        }       
		$app_id= $this->session->get('auth-identity')['Application_ID'];
		 $this->auth->remove();

        return $this->response->redirect("session/login?app={$app_id}");
    }
}
