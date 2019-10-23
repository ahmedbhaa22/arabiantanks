<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/28/2017
 * Time: 2:04 PM
 */

namespace Vokuro\UsersModule\Controllers;


use Abraham\TwitterOAuth\TwitterOAuth;
use Models\UsersMobile;
use Vokuro\UsersModule\Models\LoginTypes;
use Vokuro\UsersModule\Models\SocialAppInfo;
use Vokuro\UsersModule\Models\UserData;

class AuthController extends AuthControllerBase
{
    // TODO :: PUSH SERVICES.PHP TO SERVER
    public function indexAction()
    {
        // *** test action

        // $dkv = \DataKeyvalue::findFirst(83);
        // $contact_us_email = \DataKeyvalueUserdata::findFirst([
        //     'DKV_ID = :dkv:',
        //     'bind' => [
        //         'dkv' => 83,
        //     ]
        // ])->toArray();
        // var_dump($contact_us_email);die;
        dd('test');
    }

    /**
     * register new user
     */
    public function registerAction()
    {
        $request = $this->validationService->getRequestData($this->request);
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $lang_id = $request['lang_id'];
           // dd($this->request->get('lang_id'));
                $this->responseService->setLang_ID($lang_id);
            $validation_result = $this->validationService->validateRequest($this->request,
                ['email','username','name','password','confirm_password','app_id','device_token'], // required
                ['email'], // email
                [], // alphanumeric
                ['mobile'],
                ['password_field_name'=>'password','confirm_field_name'=>'confirm_password'], // password confirm
                [], // files
                ['fields'=>[ // min-max string length
                    ['name'=>'password','min'=>8,'max'=>20],
                    ['name'=>'confirm_password','min'=>8,'max'=>20],
                    ['name'=>'mobile','min'=>8,'max'=>15],
                    ['name'=>'user_name','min'=>5,'max'=>20],
                ]
                ]);


            if(count($validation_result))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Error!');
                $this->responseService->setMessageAR('خطأ!');
                $this->responseService->setValidationErrorMessages($validation_result);
            }
            else
            {
                try
                {
                    $image = null;

                    $request = $this->validationService->getRequestData($this->request);
                    $name = $request['name'];
                    $username = $request['username'];
                    $mobile = $request['mobile'];
                    $password = $this->security->hash($request['password']);
                    $gender = (array_has($request, 'gender'))?$request['gender']:0;
                    $login_type = 1;
                    $email = $request['email'];
                    $app_id = $request['app_id'];
                    $device_token = $request['device_token'];
                    $base64_img = (array_has($request, 'image') &&
                        preg_match(
                            '^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$',
                            $request['image']
                        ))?$request['image']:'';

                    if(strlen($base64_img))
                    {
                        $image = $this->base64stringToImageService->convert($base64_img);
                    }

                    /* Check User Exists */

                    $user_exists=false;
                    $user_email_exists = UsersMobile::findFirst([
                        'conditions' => 'Mail = {email} and Application_ID = {app_id}',
                        'columns' => 'ID',
                        'bind' => [
                            'email'    => $email,
                            'app_id'   => $app_id
                        ]
                    ]);
                    if($user_email_exists){
                        $this->responseService->setCode(4);
                        $this->responseService->setMessageEN('User Email already exists!');
                        $this->responseService->setMessageAR('تم إنشاء حساب بهذا الايميل من قبل');
                      //  $this->responseService->setOtherErrorMessages(['user already exists']);
                        $user_exists=true;
                    }else{
                        $user_username_exists = UsersMobile::findFirst([
                            'conditions' => 'User = {username} and Application_ID = {app_id}',
                            'columns' => 'ID',
                            'bind' => [
                                'username'    => $username,
                                'app_id'   => $app_id
                            ]
                        ]);
                        if($user_username_exists){
                            $this->responseService->setCode(4);
                            $this->responseService->setMessageEN('Username already exists!');
                            $this->responseService->setMessageAR('اسم المستخدم مستخدم من قبل');
                            //$this->responseService->setOtherErrorMessages(['user already exists']);
                            $user_exists=true;
                        }
                        else{
                            $user_mobile_exists = UsersMobile::findFirst([
                                'conditions' => 'Mobile = {mobile} and Application_ID = {app_id}',
                                'columns' => 'ID',
                                'bind' => [
                                    'mobile'    => $mobile,
                                    'app_id'   => $app_id
                                ]
                            ]);
                            if($user_mobile_exists){
                                $this->responseService->setCode(4);
                                $this->responseService->setMessageEN('Mobile Number already exists!');
                                $this->responseService->setMessageAR('رقم الجوال مستخدم من قبل');
                                //$this->responseService->setOtherErrorMessages(['user already exists']);
                                $user_exists=true;
                            }
                        }
                    }
                    /* END Check User Exists */

                    if($user_exists)
                    {

                    }
                    else
                    {
                        $user = new UsersMobile();

                        $user->Title = $name;
                        $user->User = $username;
                        $user->Mobile = $mobile;
                        $user->Pass = $password;
                        $user->Img = ($image != false && strlen($image))?$image:'';
                        $user->Gender = $gender;
                        $user->Access_Token = '';
                        $user->Social_Avatar = '';
                        $user->Login_Type = $login_type;
                        $user->Mail = $email;
                        $user->City_ID = 0;
                        $user->Social_ID = 0;
                        $user->Social_Type = '';
                        $user->Join_Date = time();
                        $user->Application_ID = $app_id;
                        $user->Module_ID = 20002;
                        $user->Active = 0;
                        $user->Type = 0;
                        $user->is_admin = 0;
                        $user->token_id = NULL;
                        $user->confirm_code = NULL;
                        $user->device_token = $device_token;
                        $user->category_id  = 7; // عميل مسجل

                        if($user->save())
                        {
                            $user_data = new UserData;

                            $user_data->user_id   = $user->ID;
                            $user_data->branch_id = 11; // online branch

                            $user_data->save();

                            $this->emailService->send($user->Mail, $user->Title, 'Confirm Your Account', 'confirm_register',[
                                'confirm_url' => $this->confirm_register_url , 'email' => $user->Mail, 'app_id' => $app_id
                            ]);

                            $limited_user_data = UsersMobile::find([
                                'conditions' => 'ID = {user_id}',
                                'columns' => 'Mail,Title,User',
                                'bind' => [
                                    'user_id' => $user->ID
                                ]
                            ]);

                            $this->responseService->setCode(RC_SUCCESS);
                            $this->responseService->setMessageEN('User registered successfully, please check email for confirmation.');
                            $this->responseService->setMessageAR('تم إنشاء المستخدم بنجاح، برجاء التحقق من البريد الإلكتروني للتفعيل');
                            $this->responseService->setContent($limited_user_data->toArray());
                        }
                        else
                        {
                            $this->responseService->setCode(RC_REGISTER_FAIL);
                            $this->responseService->setMessageEN('Registration error, please try again');
                            $this->responseService->setMessageAR('حدث خطأ أثناء إنشاء الحساب، من فضلك حاول مرة أخرى');
                            $this->responseService->setOtherErrorMessages([$user->getMessages()]);
                        }
                    }
                }
                catch(\Exception $e)
                {
                    $this->responseService->setCode(RC_REGISTER_FAIL);
                    $this->responseService->setMessageEN('Registration error, please try again');
                    $this->responseService->setMessageAR('حدث خطأ أثناء إنشاء الحساب، من فضلك حاول مرة أخرى');
                    $this->responseService->setOtherErrorMessages([$e->getMessage()]);
                }
            }
        }

