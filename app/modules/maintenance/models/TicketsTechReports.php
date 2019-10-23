<?php
namespace Vokuro\Maintenance\Models;
use Models\UsersMobile;
use Phalcon\Mvc\Model;
use Models\Content;
use Vokuro\Maintenance\Models\TicketsProblems;
class TicketsTechReports extends Model{
    public function getSource()
    {
        return 'tickets_tech_reports';
    }
    public function initialize(){
        $this->hasMany(
            'id',
            TicketsTechReportPhotos::class,
            'tech_report_id',
            [
                'alias' => 'photos'
            ]
        );
        $this->hasMany(
            'id',
            TicketsTechReportNotes::class,
            'tech_report_id',
            [
                'alias' => 'notes'
            ]
        );
    }
}