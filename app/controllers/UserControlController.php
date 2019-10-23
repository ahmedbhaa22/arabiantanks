<?php
namespace Vokuro\Controllers;

use Vokuro\Models\EmailConfirmations;
use Vokuro\Models\ResetPasswords;
use Models\UsersMobile;
use Phalcon\Security;

use Phalcon\Security\Random;

use Phalcon\Mvc\Url;

use Vokuro\Forms\AdvancedSearchForm;

use Vokuro\Pentavalue\Keyvalue;

use Phalcon\Mvc\Model\QueryBuilder;

use DataTables\DataTable;


/**
 * UserControlController
 * Provides help to users to confirm their passwords or reset them
 */
class UserControlController extends ControllerBase
{

    public function initialize()
    {
//        if ($this->session->has('auth-identity')) {
//            $this->view->setTemplateBefore('private');
//        }
        $this->view->setTemplateBefore('login');
    }

    public function indexAction()
    {

    }


    //Users Reset Pass in APP
    public function forgetPasswordAction()
    {


    }

    public function forgetPassPostAction()
    {

        $mail = $this->request->get("mail");
        $user = $this->checkUserByMail($mail);
        if (!$user) {
            die("User Is Not Found");
        }
        $resetPassword = new ResetPasswords();
        $resetPassword->usersId = $user->ID;
        if (!$resetPassword->save()) {
            return;
        }
        //send reset link
        $this->sendResetPassLink($resetPassword);
        echo "Password Reset Link Has Been Sent";

    }
    public function resetPasswordAction()
    {
        //$this->view->disable();
        $code = $this->dispatcher->getParam('code');
        $mail = $this->dispatcher->getParam('email');
        $app = $this->dispatcher->getParam('app');
        $reset = ResetPasswords::findFirst(["code='{$code}' AND reset='N'"]);
        if (!$reset) {
            $arr['ErrorCode'] = 4015;
            $arr['Message'] = "Code is Wrong";
            echo json_encode($arr);
            return;
        }
        $new_pass = base64_encode(openssl_random_pseudo_bytes(8));
        $user = UsersMobile::findFirst(["Mail='{$mail}' AND Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        $user->Pass = $this->security->hash($new_pass);
        $user->save();

        //send the new password
        $this->sendNewPass($user, $new_pass);
        $reset->reset = "Y";
        $reset->save();

        echo "new password has been sent";

    }

    public function sendResetPassLink($reset)
    {
        $this->getDI()
            ->getMail()
            ->send([
                $reset->user->Mail => $reset->user->Title
            ], "Reset your password", 'reset_app', [
                'resetUrl' => '/reset-pass/' . $reset->code . '/' . $reset->user->Mail . '/' . "583"
            ]);
        echo "An Email has been sent to your e-mail address";
    }

    public function checkUserByMail($mail)
    {
        $user = UsersMobile::findFirst(["Mail='{$mail}' AND Application_ID={$this->session->get('auth-identity')['Application_ID']}"]);
        if (!$user) {
            return false;
        }
        return $user;
    }


    public function sendNewPass($user, $newPass)
    {
        $this->getDI()
            ->getMail()
            ->send([
                $user->Mail => $user->Title
            ], "Your New Password", 'new_pass', [
                'newPass' => $newPass
            ]);
    }

    //End User Reset Pass App

    /**
     * Confirms an e-mail, if the user must change thier password then changes it
     */
//    public function confirmEmailAction()
//    {
//        $code = $this->dispatcher->getParam('code');
//
//        $confirmation = EmailConfirmations::findFirstByCode($code);
//
//        if (!$confirmation) {
//            return $this->dispatcher->forward([
//                'controller' => 'index',
//                'action' => 'index'
//            ]);
//        }
//
//        if ($confirmation->confirmed != 'N') {
//            return $this->dispatcher->forward([
//                'controller' => 'session',
//                'action' => 'login'
//            ]);
//        }
//
//        $confirmation->confirmed = 'Y';
//
//        $confirmation->user->active = 'Y';
//
//        /**
//         * Change the confirmation to 'confirmed' and update the user to 'active'
//         */
//        if (!$confirmation->save()) {
//
//            foreach ($confirmation->getMessages() as $message) {
//                $this->flash->error($message);
//            }
//
//            return $this->dispatcher->forward([
//                'controller' => 'index',
//                'action' => 'index'
//            ]);
//        }
//
//        /**
//         * Identify the user in the application
//         */
//        $this->auth->authUserById($confirmation->user->id);
//
//        /**
//         * Check if the user must change his/her password
//         */
//        if ($confirmation->user->mustChangePassword == 'Y') {
//
//            $this->flash->success('The email was successfully confirmed. Now you must change your password');
//
//            return $this->dispatcher->forward([
//                'controller' => 'users',
//                'action' => 'changePassword'
//            ]);
//        }
//
//        $this->flash->success('The email was successfully confirmed');
//
//        return $this->dispatcher->forward([
//            'controller' => 'users',
//            'action' => 'index'
//        ]);
//    }
//
//    public function resetPasswordAction()
//    {
//        $code = $this->dispatcher->getParam('code');
//
//        $resetPassword = ResetPasswords::findFirstByCode($code);
//
//        if (!$resetPassword) {
//            return $this->dispatcher->forward([
//                'controller' => 'index',
//                'action' => 'index'
//            ]);
//        }
//
//        if ($resetPassword->reset != 'N') {
//            return $this->dispatcher->forward([
//                'controller' => 'session',
//                'action' => 'login'
//            ]);
//        }
//
//        $resetPassword->reset = 'Y';
//
//        /**
//         * Change the confirmation to 'reset'
//         */
//        if (!$resetPassword->save()) {
//
//            foreach ($resetPassword->getMessages() as $message) {
//                $this->flash->error($message);
//            }
//
//            return $this->dispatcher->forward([
//                'controller' => 'index',
//                'action' => 'index'
//            ]);
//        }
//
//        /**
//         * Identify the user in the application
//         */
//        $this->auth->authUserById($resetPassword->usersId);
//
//        $this->flash->success('Please reset your password');
//
//        return $this->dispatcher->forward([
//            'controller' => 'users',
//            'action' => 'changePassword'
//        ]);
//    }
}
