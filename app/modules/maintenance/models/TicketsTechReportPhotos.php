<?php
namespace Vokuro\Maintenance\Models;

use Phalcon\Mvc\Model;

class TicketsTechReportPhotos extends Model{
    public function getSource()
    {
        return 'tickets_tech_report_photos';
    }
}