<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 11/29/2017
 * Time: 11:18 AM
 */

namespace Vokuro\Pentavalue;

use Phalcon\Validation;
use Phalcon\Validation\Validator\File as FileValidator;
use Phalcon\Validation\Validator\Numericality;
use Phalcon\Validation\Validator\Callback as CallbackValidator;


class RequestValidation
{
    private $request;
    private $validator;
    private $request_array;

    public function __construct($request)
    {
        $this->request       = $request;
        $this->validator     = new Validation();
        $this->request_array = $this->requestToArray($request);
    }

    private function requestToArray($request)
    {
        $request_array = [];

        switch($request->getMethod())
        {
            case 'POST':
                $request_array = $this->extractData($request);
                break;
            case 'PUT':
                $request_array = $this->extractData($request);
                break;
            case 'DELETE':
                $request_array = $this->extractData($request);
                break;
            case 'GET':
                $request_array = $request->get();
                break;
            default:
                $request_array = [];
                break;
        }

        return $request_array;
    }

    private function extractData($request)
    {
        $data = [];

        if($request->getContentType() === 'application/json')
        {
            $data = $request->getJsonRawBody(true);
        }
        else
        {
            $data = $request->getPost();
        }

      return $data;
    }

    public function getRequest()
    {
        return $this->request;
    }

    public function getRequestArray()
    {
        return $this->request_array;
    }

    public function setRequestArray($request_array)
    {
        $this->request_array = $request_array;
    }

    public function required($fields=[], $translation=null)
    {
        // validate required

        $msg = $translation?$translation->_("required"):" - required";
        foreach($fields as $field)
        {
            $this->validator->add(
                $field,
                new Validation\Validator\PresenceOf([
                    "message" => $field . $msg
                ])
            );
        }

        return $this;
    }

    public function email($fields=[], $translation=null)
    {
        // validate email

        $msg = $translation?$translation->_("email_format"):" - not email format";
        foreach($fields as $field)
        {
            if(array_key_exists($field, $this->request_array))
            {
                $this->validator->add(
                    $field,
                    new Validation\Validator\Email([
                        "message" => $field . $msg
                    ])
                );
            }
        }

        return $this;
    }

    public function alnum($fields=[], $translation=null)
    {
        // validate alpha numeric

        $msg = $translation?$translation->_("alnum_format"):" - not alnum format";
        foreach($fields as $field)
        {
            if(array_key_exists($field, $this->request_array))
            {
                $this->validator->add(
                    $field,
                    new Validation\Validator\Alnum([
                        "message" => $field . $msg
                    ])
                );
            }
        }

        return $this;
    }

    public function numeric($fields=[])
    {
        $this->validator->add(
            $fields,
            new Numericality([
                "message" => ":field must be numeric"
                ])
        );

        return $this;
    }

    public function integer($fields=[])
    {
        foreach($fields as $field)
        {
            $this->validator->add(
            $field,
            new CallbackValidator([
                    "message"  => ":field must be integer",
                    "callback" => function($data) use($field)
                    {
                        return is_int($data[$field]);
                    }
                ])
        );
        }

        return $this;
    }

    public function passwordConfirm($password_field, $confirm_password_field, $translation=null)
    {
        // confirm password

        $msg = $translation?$translation->_("confirm_password"):"Passwords didn\'t match";
        if(array_key_exists($password_field, $this->request_array) && array_key_exists($confirm_password_field, $this->request_array))
        {
            $this->validator->add(
                $password_field,
                new Validation\Validator\Confirmation([
                    "with"    => $confirm_password_field,
                    "message" => $msg
                ])
            );
        }

        return $this;
    }

    public function stringLength($field, $min, $max, $translation=null)
    {
        // validate field length

        $max_msg = $translation?$translation->_("max", ['max'=>$max]):" - must be maximum $max chars";
        $min_msg = $translation?$translation->_("min", ['min'=>$min]):" - must be minimum $min chars";
        if(array_key_exists($field, $this->request_array))
        {
            $this->validator->add(
                $field,
                new Validation\Validator\StringLength([
                    "max" => $max,
                    "min" => $min,
                    "messageMaximum" => $field . $max_msg,
                    "messageMinimum" => $field . $min_msg
                ])
            );
        }

        return $this;
    }

    public function files($fields=[])
    {
        // validate files fields

        if($this->request->hasFiles())
        {
            foreach($fields as $file)
            {
                $this->validator->add(
                    $file,
                    new FileValidator([
                        "maxSize"     => "2M",
                        "messageSize" => $file . " - must be maximum (:max) MB"
                    ])
                );
            }
        }

      return $this;
    }

    public function validate()
    {
        // handle validation logic

        $result = [];

        if(count($this->request_array))
        {
            $validation_result = $this->validator->validate($this->request_array);

            if(count($validation_result))
            {
                $result = $this->structureValidationErrorMessages($validation_result);
            }
        }
        else
        {
            $result[] = ['field' => 'request_fields', 'message' => 'Please provide data to validate'];
        }

        return $result;
    }

    protected function structureValidationErrorMessages($validation_result)
    {
        // structure the validation error messages

        $result = [];
        $count = 0;

        foreach($validation_result as $vr)
        {
            $result[$count]['field']   = $vr->getField();
            $result[$count]['message'] = $vr->getMessage();
            $count++;
        }

        return $result;
    }
}