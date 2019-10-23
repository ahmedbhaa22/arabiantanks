<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/7/2017
 * Time: 12:56 PM
 */

namespace Vokuro\UsersModule\Services;


use GuzzleHttp\Client;
use Vokuro\UsersModule\ServicesInterfaces\GuzzleServiceInterface;

class GuzzleService implements GuzzleServiceInterface
{
    private $base_uri = '';
    private $guzzle_client = null;
    private $headers = [];
    private $request_body = [];

    public function __construct($base_uri)
    {
        if(isset($base_uri) && filter_var($base_uri, FILTER_VALIDATE_URL))
        {
            $this->base_uri = $base_uri;
            $this->createGuzzleClient();
        }
    }

    private function createGuzzleClient()
    {
        $this->guzzle_client = new Client(['base_uri' => $this->base_uri]);
    }

    public function request($headers = [], $request_body = [])
    {
        $this->headers = $headers;
        $this->request_body = $request_body;
        return $this;
    }

    public function get($request_url)
    {
        $response = $this->guzzle_client->get($request_url.'?'.http_build_query($this->request_body));
        return \GuzzleHttp\json_decode($response->getBody());
    }

    public function post($request_url)
    {
        $response = $this->guzzle_client->post($request_url, [
            'headers' => $this->headers,
            'json' => $this->request_body
        ]);
        return \GuzzleHttp\json_decode($response->getBody());
    }

    public function getHeaders()
    {
        return $this->headers;
    }

    public function getRequestBody()
    {
        return $this->request_body;
    }

    public function getBaseUri()
    {
        return $this->base_uri;
    }

    public function getGuzzleClient()
    {
        return $this->guzzle_client;
    }

}