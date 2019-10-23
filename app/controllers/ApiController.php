<?php

namespace Vokuro\Controllers;
use Vokuro\Maintenance\Services\RequestsProblemsApi;

class ApiController extends ControllerApiBase

{
    public function ticket_historyAction($ticket_id){
        $this->view->disable();
        $this->response->setContentType('application/json', 'UTF-8');
        $ticket_id = (int)$ticket_id;
        $request_service = new RequestsProblemsApi();
        $result = $request_service->ticket_history($ticket_id);
        echo json_encode($result);
    }
}