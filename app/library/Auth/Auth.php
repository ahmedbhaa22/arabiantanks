<?php

namespace Vokuro\Auth;

use Models\TanksBranchesEmployees;
use Phalcon\Mvc\User\Component;
use Models\UsersMobile;
use Vokuro\Models\RememberTokens;
use Vokuro\Models\SuccessLogins;
use Vokuro\Models\FailedLogins;
use Vokuro\UsersModule\Models\UserData;

/**
 * Vokuro\Auth\Auth
 * Manages Authentication/Identity Management in Vokuro
 */
class Auth extends Component
{
    /**
     * Checks the user credentials
     *
     * @param array $credentials
     * @return boolean
     * @throws Exception
     */
    public function check($credentials)
    {

        // Check if the user exist
        $user = UsersMobile::findFirst(["User='".$credentials['User']."'AND Application_ID={$credentials['Application_ID']}"]);
        if ($user == false) {
            $this->registerUserThrottling(0);
            throw new Exception('User does not exist in this application');
        }

        // Check the password
        if (!$this->security->checkHash($credentials['Pass'], $user->Pass)) {
            $this->registerUserThrottling($user->ID);
            throw new Exception('Wrong Password');
        }


        // Check If The User is Eligible to access cp and not a mobile application user

        $user_profile = \CpUserProfile::findFirst(["User_ID={$user->ID}"]);
        if ($user_profile == false) {
            $this->registerUserThrottling(0);
            throw new Exception('Access Denied');
        }


        // Check if the user was flagged
        $this->checkUserFlags($user);

        // Register the successful login
       // $this->saveSuccessLogin($user);

        // Check if the remember me was selected
        if (isset($credentials['remember'])) {
            $this->createRememberEnvironment($user);
        }
        $roles = $user->UsersRule;
        $rules=[];
        foreach ($roles as $value){
            $rules[$value->rule_id] = $value->Rule->name;
        }
        //Check if user rule allows him to access cms module
        $chosen_system = $this->request->get("system");
        if($chosen_system==1){
            if(!array_key_exists(1,$rules)){
                $this->registerUserThrottling(0);
                throw new Exception('Access Denied');
            }

        }
        $this->saveSuccessLogin($user);
        //check user region and branch
        $user_data = UserData::findFirst(["user_id={$user->ID}"]);
        if(!$user_data){
            $user_info=[];
        }else{
            $user_info["branch"]=$user->branch_id;
            $user_info["region"]=$user->region_id;
            $user_info["allowed_branches"]=[];
            //Allowed Branches
            $allowed_branches = TanksBranchesEmployees::find(["user_id={$user->ID}"]);
            if(count($allowed_branches)>0){
                foreach ($allowed_branches as $branch){
                    $user_info["allowed_branches"][]=$branch->branch_id;
                }

            }
        }

        $this->session->set('auth-identity', [
            'id' => $user->ID,
            'name' => $user->Title,
            'profile' => $user->CpUserProfile->Profiles->name,
            'Application_ID' => $credentials['Application_ID'],
            'Lang' => $user->CpUserProfile->Cp_Lang,
            'Scheme' => $user->CpUserProfile->Scheme_File,
            'rules' => $rules,
            'is_admin' => $user->is_admin,
            'Lang_ID' => $user->CpUserProfile->LangDetails->id,
            'user_info'=> $user_info
        ]);
    }

    /**
     * Creates the remember me environment settings the related cookies and generating tokens
     *
     * @param \Vokuro\Models\Users $user
     * @throws Exception
     */
    public function saveSuccessLogin($user)
    {
        $successLogin = new SuccessLogins();
        $successLogin->usersId = $user->ID;
        $successLogin->ipAddress = $this->request->getClientAddress();
        $successLogin->userAgent = $this->request->getUserAgent();
        if (!$successLogin->save()) {
            $messages = $successLogin->getMessages();
            throw new Exception($messages[0]);
        }
    }

    /**
     * Implements login throttling
     * Reduces the effectiveness of brute force attacks
     *
     * @param int $userId
     */
    public function registerUserThrottling($userId)
    {
        $failedLogin = new FailedLogins();
        $failedLogin->usersId = $userId;
        $failedLogin->ipAddress = $this->request->getClientAddress();
        $failedLogin->attempted = time();
        $failedLogin->save();

        $attempts = FailedLogins::count([
            'ipAddress = ?0 AND attempted >= ?1',
            'bind' => [
                $this->request->getClientAddress(),
                time() - 3600 * 6
            ]
        ]);

        switch ($attempts) {
            case 1:
            case 2:
                // no delay
                break;
            case 3:
            case 4:
                sleep(2);
                break;
            default:
                sleep(4);
                break;
        }
    }

