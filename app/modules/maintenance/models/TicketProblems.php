<?php
namespace Vokuro\Maintenance\Models;

use Models\Content;
use Phalcon\Mvc\Model;

class TicketProblems extends Model{
    public $id;
    public $data_cms_depts_rel_id;
    public $photo;
    public $category_attribute_id;
    public $category_attribute_value;
    public $data_cms_id;
    public function getSource()
    {
        return 'ticket_problems';
    }
    public function initialize(){
        $this->hasMany(
            'id',
            TicketProblemDetails::class,
            'ticket_id',
            [
                'alias' => 'problem_details'
            ]
        );
        $this->belongsTo(
            'data_cms_depts_rel_id',
            \DataCmsDeptsRel::class,
            'ID',
            [
                'alias' => 'problem_type'
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
    }
    public function afterDelete(){
        $this->problem_details->delete();
    }
}