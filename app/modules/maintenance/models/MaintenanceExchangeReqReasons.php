<?php
namespace Vokuro\Maintenance\Models;

use Models\Content;
use Phalcon\Mvc\Model;

class MaintenanceExchangeReqReasons extends Model{
    public $id;
    public $reason_title;
    public function getSource()
    {
        return 'maintenance_exchange_req_reasons';
    }
    public function initialize(){

    }

}