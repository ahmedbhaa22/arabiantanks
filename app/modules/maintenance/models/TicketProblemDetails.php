<?php
namespace Vokuro\Maintenance\Models;


use Phalcon\Mvc\Model;

class TicketProblemDetails extends Model{
    public $id;
    public $ticket_id;
    public $name;
    public $spot_on_photo;
    public function getSource()
    {
        return 'ticket_problem_details';
    }
    public function initialize(){
        $this->belongsTo(
            'ticket_id',
            TicketProblems::class,
            'id',
            [
                'alias' => 'ticket'
            ]
        );


    }

}