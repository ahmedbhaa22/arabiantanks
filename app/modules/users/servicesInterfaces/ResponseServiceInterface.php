<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/28/2017
 * Time: 3:27 PM
 */

namespace Vokuro\UsersModule\ServicesInterfaces;


interface ResponseServiceInterface
{
    public static function _instantiate();
    public function setCode($response_code);
    public function getCode();
    public function setMessageEN($response_messageEN);
    public function getMessageEN();
    public function setMessageAR($response_messageAR);
    public function setValidationErrorMessages($validation_error_messages=[]);
    public function getValidationErrorMessages();
    public function setOtherErrorMessages($other_error_messages=[]);
    public function getOtherErrorMessages();
    public function getMessageAR();
    public function setContent($response_content);
    public function getContent();
    public function getResponseArray();
    public function getResponseJson();
}