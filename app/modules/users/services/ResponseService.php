<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/28/2017
 * Time: 3:30 PM
 */

namespace Vokuro\UsersModule\Services;


use Vokuro\UsersModule\ServicesInterfaces\ResponseServiceInterface;

class ResponseService implements ResponseServiceInterface
{
    private $code;
    private $message_en;
    private $message_ar;
    private $error_messages;
    private $content;
    private $lang_id;

    private function __construct(){}

    public static function _instantiate()
    {
        static $instance = null;

        if($instance === null)
        {
            $instance = new ResponseService();

            $instance->code = 0;
            $instance->message_en = '';
            $instance->message_ar = '';
            $instance->error_messages['validation'] = [];
            $instance->error_messages['other'] = [];
            $instance->content = [];
        }

        return $instance;
    }

    public function setCode($response_code)
    {
        if(isset($response_code) && is_int($response_code))
        {
            $this->code = $response_code;
        }

        return $this;
    }

    public function getCode()
    {
        return $this->code;
    }

    public function setMessageEN($response_messageEN)
    {
        if(isset($response_messageEN) && is_string($response_messageEN))
        {
            $this->message_en = $response_messageEN;
        }

        return $this;
    }

    public function getMessageEN()
    {
        return $this->message_en;
    }

    public function setMessageAR($response_messageAR)
    {
        if(isset($response_messageAR) && is_string($response_messageAR))
        {
            $this->message_ar = $response_messageAR;
        }

        return $this;
    }

    public function getMessageAR()
    {
        return $this->message_ar;
    }

    public function setContent($response_content)
    {
        $this->content = $response_content;
//        $params = new \stdClass();
//
//        if(count($response_content))
//        {
//            $this->content = $response_content;
//        }
//        else
//        {
//            $params->value = $response_content;
//
//            $this->content[] = $params;
//        }
        
        return $this;
    }

    public function getContent()
    {
        return $this->content;
    }

    public function setValidationErrorMessages($validation_error_messages = [])
    {
        if(is_array($validation_error_messages) && count($validation_error_messages))
        {
            $this->error_messages['validation'] = $validation_error_messages;
        }

        return $this;
    }

    public function getValidationErrorMessages()
    {
        return $this->error_messages['validation'];
    }

    public function setOtherErrorMessages($other_error_messages = [])
    {
        if(is_array($other_error_messages) && count($other_error_messages))
        {
            $this->error_messages['other'] = $other_error_messages;
        }

      return $this;
    }

    public function getOtherErrorMessages()
    {
        return $this->error_messages['other'];
    }

    public function getResponseArray()
    {
        return get_object_vars($this);
    }

    public function getResponseJson()
    {
        return json_encode($this->getResponseArray());
    }

    public function getCustomResponse($apiFactory)
    {
        $response['status'] = [];
        $response['content'] = [];

        $validation_messages = [];

        if(count($this->getValidationErrorMessages()))
        {
            foreach($this->getValidationErrorMessages() as $msg)
            {
                $validation_messages[] = $msg['message'];
            }
        }

        $error_messages = array_merge(
            $validation_messages,
            $this->getOtherErrorMessages()
        );

        $response['status'] = $apiFactory->getStatus(
            $this->getCode(),
            $this->getMessageEN(),
            $error_messages
        );
        if($this->lang_id==1){
            $response['status'] = $apiFactory->getStatus(
                $this->getCode(),
                $this->getMessageAR(),
                $error_messages
            );
        }

        $response['content'] = $this->getContent();

        return $response;
    }

    public function setLang_ID($lang_id)
    {
        if(isset($lang_id) && is_int($lang_id))
        {
            $this->lang_id = $lang_id;
        }

        return $this;
    }

    public function getLang_ID()
    {
        return $this->lang_id;
    }
}