//        $this->response->setJsonContent($this->responseService->getResponseArray());
//        $this->response->send();

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    /**
     * confirm user by email
     */
    public function confirmRegisterAction()
    {
        $request = $this->validationService->getRequestData($this->request);
        if(!$this->request->isGet())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $lang_id = $request['lang_id'];
            // dd($this->request->get('lang_id'));
            $this->responseService->setLang_ID($lang_id);
            $validation_result = $this->validationService->validateRequest($this->request,
                ['email','app_id'], // required
                ['email'] // email
            );

            if(count($validation_result))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Error!');
                $this->responseService->setMessageAR('خطأ!');
                $this->responseService->setValidationErrorMessages($validation_result);
            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);

                $valid_email = UsersMobile::find([
                    'conditions' => 'Mail like {email} and Application_ID = {app_id}',
                    'columns' => 'ID,Active',
                    'bind' => [
                        'email' => $request_data['email'],
                        'app_id' => $request_data['app_id']
                    ]
                ]);

                if(count($valid_email) > 1)
                {
                    $this->responseService->setCode(RC_SECURITY_ISSUE);
                    $this->responseService->setMessageEN('Invalid Email!');
                    $this->responseService->setMessageAR('ايميل غير صحيح!');
                    $this->responseService->setOtherErrorMessages(['multiple users with same email!']);
                }
                elseif(count($valid_email) === 1)
                {
                    $valid_email = UsersMobile::findFirst($valid_email[0]->ID);

                    if($valid_email->Active == 0)
                    {
                        $valid_email->Active = 1;
                        if($valid_email->save())
                        {
                            $this->responseService->setCode(RC_SUCCESS);
                            $this->responseService->setMessageEN('Activated!');
                            $this->responseService->setMessageAR('تم التفعيل!');
                            $this->responseService->setContent(UsersMobile::find($valid_email->ID)->toArray());
                        }
                        else
                        {
                            $this->responseService->setCode(RC_REGISTER_CONFIRM_FAIL);
                            $this->responseService->setMessageEN('Email confirmation failed');
                            $this->responseService->setMessageAR('خطأ أثناء التفعيل');
                            $this->responseService->setOtherErrorMessages($valid_email->getMessages());
                        }
                    }
                    elseif($valid_email->Active == 1)
                    {
//                    die(var_dump(UsersMobile::findFirst($valid_email->ID)));
                        $this->responseService->setCode(RC_USER_ALREADY_ACTIVE);
                        $this->responseService->setMessageEN('User already activated');
                        $this->responseService->setMessageAR('المستخدم تم تفعيله من قبل');
                        $this->responseService->setContent(UsersMobile::find($valid_email->ID)->toArray());
                    }
                    else
                    {
                        $this->responseService->setCode(RC_REGISTER_CONFIRM_FAIL);
                        $this->responseService->setMessageEN('Email confirmation failed');
                        $this->responseService->setMessageAR('خطأ أثناء التفعيل');
                        $this->responseService->setOtherErrorMessages(['Email confirmation failed']);
                    }
                }
                else
                {
                    $this->responseService->setCode(RC_REGISTER_CONFIRM_FAIL);
                    $this->responseService->setMessageEN('No such email exists');
                    $this->responseService->setMessageAR('ايميل غير موجود');
                    $this->responseService->setOtherErrorMessages(['Email confirmation failed, no such user with this email exists']);
                }
            }
        }

