<?php
namespace Vokuro\Maintenance\Models;

use Phalcon\Mvc\Model;


class TicketsTechReportNotes extends Model{
    public function getSource()
    {
        return 'tickets_tech_report_notes';
    }
}