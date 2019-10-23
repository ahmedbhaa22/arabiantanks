<?php
namespace Vokuro\Maintenance\Models;

use Models\Content;
use Phalcon\Mvc\Model;

class MaintenancePendingReqReasons extends Model{
    public $id;
    public $reason_title;
    public function getSource()
    {
        return 'maintenance_pending_req_reasons';
    }
    public function initialize(){

    }

}