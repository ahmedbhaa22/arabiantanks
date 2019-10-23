<?php

namespace Vokuro\Permissions;

use Phalcon\Mvc\User\Component;

class MaintenancePermissions extends  Component{

    public function checkEditReqAccess($resource,$action,$order){
        //Get Ticket Branch
        $ticket_branch_id=$order->order_company_branch_id;
        //Get User Rule And Branch
        $user_branch_id=$this->session->get('auth-identity')['user_info']["branch"];
        $user_rules = $this->session->get('auth-identity')["rules"];
        $user_allowed_branches = $this->session->get('auth-identity')['user_info']["allowed_branches"];
        //System Admin Can Edit Ticket
        if(array_key_exists(1,$user_rules)){
            return true;
        }
        if(in_array($ticket_branch_id,$user_allowed_branches)){
            return true;
        }
        //If Ticket is returned back to customer service
        if($order->back_to_cs == 1){
            return true;
        }
        if($user_branch_id == $ticket_branch_id){
            return true;
        }else{
            return false;
        }
    }
}