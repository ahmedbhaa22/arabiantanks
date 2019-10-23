<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/25/2017
 * Time: 9:52 PM
 */

namespace Vokuro\UsersModule\Controllers;


use Models\NewsLetter;
use Models\UsersMobile;
use Vokuro\Cart\Models\Orders;
use Vokuro\UsersModule\Models\UserAddresses;
use \Vokuro\Pentavalue\Base64ToImageService;

class UserController extends AuthControllerBase
{
    /**
     * @param $access_token
     * get add user addresses
     */
    public function addressesAction($access_token, $address_id=null)
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
            if(!isset($access_token))
            {
                $this->responseService->setCode(RC_VALIDATION_FAILED);
                $this->responseService->setMessageEN('Validation failed');
                $this->responseService->setMessageAR('???');
                $this->responseService->setValidationErrorMessages(['access_token - is required']);
            }
            else
            {
                $user = $this->jwtService->getActiveUser($access_token);

                if($user)
                {
                    if(!isset($address_id))
                    {
                        $addresses = UserAddresses::find([
                            'user_id = {user_id}',
                            'bind' => [
                                'user_id' => $user->ID
                            ]
                        ])->toArray();
//                        $addresses = (count($user->shippingAddresses))?$user->shippingAddresses->toArray():[];
                    }
                    else
                    {
                        $addresses = (UserAddresses::findFirst($address_id))?
                            [UserAddresses::findFirst($address_id)->toArray()]:[];
                    }
                    $this->responseService->setCode(RC_SUCCESS);
                    $this->responseService->setMessageEN('success');
                    $this->responseService->setMessageAR('تمت العملية بنجاح');
                    $this->responseService->setContent($addresses);
                }
                else
                {
                    $this->responseService->setCode(RC_UNAUTHORIZED);
                    $this->responseService->setMessageEN('Error fetching user profile');
                    $this->responseService->setMessageAR('??? ??? ????? ????? ??????? ?????? ????????');
                    $this->responseService->setOtherErrorMessages(['Error fetching user data, make sure access token is valid']);
                }

            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    /**
     * add new address
     */
    public function addAddressAction()
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
            $validation_result = $this->validationService->validateRequest($this->request,[
                'access_token', 'country_id', 'city_id', 'region_id', 'details', 'postal_code'
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
                $request_data = $this->validationService->getRequestData($this->request);

                try
                {
                    $user = $this->jwtService->getActiveUser($request_data['access_token']);

                    if($user)
                    {
                        $user_address = new UserAddresses();
                        $create_address_result = $user_address->createNewAddress($request_data, $user);

                        if($create_address_result['code'] === 1)
                        {
                            $this->responseService->setCode(RC_SUCCESS);
                            $this->responseService->setMessageEN('Success');
                            $this->responseService->setMessageAR('تمت العملية بنجاح');
                            $this->responseService->setContent([$create_address_result['created_address']]);
                        }
                        else
                        {
                            $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                            $this->responseService->setMessageEN('Error creating user address');
                            $this->responseService->setMessageAR('خطأ أثناء انشاء العنوان');
                            $this->responseService->setOtherErrorMessages($create_address_result['messages']);
                        }
                    }
                    else
                    {
                        $this->responseService->setCode(RC_UNAUTHORIZED);
                        $this->responseService->setMessageEN('Error fetching user');
                        $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                        $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                    }
                }
                catch(\Exception $e)
                {
                    $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                    $this->responseService->setMessageEN('Error creating address, try again');
                    $this->responseService->setMessageAR('خطأ أثناء انشاء العنوان، حاول مرو أخرى');
                    $this->responseService->setOtherErrorMessages([$e->getMessage()]);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    /**
     * make address as main
     */
    public function setMainAddressAction()
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
                'access_token', 'address_id'
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
                $request_data = $this->validationService->getRequestData($this->request);

                try
                {
                    $user = $this->jwtService->getActiveUser($request_data['access_token']);

                    if($user)
                    {
                        $set_main_result = UserAddresses::setMain($request_data['address_id']);

                        if($set_main_result['code'] === 1)
                        {
                            $this->responseService->setCode(RC_SUCCESS);
                            $this->responseService->setMessageEN('Success');
                            $this->responseService->setMessageAR('تمت العملية بنجاح');
                            $this->responseService->setContent([$set_main_result['updated_address']]);
                        }
                        else
                        {
                            $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                            $this->responseService->setMessageEN('Error setting main address');
                            $this->responseService->setMessageAR('خطأ أثناء انشاء العنوان الرئيسي');
                            $this->responseService->setOtherErrorMessages($set_main_result['messages']);
                        }
                    }
                    else
                    {
                        $this->responseService->setCode(RC_UNAUTHORIZED);
                        $this->responseService->setMessageEN('Error fetching user');
                        $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                        $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                    }
                }
                catch(\Exception $e)
                {
                    $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                    $this->responseService->setMessageEN('Error setting main address');
                    $this->responseService->setMessageAR('خطأ أثناء انشاء العنوان الرئيسي');
                    $this->responseService->setOtherErrorMessages([$e->getMessage()]);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    public function deleteAddressAction()
    {
        if(!$this->request->isDelete())
        {
            $this->responseService->setCode(RC_WRONG_HTTP_METHOD);
            $this->responseService->setMessageEN('Error!');
            $this->responseService->setMessageAR('خطأ!');
            $this->responseService->setOtherErrorMessages(['Wrong http method :'.$this->request->getMethod().':']);
        }
        else
        {
            $validation_result = $this->validationService->validateRequest($this->request, [
                'access_token', 'address_id'
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
                $request_data = $this->validationService->getRequestData($this->request);

                try
                {
                    $user = $this->jwtService->getActiveUser($request_data['access_token']);

                    if($user)
                    {
                        $delete_address_result = UserAddresses::deleteAddress($request_data['address_id']);

                        if($delete_address_result['code'] === 1)
                        {
                            $this->responseService->setCode(RC_SUCCESS);
                            $this->responseService->setMessageEN('Success');
                            $this->responseService->setMessageAR('تمت العملية بنجاح');
                            $this->responseService->setContent($user->shippingAddresses);
                        }
                        else
                        {
                            $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                            $this->responseService->setMessageEN('Error deleting address');
                            $this->responseService->setMessageAR('خطأ أثناء مسح العنوان');
                            $this->responseService->setOtherErrorMessages($delete_address_result['messages']);
                        }
                    }
                    else
                    {
                        $this->responseService->setCode(RC_UNAUTHORIZED);
                        $this->responseService->setMessageEN('Error fetching user');
                        $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                        $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                    }
                }
                catch(\Exception $e)
                {
                    $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                    $this->responseService->setMessageEN('Error setting main address');
                    $this->responseService->setMessageAR('خطأ أثناء انشاء العنوان الرئيسي');
                    $this->responseService->setOtherErrorMessages([$e->getMessage()]);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    /**
     * update address
     */
    public function updateAddressAction()
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
            $validation_result = $this->validationService->validateRequest($this->request,[
                'access_token','address_id', 'country_id', 'city_id', 'region_id', 'details', 'postal_code'
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
                $request_data = $this->validationService->getRequestData($this->request);

                try
                {
                    $user = $this->jwtService->getActiveUser($request_data['access_token']);

                    if($user)
                    {
                        $user_address = UserAddresses::findFirst([
                            'id = {address_id}',
                            'bind' => [
                                'address_id' => $request_data['address_id']
                            ]
                        ]);

                        if($user_address)
                        {
                            $update_address_result = UserAddresses::updateAddress($user_address, $request_data);

                            if($update_address_result['code'] === 1)
                            {
                                $this->responseService->setCode(RC_SUCCESS);
                                $this->responseService->setMessageEN('Success');
                                $this->responseService->setMessageAR('تمت العملية بنجاح');
                                $this->responseService->setContent([$update_address_result['updated_address']]);
                            }
                            else
                            {
                                $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                                $this->responseService->setMessageEN('Error creating user address');
                                $this->responseService->setMessageAR('خطأ أثناء انشاء العنوان');
                                $this->responseService->setOtherErrorMessages($update_address_result['messages']);
                            }
                        }
                        else
                        {
                            $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                            $this->responseService->setMessageEN('Error editing address, try again');
                            $this->responseService->setMessageAR('خطأ أثناء تعديل العنوان، حاول مرة أخرى');
                            $this->responseService->setOtherErrorMessages(['Address doesn\'t exist']);
                        }
                    }
                    else
                    {
                        $this->responseService->setCode(RC_UNAUTHORIZED);
                        $this->responseService->setMessageEN('Error fetching user');
                        $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                        $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                    }
                }
                catch(\Exception $e)
                {
                    $this->responseService->setCode(RC_USER_ADDRESS_ERROR);
                    $this->responseService->setMessageEN('Error editing address, try again');
                    $this->responseService->setMessageAR('خطأ أثناء تعديل العنوان، حاول مرة أخرى');
                    $this->responseService->setOtherErrorMessages([$e->getMessage()]);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    /**
     * get user orders
     */
    public function ordersAction()
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
            $validation_result = $this->validationService->validateRequest($this->request,[
                'access_token'
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
                $request_data = $this->validationService->getRequestData($this->request);

                $user = $this->jwtService->getActiveUser($request_data['access_token']);

                if($user)
                {
                    $user_orders = [];

                    foreach($user->orders as $order)
                    {
                        $order_status = $order->statusDetails->display_name;
                        $order = $order->toArray();
                        if($order["payment_receipt"]!=""){
                            $order["payment_receipt"]="http://arabiatanks.com/tanks_project/".$order["payment_receipt"];
                        }

                        //Get Order Address
                        $address_id= $order["address_id"];
                        $addresses = (UserAddresses::findFirst($address_id))?
                            [UserAddresses::findFirst($address_id)->toArray()]:[];
                        $addresses[0]["country_name"]="";
                        $addresses[0]["city_name"]="";
                        $addresses[0]["region_name"]="";
                        $order["address_details"] = $addresses;
                        if($order["user_comment"] == null){
                            $order["user_comment"] = "";
                        }

                        $order['status_name'] = $order_status;


                        $order_items = Orders::getDetailed($order["user_id"], $order['status'])['items'];
                        $order['items'] = [];

                        for($i = 0; $i < count($order_items['cms']); $i++)
                        {
                            if($this->apiFactory->getOrderItemCmsDetails($order_items['cms'][$i]['id']))
                            {
                                $order['items'][] = $this->apiFactory->getOrderItemCmsDetails($order_items['cms'][$i]['id']);
                            }
                        }

                        for($i = 0; $i < count($order_items['offers']); $i++)
                        {
                            if($this->apiFactory->getOrderItemOfferDetails($order_items['offers'][$i]['id']))
                            {
                                $order['items'][] = $this->apiFactory->getOrderItemOfferDetails($order_items['offers'][$i]['id']);
                            }
                        }

                        $user_orders[] = $order;
                    }

                    $this->responseService->setCode(RC_SUCCESS);
                    $this->responseService->setMessageEN('Success');
                    $this->responseService->setMessageAR('تمت العملية بنجاح');
                    $this->responseService->setContent($user_orders);
                }
                else
                {
                    $this->responseService->setCode(RC_UNAUTHORIZED);
                    $this->responseService->setMessageEN('Error fetching user');
                    $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                    $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    public function changeProfileImageAction()
    {
        // var_dump(BASE_PATH);die;
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
                [
                    'access_token', 'profile_image'
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
                $request_data = $this->validationService->getRequestData($this->request);

                $user = $this->jwtService->getActiveUser($request_data['access_token']);

                if($user)
                {
                    $base64_to_img = new Base64ToImageService('uploads/users');
                    $profile_image = $base64_to_img->convert($request_data['profile_image']);

                    if($profile_image !== false)
                    {
                        // var_dump($user->toArray());die;
                        $user->Img = $profile_image;

                        if(!$user->save())
                        {
                            $this->responseService->setCode(RC_USER_PROFILE_ERROR);
                            $this->responseService->setMessageEN('Changing image error, please try again');
                            $this->responseService->setMessageAR('حدث خطأ أثناء تغيير الصورة، من فضلك حاول مرة أخرى');
                            $this->responseService->setOtherErrorMessages([$user->getSaveErrors()]);
                        }
                        else
                        {
                            $this->responseService->setCode(RC_SUCCESS);
                           $this->responseService->setMessageEN('Profile Image changed');
                           $this->responseService->setMessageAR('تم تغيير الصورة الخاصة بك');
                           $this->responseService->setContent([userCustomColumns($user, $this->url->getStatic())]);
                        }
                    }
                }
                else
                {
                    $this->responseService->setCode(RC_UNAUTHORIZED);
                    $this->responseService->setMessageEN('Error fetching user');
                    $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                    $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    public function editProfileAction()
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
            $validation_result = $this->validationService->validateRequest($this->request,[
                'access_token'
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
                $request_data = $this->validationService->getRequestData($this->request);

                $user = $this->jwtService->getActiveUser($request_data['access_token']);

                if($user)
                {
                    unset($request_data['access_token']);

                    if(count($request_data) === 0)
                    {
                        $this->responseService->setCode(RC_USER_PROFILE_ERROR);
                        $this->responseService->setMessageEN('No data to use in update');
                        $this->responseService->setMessageAR('لا توجد بيانات للتعديل');
                        $this->responseService->setOtherErrorMessages(['No data to use in update']);
                    }
                    else
                    {
                        $update_result = $user->editProfile($request_data);

                        if($update_result['status'] !== 1)
                        {
                            $this->responseService->setCode(RC_USER_PROFILE_ERROR);
                            $this->responseService->setMessageEN('Error updating user');
                            $this->responseService->setMessageAR('خطأ أثناء تعديل العميل');
                            $this->responseService->setOtherErrorMessages($update_result['messages']);
                        }
                        else
                        {
                            $this->responseService->setCode(RC_SUCCESS);
                            $this->responseService->setMessageEN('Success');
                            $this->responseService->setMessageAR('تمت العملية بنجاح');
                            $this->responseService->setContent($update_result['content']);
                        }
                    }
                }
                else
                {
                    $this->responseService->setCode(RC_UNAUTHORIZED);
                    $this->responseService->setMessageEN('Error fetching user');
                    $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                    $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    public function userSubscribedInNewsLetterAction()
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
            $validation_result = $this->validationService->validateRequest($this->request,[
                'access_token'
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
                $request_data = $this->validationService->getRequestData($this->request);

                $user = $this->jwtService->getActiveUser($request_data['access_token']);

                if($user)
                {
                    $user_subscribed = NewsLetter::findFirst([
                        'mail like {email}',
                        'bind' => [
                            'email' => $user->Mail
                        ]
                    ]);

                    $user_subscribed = (!$user_subscribed)?$user_subscribed:true;

                    $this->responseService->setCode(RC_SUCCESS);
                    $this->responseService->setMessageEN('Success');
                    $this->responseService->setMessageAR('تمت العملية بنجاح');
                    $this->responseService->setContent(['subscribed' => $user_subscribed]);
                }
                else
                {
                    $this->responseService->setCode(RC_UNAUTHORIZED);
                    $this->responseService->setMessageEN('Error fetching user');
                    $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                    $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }

    public function newsletterUnsubscribeAction()
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
                $this->responseService->setMessageEN('Error!');
                $this->responseService->setMessageAR('خطأ!');
                $this->responseService->setValidationErrorMessages($validation_result);
            }
            else
            {
                $request_data = $this->validationService->getRequestData($this->request);

                $user = $this->jwtService->getActiveUser($request_data['access_token']);

                if($user)
                {
                    $unsubsription = NewsLetter::unsubscribe($user);

                    if(!$unsubsription)
                    {
                        $this->responseService->setCode(0);
                        $this->responseService->setMessageEN('Error');
                        $this->responseService->setMessageAR('خطأ');
                        $this->responseService->setOtherErrorMessages(['Error unsubscriping user from newsletter']);
                    }
                    else
                    {
                        $this->responseService->setCode(RC_SUCCESS);
                        $this->responseService->setMessageEN('Success');
                        $this->responseService->setMessageAR('تمت العملية بنجاح');
                        $this->responseService->setContent(['unsubscribed' => $unsubsription]);
                    }
                }
                else
                {
                    $this->responseService->setCode(RC_UNAUTHORIZED);
                    $this->responseService->setMessageEN('Error fetching user');
                    $this->responseService->setMessageAR('خطأ أثناء محاولة التعرف على المستخدم');
                    $this->responseService->setOtherErrorMessages(['Please make sure that the access token is valid']);
                }
            }
        }

        $this->sendJson($this->responseService->getCustomResponse($this->apiFactory));
    }
}