    /**
     * Creates the remember me environment settings the related cookies and generating tokens
     *
     * @param \Vokuro\Models\Users $user
     */
    public function createRememberEnvironment(UsersMobile $user)
    {
        $userAgent = $this->request->getUserAgent();
        $token = md5($user->User . $user->Pass . $userAgent);

        $remember = new RememberTokens();
        $remember->usersId = $user->ID;
        $remember->token = $token;
        $remember->userAgent = $userAgent;

        if ($remember->save() != false) {
            $expire = time() + 86400 * 8;
            $this->cookies->set('RMU', $user->id, $expire);
            $this->cookies->set('RMT', $token, $expire);
        }
    }

    /**
     * Check if the session has a remember me cookie
     *
     * @return boolean
     */
    public function hasRememberMe()
    {
        return $this->cookies->has('RMU');
    }

    /**
     * Logs on using the information in the cookies
     *
     * @return \Phalcon\Http\Response
     */
    public function loginWithRememberMe()
    {
        $userId = $this->cookies->get('RMU')->getValue();
        $cookieToken = $this->cookies->get('RMT')->getValue();

        $user = UsersMobile::findFirstByID($userId);
        var_dump($user);
        exit;
        if ($user) {

            $userAgent = $this->request->getUserAgent();
            $token = md5($user->User . $user->Pass . $userAgent);

            if ($cookieToken == $token) {

                $remember = RememberTokens::findFirst([
                    'usersId = ?0 AND token = ?1',
                    'bind' => [
                        $user->id,
                        $token
                    ]
                ]);
                if ($remember) {

                    // Check if the cookie has not expired
                    if ((time() - (86400 * 8)) < $remember->createdAt) {

                        // Check if the user was flagged
                        $this->checkUserFlags($user);

                        // Register identity
                        $this->session->set('auth-identity', [
                            'id' => $user->ID,
                            'name' => $user->Title,
                            'profile' => $user->CpUserProfile->Profiles->name,
                            'Application_ID' => $this->request->getPost("Application_ID")
                        ]);

                        // Register the successful login
                        $this->saveSuccessLogin($user);

                        return $this->response->redirect('users');
                    }
                }
            }
        }

        $this->cookies->get('RMU')->delete();
        $this->cookies->get('RMT')->delete();

        return $this->response->redirect('session/login');
    }

    /**
     * Checks if the user is banned/inactive/suspended
     *
     * @param \Vokuro\Models\Users $user
     * @throws Exception
     */
    public function checkUserFlags(UsersMobile $user)
    {
        if ($user->CpUserProfile->active != 'Y') {
            throw new Exception('The user is inactive');
        }

        if ($user->CpUserProfile->banned != 'N') {
            throw new Exception('The user is banned');
        }

        if ($user->CpUserProfile->suspended != 'N') {
            throw new Exception('The user is suspended');
        }
    }

    /**
     * Returns the current identity
     *
     * @return array
     */
    public function getIdentity()
    {
        return $this->session->get('auth-identity');
    }

    /**
     * Returns the current identity
     *
     * @return string
     */
    public function getName()
    {
        $identity = $this->session->get('auth-identity');
        return $identity['name'];
    }

    /**
     * Removes the user identity information from session
     */
    public function remove()
    {
        if ($this->cookies->has('RMU')) {
            $this->cookies->get('RMU')->delete();
        }
        if ($this->cookies->has('RMT')) {
            $this->cookies->get('RMT')->delete();
        }

        $this->session->remove('auth-identity');
    }

    /**
     * Auths the user by his/her id
     *
     * @param int $id
     * @throws Exception
     */
    public function authUserById($id)
    {
        $user = Users::findFirstById($id);
        if ($user == false) {
            throw new Exception('The user does not exist');
        }

        $this->checkUserFlags($user);

        $this->session->set('auth-identity', [
            'id' => $user->ID,
            'name' => $user->Title,
            'profile' => $user->CpUserProfile->Profiles->name,
            'Application_ID' => $this->request->getPost("Application_ID")
        ]);
    }

    /**
     * Get the entity related to user in the active identity
     *
     * @return \Vokuro\Models\Users
     * @throws Exception
     */
    public function getUser()
    {
        $identity = $this->session->get('auth-identity');
        if (isset($identity['id'])) {

            $user = Users::findFirstById($identity['id']);
            if ($user == false) {
                throw new Exception('The user does not exist');
            }

            return $user;
        }

        return false;
    }
}
