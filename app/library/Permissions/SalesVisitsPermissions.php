<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 6/10/2018
 * Time: 3:21 PM
 */

namespace Vokuro\Permissions;
use Phalcon\Mvc\User\Component;
use Models\SalesVisits;

class SalesVisitsPermissions extends  Component
{
        public function visits_query_builder($search_param=[]){
            $builder = $this->modelsManager->createBuilder()->from(SalesVisits::class);
            $sales_persons=[];
            //Get User Rule And Branch
            $user_branch_id=$this->session->get('auth-identity')['user_info']["branch"];
            $user_rules = $this->session->get('auth-identity')["rules"];
            $builder->innerJoin("Models\UsersMobile", "visited_client.ID = Models\SalesVisits.client_id","visited_client");
            if(isset($search_param["client_name"]) && $search_param["client_name"]!=""){
                $builder->andWhere("visited_client.Title like '%{$search_param['client_name']}%'");
            }
            if(isset($search_param["phone"]) && $search_param["phone"]!=""){
                $builder->andWhere("visited_client.Mobile = {$search_param['phone']}");
            }
            if(array_key_exists(7,$user_rules)){
                $builder->andWhere("Models\SalesVisits.sales_person={$this->session->get('auth-identity')['id']}");
            }
            elseif(array_key_exists(8,$user_rules) || array_key_exists(5,$user_rules) || array_key_exists(6,$user_rules) ){
                $builder->inWhere("Models\SalesVisits.sales_person_branch_id",$this->session->get('auth-identity')['user_info']["allowed_branches"]);
            }
            elseif (array_key_exists(1,$user_rules) || array_key_exists(2,$user_rules)){

            }
            else{
                return false;
            }
            return $builder;

        }

        public function check_add(){
            $user_rules = $this->session->get('auth-identity')["rules"];
            if(array_key_exists(7,$user_rules)){
                return true;
            }
            elseif(array_key_exists(8,$user_rules) || array_key_exists(5,$user_rules) || array_key_exists(6,$user_rules) ) {
                return true;
            }
            return false;
        }
}