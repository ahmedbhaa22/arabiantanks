<?php
namespace Vokuro\Maintenance\Models;

use Models\UsersMobile;
use Phalcon\Mvc\Model;
use Models\Content;
use Vokuro\Maintenance\Models\TicketsProblems;
use Phalcon\Mvc\Model\Relation;
use Vokuro\Models\CompanyBranches;

class Tickets extends Model
{
    public $id;
    public $ticket_number;
    public $client_id;
    public $client_notes;
    public $data_cms_id;
    public $production_year;
    public $product_number;
    public $category_attribute_id;
    public $category_attribute_value;
    public $ticket_problem_id;
    public $installation_status_id;
    public $installation_reason;
    public $in_guarantee;
    public $photo;
    public $report_notes;
    public $ticket_status_id;
    public $invoice_number;
    public $number_of_products;
    public $attached_file;
    public $order_notes;
    public $order_region_id;
    public $order_company_branch_id;
    public $assigned_technician_id;
    public $start_datetime;
    public $end_datetime;
    public $actual_start_time;
    public $actual_end_time;
    public $created_at;
    public $created_by;
    public $modified_at;
    public $modified_by;


    public function getSource()
    {
        return 'tickets';
    }

    public function initialize()
    {
        $this->belongsTo(
            'order_company_branch_id',
            CompanyBranches::class,
            'id',
            [
                'alias' => 'MaintenanceBranch'
            ]
        );
        $this->belongsTo(
            'data_cms_id',
            Content::class,
            'ID',
            [
                'alias' => 'content'
            ]
        );
        $this->belongsTo(
            'ticket_problem_id',
            TicketProblemDetails::class,
            'id',
            [
                'alias' => 'problem_details'
            ]
        );
        $this->belongsTo(
            'installation_status_id',
            TicketsInstallationStatus::class,
            'id',
            [
                'alias' => 'install_status'
            ]
        );
        $this->belongsTo(
            'ticket_status_id',
            TicketProblemsStatus::class,
            'id',
            [
                'alias' => 'problem_status'
            ]
        );
        $this->belongsTo(
            'client_id',
            UsersMobile::class,
            'ID',
            [
                'alias' => 'client'
            ]
        );
        $this->belongsTo(
            'assigned_technician_id',
            UsersMobile::class,
            'ID',
            [
                'alias' => 'tech_person'
            ]
        );
        $this->hasMany(
            'id',
            TicketsTechReports::class,
            'ticket_id',
            [
                'alias' => 'tech_report',
                "foreignKey" => [
                    "action" => Relation::ACTION_CASCADE,
                ]
            ]
        );
        $this->belongsTo(
            'ticket_pending_reason',
            MaintenancePendingReqReasons::class,
            'id',
            [
                'alias' => 'pending_reason'
            ]
        );
        $this->belongsTo(
            'ticket_exchange_reason',
            MaintenanceExchangeReqReasons::class,
            'id',
            [
                'alias' => 'exchange_reason'
            ]
        );
    }

    public function formattedDate()
    {
        return date('d/m/Y', strtotime($this->created_at));
    }
}