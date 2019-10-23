<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/28/2017
 * Time: 2:04 PM
 */

namespace Vokuro\UsersModule\Controllers;


use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;

class AuthControllerBase extends Controller
{
    protected $confirm_register_url;

    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        $this->_getServicesReady();
        $this->confirm_register_url = "http://arabiatanks.com/tanks/confirm-register/";
    }

    private function _getServicesReady()
    {
        // email service
        $this->emailService->setControllerObj($this);

        // base64 to image service
        $this->base64stringToImageService->setUploadPath('users/uploads');
        $this->base64stringToImageService->setBasePath($this->di->get('url')->getStatic());

        // user settings service
        $this->userSettingsService->setControllerObj($this);

        // redirect service
        $this->redirectService->setControllerObj($this);
    }

    protected function sendJson($response)
    {
        $this->response->setContentType('application/json', 'UTF-8');
        $this->response->setJsonContent($response);
        $this->response->send();
    }
}