//        $this->response->setJsonContent($this->responseService->getResponseArray());
//        $this->response->send();

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }



    public function loginGetTokenAction()
    {
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $request_data = $this->validationService->getRequestData($this->request);
            $request_validation = $this->validationService->validateRequest($this->request, ['password','app_id']);

            if(count($request_validation))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setValidationErrorMessages($request_validation);

                $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));die;
            }

            if(!array_has($request_data, 'email') && !array_has($request_data, 'username')
                && !array_has($request_data, 'mobile') && !array_has($request_data, 'app_id'))
            {
                $validation_error_message[0]['field'] = 'email|username|mobile|app_id';
                $validation_error_message[0]['message'] = 'email OR username OR mobile AND application_id - is required';

                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setValidationErrorMessages($validation_error_message);

                $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
            }

            $user = identifyUser($request_data);

            if($user)
            {
                $user_status = $this->userSettingsService->checkUserStatus($user, $request_data);
                if($user_status)
                {
                    switch($user_status)
                    {
                        case US_UNAUTHORIZED:
                            $this->responseService->setCode(RC_UNAUTHORIZED);
                            $this->responseService->setMessageEN('Invalid user credentials!');
                            $this->responseService->setMessageAR('تأكد أن بيانات الدخول صحيحة!');
                            $this->responseService->setOtherErrorMessages(['Invalid login credentials (email|username|mobile|app_id and password)']);
                            break;
                        case US_HAS_ACTIVE_TOKEN:
                            if($this->jwtService->expireToken($user))
                            {
                                $verification_code = $this->userSettingsService->getVerificationCode($user);

                                $verified_user = $this->userSettingsService->verifyUser($verification_code);

                                if($verified_user)
                               {
                                   $token = $this->jwtService->generateToken($verified_user);

                                   if($token)
                                   {
                                       $token_obj = new \stdClass();
                                       $token_obj->access_token = $token;

                                       $this->responseService->setCode(RC_SUCCESS);
                                       $this->responseService->setMessageEN('success');
                                       $this->responseService->setMessageAR('تمت العملية بنجاح');
                                       $this->responseService->setContent([$token_obj,["user_id"=>$user->ID]]);
                                   }
                                   else
                                   {
                                       $this->responseService->setCode(RC_TOKEN_ERROR);
                                       $this->responseService->setMessageEN('Error getting access token');
                                       $this->responseService->setMessageAR('حدث خطأ أثناء الحصول على كود تسجيل الدخول');
                                       $this->responseService->setOtherErroMessages('Error generating access token');
                                   }
                               }
                               else
                               {
                                   $this->responseService->setCode(RC_UNAUTHORIZED);
                                   $this->responseService->setMessageEN('Invalid user verification!');
                                   $this->responseService->setMessageAR('تأكد من صحة كود التفعيل');
                                   $this->responseService->setOtherErrorMessages(['Error fetching user with the provided verification code']);
                               }

                                // $code_obj = new \stdClass();
                                // $code_obj->verification_code = $verification_code;

                                // $this->responseService->setCode(RC_SUCCESS);
                                // $this->responseService->setMessageEN('success');
                                // $this->responseService->setMessageAR('تمت العملية بنجاح');
                                // $this->responseService->setContent([$code_obj]);
                            }
                            else
                            {
                                $this->responseService->setCode(RC_LOGIN_ACTIVE_USER_FAILED);
                                $this->responseService->setMessageEN('Error login active user');
                                $this->responseService->setMessageAR('خطأ أثناء تسجيل دخول مستخدم تم دخوله مسبقاً');
                                $this->responseService->setOtherErrorMessages('Error while changing old token');
                            }
                            break;
                        case US_NEEDS_TOKEN:
                            $verification_code = $this->userSettingsService->getVerificationCode($user);

                            $verified_user = $this->userSettingsService->verifyUser($verification_code);

                                if($verified_user)
                               {
                                   $token = $this->jwtService->generateToken($verified_user);

                                   if($token)
                                   {
                                       $token_obj = new \stdClass();
                                       $token_obj->access_token = $token;

                                       $this->responseService->setCode(RC_SUCCESS);
                                       $this->responseService->setMessageEN('success');
                                       $this->responseService->setMessageAR('تمت العملية بنجاح');
                                       $this->responseService->setContent([$token_obj]);
                                   }
                                   else
                                   {
                                       $this->responseService->setCode(RC_TOKEN_ERROR);
                                       $this->responseService->setMessageEN('Error getting access token');
                                       $this->responseService->setMessageAR('حدث خطأ أثناء الحصول على كود تسجيل الدخول');
                                       $this->responseService->setOtherErroMessages('Error generating access token');
                                   }
                               }
                               else
                               {
                                   $this->responseService->setCode(RC_UNAUTHORIZED);
                                   $this->responseService->setMessageEN('Invalid user verification!');
                                   $this->responseService->setMessageAR('تأكد من صحة كود التفعيل');
                                   $this->responseService->setOtherErrorMessages(['Error fetching user with the provided verification code']);
                               }

                            // $code_obj = new \stdClass();
                            // $code_obj->verification_code = $verification_code;

                            // $this->responseService->setCode(RC_SUCCESS);
                            // $this->responseService->setMessageEN('success');
                            // $this->responseService->setMessageAR('تمت العملية بنجاح');
                            // $this->responseService->setContent([$code_obj]);
                            break;
                        default:
                            $this->responseService->setCode(RC_UNAUTHORIZED);
                            $this->responseService->setMessageEN('Invalid user credentials!');
                            $this->responseService->setMessageAR('تأكد أن بيانات الدخول صحيحة!');
                            $this->responseService->setOtherErrorMessages(['Invalid login credentials (email|username|mobile|app_id and password)']);
                            break;
                    }
                }
            }
            else
            {
                $this->responseService->setCode(RC_UNAUTHORIZED);
                $this->responseService->setMessageEN('Invalid user credentials!');
                $this->responseService->setMessageAR('تأكد من أن بيانات الدخول صحيحة و أن المستخدم قد تم تفعيله');
                $this->responseService->setOtherErrorMessages(['بيانات الدخول خاطئة أو المستخدم غير مفعل']);
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));

    }


    /**
     * @return \Phalcon\Http\Response|\Phalcon\Http\ResponseInterface
     * user login flow
     */
    public function loginAction()
    {
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $request_data = $this->validationService->getRequestData($this->request);
            $request_validation = $this->validationService->validateRequest($this->request, ['password','app_id']);

            if(count($request_validation))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setValidationErrorMessages($request_validation);

//                $this->response->setJsonContent($this->responseService->getResponseArray());
//                $this->response->send();die;

                $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));die;
            }

            if(!array_has($request_data, 'email') && !array_has($request_data, 'username')
                && !array_has($request_data, 'mobile') && !array_has($request_data, 'app_id'))
            {
                $validation_error_message[0]['field'] = 'email|username|mobile|app_id';
                $validation_error_message[0]['message'] = 'email OR username OR mobile AND application_id - is required';

                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setValidationErrorMessages($validation_error_message);

//                $this->response->setJsonContent($this->responseService->getResponseArray());
//                $this->response->send();die;

                $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
            }

            $user = identifyUser($request_data);

            if($user)
            {
                $user_status = $this->userSettingsService->checkUserStatus($user, $request_data);
                if($user_status)
                {
                    switch($user_status)
                    {
                        case US_UNAUTHORIZED:
                            $this->responseService->setCode(RC_UNAUTHORIZED);
                            $this->responseService->setMessageEN('Invalid user credentials!');
                            $this->responseService->setMessageAR('تأكد أن بيانات الدخول صحيحة!');
                            $this->responseService->setOtherErrorMessages(['Invalid login credentials (email|username|mobile|app_id and password)']);
                            break;
                        case US_HAS_ACTIVE_TOKEN:
                            if($this->jwtService->expireToken($user))
                            {
                                $verification_code = $this->userSettingsService->getVerificationCode($user);

                                $code_obj = new \stdClass();
                                $code_obj->verification_code = $verification_code;

                                $this->responseService->setCode(RC_SUCCESS);
                                $this->responseService->setMessageEN('success');
                                $this->responseService->setMessageAR('تمت العملية بنجاح');
                                $this->responseService->setContent([$code_obj]);
                            }
                            else
                            {
                                $this->responseService->setCode(RC_LOGIN_ACTIVE_USER_FAILED);
                                $this->responseService->setMessageEN('Error login active user');
                                $this->responseService->setMessageAR('خطأ أثناء تسجيل دخول مستخدم تم دخوله مسبقاً');
                                $this->responseService->setOtherErrorMessages('Error while changing old token');
                            }
                            break;
                        case US_NEEDS_TOKEN:
                            $verification_code = $this->userSettingsService->getVerificationCode($user);

                            $code_obj = new \stdClass();
                            $code_obj->verification_code = $verification_code;

                            $this->responseService->setCode(RC_SUCCESS);
                            $this->responseService->setMessageEN('success');
                            $this->responseService->setMessageAR('تمت العملية بنجاح');
                            $this->responseService->setContent([$code_obj]);
                            break;
                        default:
                            $this->responseService->setCode(RC_UNAUTHORIZED);
                            $this->responseService->setMessageEN('Invalid user credentials!');
                            $this->responseService->setMessageAR('تأكد أن بيانات الدخول صحيحة!');
                            $this->responseService->setOtherErrorMessages(['Invalid login credentials (email|username|mobile|app_id and password)']);
                            break;
                    }
                }
            }
            else
            {
                $this->responseService->setCode(RC_UNAUTHORIZED);
                $this->responseService->setMessageEN('Invalid user credentials!');
                $this->responseService->setMessageAR('تأكد من أن بيانات الدخول صحيحة و أن المستخدم قد تم تفعيله');
                $this->responseService->setOtherErrorMessages(['بيانات الدخول خاطئة أو المستخدم غير مفعل']);
            }
        }

