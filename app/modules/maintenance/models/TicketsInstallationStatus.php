<?php
namespace Vokuro\Maintenance\Models;

use Models\Content;
use Phalcon\Mvc\Model;

class TicketsInstallationStatus extends Model{
    public $id;
    public $title;
    public function getSource()
    {
        return 'tickets_installation_status';
    }
    public function initialize(){

    }

}