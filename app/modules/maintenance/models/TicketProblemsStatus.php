<?php
namespace Vokuro\Maintenance\Models;

use Models\Content;
use Phalcon\Mvc\Model;

class TicketProblemsStatus extends Model{
    public $id;
    public $status_name;
    public function getSource()
    {
        return 'ticket_problems_status';
    }
    public function initialize(){

    }
    public function afterDelete(){

    }
}