//        $this->response->setJsonContent($this->responseService->getResponseArray());
//        $this->response->send();

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));

    }

    /**
     * request access token for user with the verification code
     */
    public function requestTokenAction()
    {
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
       else
       {
           $validation_result = $this->validationService->validateRequest($this->request, ['verification_code']);

           if(count($validation_result))
           {
               $this->responseService->setCode(RC_VALIDATION_FAILED);
               $this->responseService->setMessageEN('Validation failed');
               $this->responseService->setMessageAR('خطأ');
               $this->responseService->setValidationErrorMessages($validation_result);
           }
           else
           {
               $request_data = $this->validationService->getRequestData($this->request);

               $verified_user = $this->userSettingsService->verifyUser($request_data['verification_code']);

               if($verified_user)
               {
                   $token = $this->jwtService->generateToken($verified_user);

                   if($token)
                   {
                       $token_obj = new \stdClass();
                       $token_obj->access_token = $token;

                       $this->responseService->setCode(RC_SUCCESS);
                       $this->responseService->setMessageEN('success');
                       $this->responseService->setMessageAR('تمت العملية بنجاح');
                       $this->responseService->setContent([$token_obj]);
                   }
                   else
                   {
                       $this->responseService->setCode(RC_TOKEN_ERROR);
                       $this->responseService->setMessageEN('Error getting access token');
                       $this->responseService->setMessageAR('حدث خطأ أثناء الحصول على كود تسجيل الدخول');
                       $this->responseService->setOtherErroMessages('Error generating access token');
                   }
               }
               else
               {
                   $this->responseService->setCode(RC_UNAUTHORIZED);
                   $this->responseService->setMessageEN('Invalid user verification!');
                   $this->responseService->setMessageAR('تأكد من صحة كود التفعيل');
                   $this->responseService->setOtherErrorMessages(['Error fetching user with the provided verification code']);
               }
           }
       }

//        $this->response->setJsonContent($this->responseService->getResponseArray());
//        $this->response->send();

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    /**
     * gets user data based on provided token
     */
    public function userProfileAction()
    {
        if(!$this->request->isGet())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $validation_result = $this->validationService->validateRequest($this->request, ['access_token']);

            if(count($validation_result))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setValidationErrorMessages($validation_result);
            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);

                $user = $this->jwtService->getActiveuser($request_data['access_token']);

                if($user->activeToken)
                {
                    $this->responseService->setCode(RC_SUCCESS);
                    $this->responseService->setMessageEN('success');
                    $this->responseService->setMessageAR('تمت العملية بنجاح');
                    $this->responseService->setContent([$this->jwtService->getActiveuserData($request_data['access_token'])]);
                }
                else
                {
                    $this->responseService->setCode(RC_USER_PROFILE_ERROR);
                    $this->responseService->setMessageEN('Error fetching user profile');
                    $this->responseService->setMessageAR('حدث خطأ أثناء عملية استرجاع بيانات المستخدم');
                    $this->responseService->setOtherErrorMessages(['Error fetching user data, make sure access token is valid']);
                }
            }
        }

