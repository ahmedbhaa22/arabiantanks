<?php
namespace Vokuro\Maintenance\Models;


use Phalcon\Mvc\Model;

class TicketHistory extends Model{
    public function getSource()
    {
        return 'ticket_history';
    }
    public function initialize(){
        $this->belongsTo(
            'ticket_id',
            Tickets::class,
            'id',
            [
                'alias' => 'ticket'
            ]
        );

        $this->belongsTo(
            'status_id',
            TicketProblemsStatus::class,
            'id',
            [
                'alias' => 'status'
            ]
        );

    }
}