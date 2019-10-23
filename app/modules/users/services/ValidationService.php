<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/28/2017
 * Time: 3:17 PM
 */

namespace Vokuro\UsersModule\Services;


use Phalcon\Validation;
use Vokuro\UsersModule\ServicesInterfaces\ValidationServiceInterface;
use Phalcon\Validation\Validator\File as FileValidator;

class ValidationService implements ValidationServiceInterface
{
    private $validator;

    private function __construct(){}

    public static function _instantiate()
    {
        static $instance = null;

        if($instance === null)
        {
            $instance = new ValidationService();

            $instance->validator = new Validation();
        }

        return $instance;
    }

    public function getValidator()
    {
        return $this->validator;
    }

    public function getRequestData($request)
    {
        $request_data = null;
        $content_type = $request->getContentType();
        $method = $request->getMethod();

        switch($method) {
            case 'POST':
                if ($content_type === 'application/json')
                {
                    if (isset($request->getJsonRawBody()->data))
                    {
                        if (@\GuzzleHttp\json_decode($request->getJsonRawBody()->data, true))
                        {
                            $request_data = @\GuzzleHttp\json_decode($request->getJsonRawBody()->data, true);
                        }
                        else
                        {
                            $request_data = (array)$request->getJsonRawBody()->data;
                        }
                    }
                    else
                    {
                        $request_data = $request->getJsonRawBody(true);
                    }
                }
                elseif ($content_type === 'application/x-www-form-urlencoded')
                {
                    $request_data = $request->get();
                }
                else
                {
                    $without_url = $request->get();
                    unset($without_url['_url']);

                    if(count($without_url))
                    {
                        $request_data = $request->get();
                    }
                    elseif(count($request->getPost()))
                    {
                        $request_data = $request->getPost();
                    }
                    else
                    {
                        if (isset($request->getJsonRawBody()->data))
                        {
                            if (@\GuzzleHttp\json_decode($request->getJsonRawBody()->data, true))
                            {
                                $request_data = @\GuzzleHttp\json_decode($request->getJsonRawBody()->data, true);
                            }
                            else
                            {
                                $request_data = (array)$request->getJsonRawBody()->data;
                            }
                        }
                        else
                        {
                            $request_data = $request->getJsonRawBody(true);
                        }
                    }
                }
                break;
            case 'GET':
                $request_data = $request_data = $request->get();
                break;
            case 'DELETE':
                if ($content_type === 'application/json')
                {
                    if (isset($request->getJsonRawBody()->data))
                    {
                        if (@\GuzzleHttp\json_decode($request->getJsonRawBody()->data, true))
                        {
                            $request_data = @\GuzzleHttp\json_decode($request->getJsonRawBody()->data, true);
                        }
                        else
                        {
                            $request_data = (array)$request->getJsonRawBody()->data;
                        }
                    }
                    else
                    {
                        $request_data = $request->getJsonRawBody(true);
                    }
                }
                elseif ($content_type === 'application/x-www-form-urlencoded')
                {
                    $request_data = $request->get();
                }
                else
                {
                    $without_url = $request->get();
                    unset($without_url['_url']);

                    if(count($without_url))
                    {
                        $request_data = $request->get();
                    }
                    elseif(count($request->getPost()))
                    {
                        $request_data = $request->getPost();
                    }
                    else
                    {
                        if (isset($request->getJsonRawBody()->data))
                        {
                            if (@\GuzzleHttp\json_decode($request->getJsonRawBody()->data, true))
                            {
                                $request_data = @\GuzzleHttp\json_decode($request->getJsonRawBody()->data, true);
                            }
                            else
                            {
                                $request_data = (array)$request->getJsonRawBody()->data;
                            }
                        }
                        else
                        {
                            $request_data = $request->getJsonRawBody(true);
                        }
                    }
                }
                break;
            default:
                break;
        }

        return $request_data;
    }