//        $this->response->setJsonContent($this->responseService->getResponseArray());
//        $this->response->send();

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    /**
     * handle social login flow
     */
    public function socialLoginAction()
    {
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);

        }
        else
        {
            $validation_result = $this->validationService->validateRequest($this->request, ['social_token','login_type']);

            if(count($validation_result))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setValidationErrorMessages($validation_result);
            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);

                switch($request_data['login_type'])
                {
                    case LoginTypes::facebook():
                        $facebook_response = $this->facebookService
                            ->request([], ['access_token'=>$request_data->social_token])
                            ->get('me');
                        // todo * create user with returned data * save social token * generate verification code and return response
                        break;
                    case LoginTypes::twitter():
                        $token_secret_validation = $this->validationService->validateRequest($this->request, ['social_token_secret']);

                        if(count($token_secret_validation))
                        {
                            $this->responseService->setCode(RC_VALIDATION_FAILED);
                            $this->responseService->setMessageEN('please send token secret');
                            $this->responseService->setMessageAR('من فضلك أرسل الرمز السري');
                            $this->responseService->setValidationErrorMessages($token_secret_validation);
                        }
                        else
                        {
                            $consumer_key    = SocialAppInfo::getConsumerKey(LoginTypes::twitter());
                            $consumer_secret = SocialAppInfo::getConsumerSecret(LoginTypes::twitter());

                            if($consumer_key && $consumer_secret)
                            {
                                $twitter_connection = new TwitterOAuth($consumer_key, $consumer_secret,
                                    $request_data['social_token'], $request_data['social_token_secret']);

                                $user_data = $twitter_connection->get('account/verify_credentials', ['include_email'=>true]);
                                dd($user_data);

                                // todo * create user with returned data * save social token * generate verification code and return response
                            }
                        }
                        break;
                    case LoginTypes::instagram():
                        $instagram_response = $this->instagramService
                            ->request([],['access_token'=>$request_data['social_token']])
                            ->get('users/self');
                        // todo * create user with returned data * save social token * generate verification code and return response
                        break;
                    default:
                        break;
                }
            }
        }
    }

    /**
     * return the available login types
     */
    public function loginTypesAction()
    {
        if(!$this->request->isGet())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $login_types = LoginTypes::find();

            $this->responseService->setCode(RC_SUCCESS);
            $this->responseService->setMessageEN('success');
            $this->responseService->setMessageAR('success');
            $this->responseService->setContent($login_types);
        }

