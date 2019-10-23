<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/7/2017
 * Time: 12:53 PM
 */

namespace Vokuro\UsersModule\ServicesInterfaces;



interface GuzzleServiceInterface
{
    public function __construct($base_uri);
    public function request($headers=[], $request_body=[]);
    public function get($request_url);
    public function post($request_url);
    public function getHeaders();
    public function getRequestBody();
    public function getBaseUri();
    public function getGuzzleClient();
}