    public function validateRequest($request, $required=[], $email=[], $alnum=[],$numeric=[],
        $password_confirm=['password_field_name'=>'', 'confirm_field_name'=>''], $file=[],
        $stringLen=['fields'=>[['name'=>'', 'min'=>8, 'max'=>20]]])
    {
        $request_data = ($this->getRequestData($request))?$this->getRequestData($request):[];
        $validation_messages = [];
        //Get lang_id for validation messages
        $lang_id = $request_data["lang_id"];
        // required
        if(count($required))
        {
            foreach($required as $item)
            {

                if($lang_id==1){
                    $this->validator->add(
                        $item,
                        new Validation\Validator\PresenceOf([
                            "message" => $item .' - هذا الحقل مطلوب'
                        ])
                    );
                }else{
                    $this->validator->add(
                        $item,
                        new Validation\Validator\PresenceOf([
                            "message" => $item .' - This Field is Required'
                        ])
                    );
                }
            }
        }

        // email
        if(count($email))
        {
            foreach($email as $item)
            {
                if(array_has($request_data, $item))
                {
                    if($lang_id==1)
                    {
                        $this->validator->add(
                        $item,
                        new Validation\Validator\Email([
                            "message" => $item . ' - هذا الحقل يجب أن يكون بريد إلكتروني صحيح'
                        ])
                        );
                    }
                    else{
                        $this->validator->add(
                            $item,
                            new Validation\Validator\Email([
                                "message" => $item . ' - This Field must be an email'
                            ])
                        );
                    }
                }
            }
        }

        // alpha numeric
        if(count($alnum))
        {
            foreach($alnum as $item)
            {
                if(array_has($request_data, $item))
                {
                    if($lang_id==1){
                        $this->validator->add(
                            $item,
                            new Validation\Validator\Alnum([
                                'message' => $item . ' - هذا الحقل يجب أن يحتوي على أرقام و حروف فقط'
                            ])
                        );
                    }else{
                        $this->validator->add(
                            $item,
                            new Validation\Validator\Alnum([
                                'message' => $item . ' - This Field must contain numbers and letters only'
                            ])
                        );
                    }


                }
            }
        }

        if(count($numeric))
        {
            foreach($numeric as $item)
            {
                if(array_has($request_data, $item))
                {
                    if($lang_id==1){
                        $this->validator->add(
                            $item,
                            new Validation\Validator\Numericality([
                                'message' => $item . ' - هذا الحقل يجب أن يحتوي على أرقام  فقط'
                            ])
                        );
                    }else{
                        $this->validator->add(
                            $item,
                            new Validation\Validator\Numericality([
                                'message' => $item . ' - This Field must contain numbers only'
                            ])
                        );
                    }


                }
            }
        }

        // file
        if(count($file))
        {
            if($request->hasFiles())
            {
                foreach($file as $item)
                {
                    if($lang_id==1){
                        $this->validator->add(
                            $item,
                            new FileValidator([
                                'maxSize' => '2M',
                                'messageSize' => $item . ' - حجم الملف يجب أن يكون بحد أقصى (:max) ميجابايت',
                            ])
                        );
                    }else{
                        $this->validator->add(
                            $item,
                            new FileValidator([
                                'maxSize' => '2M',
                                'messageSize' => $item . ' - File Size must be less than 2M',
                            ])
                        );
                    }

                }
            }
        }

        // password confirm
        if(isset($password_confirm['password_field_name']) && isset($password_confirm['confirm_field_name']) && strlen($password_confirm['password_field_name']) && strlen($password_confirm['confirm_field_name']))
        {
            if(array_has($request_data, $password_confirm['password_field_name']) && array_has($request_data, $password_confirm['confirm_field_name']))
            {
                if($lang_id==1){
                    $this->validator->add(
                        $password_confirm['password_field_name'],
                        new Validation\Validator\Confirmation([
                            'message' => 'كلمة المرور غير متطابقة',
                            'with' => $password_confirm['confirm_field_name']
                        ])
                    );
                }
                else{
                    $this->validator->add(
                        $password_confirm['password_field_name'],
                        new Validation\Validator\Confirmation([
                            'message' => 'Password Does Not Match',
                            'with' => $password_confirm['confirm_field_name']
                        ])
                    );
                }

            }
        }

        // string length
        if(count($stringLen['fields'])) // todo to be tested ****
        {
            foreach($stringLen['fields'] as $item)
            {
                if(array_has($request_data, $item['name']))
                {
                    if($lang_id==1){
                        $this->validator->add(
                            $item['name'],
                            new Validation\Validator\StringLength([
                                'max' => $item['max'],
                                'min' => $item['min'],
                                'messageMaximum' => $item['name'] . ' - الحقل يجب أن يكون بحد أقصى (:max)',
                                'messageMinimum' => $item['name'] . ' - الحقل يجب أن يكون بحد أدنى (:min)'
                            ])
                        );
                    }else{
                        $this->validator->add(
                            $item['name'],
                            new Validation\Validator\StringLength([
                                'max' => $item['max'],
                                'min' => $item['min'],
                                'messageMaximum' => $item['name'] . ' - Field Must be maximum (:max)',
                                'messageMinimum' => $item['name'] . ' - Field Must be Minimum (:min)'
                            ])
                        );
                    }

                }
            }
        }

        $validation_result = $this->validator->validate($request_data);

        if(count($validation_result))
        {
            $count = 0;
            foreach($validation_result as $message)
            {
                $validation_messages[$count]['field'] = $message->getField();
                $validation_messages[$count]['message'] = $message->getMessage();
                $count++;
            }
        }

        return $validation_messages;
    }

//    public function validateDataArrayRequest($request, $required=[], $email=[], $alnum=[],
//                                    $password_confirm=['password_field_name'=>'', 'confirm_field_name'=>''], $file=[],
//                                    $stringLen=['fields'=>[['name'=>'', 'min'=>8, 'max'=>20]]])
//    {
//        $data = $this->getRequestData($request);
//        $validation_messages = [];
//
//        if($this->requestHas($request, 'data_array'))
//        {
//            $data_array = null;
//
//            if($request->getContentType() === 'application/json')
//            {
//                $data_array = $request->getJsonRawBody()->data_array;
//            }
//            else
//            {
//                if($request->getMethod() === 'POST')
//                {
//                    $data_array = $request->getPost('data_array');
//                }
//                elseif($request->getMethod() === 'GET')
//                {
//                    $data_array = $request->get('data_array');
//                }
//            }
//
//            // required
//            if(count($required))
//            {
//                foreach($required as $item)
//                {
//                    $this->validator->add(
//                        $item,
//                        new Validation\Validator\PresenceOf([
//                            "message" => $item .' - is required'
//                        ])
//                    );
//                }
//            }
//
//            // email
//            if(count($email))
//            {
//                foreach($email as $item)
//                {
//                    if(array_has($data_array, $item))
//                    {
//                        $this->validator->add(
//                            $item,
//                            new Validation\Validator\Email([
//                                "message" => $item . ' - must be an email'
//                            ])
//                        );
//                    }
//                }
//            }
//
//            // alpha numeric
////            if(count($alnum))
////            {
////                foreach($alnum as $item)
////                {
////                    if(array_has($data_array, $item))
////                    {
////                        $this->validator->add(
////                            $item,
////                            new Validation\Validator\Alnum([
////                                'message' => $item . ' - must only contain alpha-numeric values'
////                            ])
////                        );
////                    }
////                }
////            }
//
//            // file
//            if(count($file))
//            {
//                if($request->hasFiles())
//                {
//                    foreach($file as $item)
//                    {
//                        $this->validator->add(
//                            $item,
//                            new FileValidator([
//                                'maxSize' => '2M',
//                                'messageSize' => $item . ' - exceeded the max file size of (:max)',
//                            ])
//                        );
//                    }
//                }
//            }
//
//            // password confirm
//            if(strlen($password_confirm['password_field_name']) && strlen($password_confirm['confirm_field_name']))
//            {
//                if(array_has($data_array, $password_confirm['password_field_name']) && array_has($data_array, $password_confirm['confirm_field_name']))
//                {
//                    $this->validator->add(
//                        $password_confirm['password_field_name'],
//                        new Validation\Validator\Confirmation([
//                            'message' => 'Passwords don\'t match',
//                            'with' => $password_confirm['confirm_field_name']
//                        ])
//                    );
//                }
//            }
//
//            // string length
//            if(count($stringLen['fields'])) // todo to be tested ****
//            {
//                foreach($stringLen['fields'] as $item)
//                {
//                    if(array_has($data_array, $item['name']))
//                    {
//                        $this->validator->add(
//                            $item['name'],
//                            new Validation\Validator\StringLength([
//                                'max' => $item['max'],
//                                'min' => $item['min'],
//                                'messageMaximum' => $item['name'] . ' - is too long',
//                                'messageMinimum' => $item['name'] . ' - is too short'
//                            ])
//                        );
//                    }
//                }
//            }
//
//            $validation_result = $this->validator->validate($data_array);
//
//            if(count($validation_result))
//            {
//                $count = 0;
//                foreach($validation_result as $message)
//                {
//                    $validation_messages[$count]['field'] = $message->getField();
//                    $validation_messages[$count]['message'] = $message->getMessage();
//                    $count++;
//                }
//            }
//        }
//        else
//        {
//            $validation_messages[0]['field'] = 'data_array';
//            $validation_messages[0]['message'] = 'Invalid request structure';
//        }
//
//        return $validation_messages;
//    }

    private function requestHas($request, $item)
    {
        if($request->getContentType() === 'application/json')
        {
            return isset($request->getJsonRawBody()->$item);
        }

        return $request->has($item);
    }

}