//        $this->response->setJsonContent($this->responseService->getResponseArray());
//        $this->response->send();

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    /**
     * handle reset password flow
     */
    public function resetPasswordAction()
    {
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
       else
       {
           $validation_result = $this->validationService->validateRequest($this->request,
               ['access_token', 'password', 'new_password', 'confirm_password'],
               [],[],['password_field_name'=>'new_password', 'confirm_field_name'=>'confirm_password']);

           if(count($validation_result))
           {
               $this->responseService->setCode(RC_VALIDATION_FAILED);
               $this->responseService->setMessageEN('Validation failed');
               $this->responseService->setMessageAR('خطأ');
               $this->responseService->setValidationErrorMessages($validation_result);
           }
           else
           {
               $request_data = $this->validationService->getRequestData($this->request);

               $user = $this->jwtService->getActiveUser($request_data['access_token']);

               if($user)
               {
                   if($this->security->checkHash($request_data['password'], $user->Pass))
                   {
                       if(strlen($request_data['new_password']) >= 8 && strlen($request_data['new_password']) <= 12) // todo change it and use the validationService->validateRequest
                       {
                           $user->Pass = $this->security->hash($request_data['new_password']);

                           if($user->save())
                           {
                               $this->responseService->setCode(RC_SUCCESS);
                               $this->responseService->setMessageEN('Password changed');
                               $this->responseService->setMessageAR('تم تغيير كلمة السر الخاصة بك');
                               $this->responseService->setContent([userCustomColumns($user)]);
                           }
                       }
                       else
                       {
                           $this->responseService->setCode(RC_CHANGE_PASSWORD_INVALID_NEW_PASSWORD);
                           $this->responseService->setMessageEN('Invalid new password');
                           $this->responseService->setMessageAR('لا يمكن استخدام كلمة السر الجديدة');
                           $this->responseService->setOtherErrorMessages('The sent new password is invalid, it must be at least 8 charcs');
                       }
                   }
                   else
                   {
                       $this->responseService->setCode(RC_CHANGE_PASSWORD_INVALID_PASSWORD);
                       $this->responseService->setMessageEN('Invalid password');
                       $this->responseService->setMessageAR('كلمة السر غير صحيح');
                       $this->responseService->setOtherErrorMessages('The sent password doesn\'t match the user password');
                   }
               }
           }
       }

//        $this->response->setJsonContent($this->responseService->getResponseArray());
//        $this->response->send();

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    public function logoutAction()
    {
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $validation_result = $this->validationService->validateRequest($this->request, [
                'access_token'
            ]);

            if(count($validation_result))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setValidationErrorMessages($validation_result);
            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);

                $user = $this->jwtService->getActiveUser($request_data['access_token']);

                if($user)
                {
                    $logout = $this->jwtService->expireToken($user);

                    if($logout === true)
                    {
                        $this->responseService->setCode(RC_SUCCESS);
                        $this->responseService->setMessageEN('Logout successful');
                        $this->responseService->setMessageAR('تم تسجيل الخروج');
                    }
                    else
                    {
                        $this->responseService->setCode(RC_LOGOUT_FAIL);
                        $this->responseService->setMessageEN('Error logging you out');
                        $this->responseService->setMessageAR('خطأ أثناء تسجيل الخروج');
                        $this->responseService->setOtherErrorMessages($logout->getMessages());
                    }
                }
                else
                {
                    $this->responseService->setCode(RC_UNAUTHORIZED);
                    $this->responseService->setMessageEN('Invalid user!');
                    $this->responseService->setMessageAR('خطأ أثناء التعرف على المستخدم');
                    $this->responseService->setOtherErrorMessages(['Error identifying user']);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    public function checkEmailAction()
    {
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $validation_result = $this->validationService->validateRequest($this->request,
                ['email', 'app_id'], ['email']);

            if(count($validation_result))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setOtherErrorMessages($validation_result);
            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);

                $user_exists = UsersMobile::findFirst([
                    'Mail = {email} and Application_ID = {app_id}',
                    'bind'   => [
                    'email'  => $request_data['email'],
                    'app_id' => $request_data['app_id']
                    ]
                    ]);

                if($user_exists)
                {
                    $this->responseService->setCode(RC_SUCCESS);
                    $this->responseService->setMessageEN('Email exists');
                    $this->responseService->setMessageAR('Email exists');
                    $this->responseService->setContent(['email_exists' => 1]);
                }
                else
                {
                    $this->responseService->setCode(RC_UNAUTHORIZED);
                    $this->responseService->setMessageEN('Email does not exist');
                    $this->responseService->setMessageAR('البريد الإلكتروني غير صحيح');
                    $this->responseService->setContent([['email_exists' => 0]]);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    public function changePasswordAction()
    {
        if(!$this->request->isPost())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $validation_result = $this->validationService->validateRequest($this->request,
                ['email', 'app_id', 'new_password', 'confirm_password'], // required
                ['email'], // email
                [], // alphanumeric
                ['password_field_name'=>'new_password','confirm_field_name'=>'confirm_password'], // password confirm
                [], // files
                ['fields'=>[ // min-max string length
                        ['name'=>'new_password','min'=>8,'max'=>20],
                        ['name'=>'confirm_password','min'=>8,'max'=>20]]]);

            if(count($validation_result))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('خطأ');
                $this->responseService->setOtherErrorMessages($validation_result);
            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);

                $user = UsersMobile::findFirst([
                    'Mail = {email} and Application_ID = {app_id}',
                    'bind'   => [
                    'email'  => $request_data['email'],
                    'app_id' => $request_data['app_id']
                    ]
                    ]);

                if(!$user)
                {
                    $this->responseService->setCode(RC_VALIDATION_FAILED);
                    $this->responseService->setMessageEN('Validation failed');
                    $this->responseService->setMessageAR('خطأ');
                    $this->responseService->setOtherErrorMessages([
                        ['field' => 'email', 'message' => 'Wrong email']
                        ]);
                }
                else
                {
                    $user->Pass = $this->security->hash($request_data['new_password']);

                    if($user->save())
                    {
                        $this->responseService->setCode(RC_SUCCESS);
                        $this->responseService->setMessageEN('Password changed');
                        $this->responseService->setMessageAR('Password changed');
                        $this->responseService->setContent([$user]);
                    }
                    else
                    {
                        $this->responseService->setCode(RC_VALIDATION_FAILED);
                        $this->responseService->setMessageEN('Validation failed');
                        $this->responseService->setMessageAR('خطأ');
                        $this->responseService->setOtherErrorMessages($user->getMessages);
                    }
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }
}