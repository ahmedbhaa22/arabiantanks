<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 07/09/2018
 * Time: 01:05 PM
 */
namespace Vokuro\Polls\Services;

use Phalcon\Mvc\User\Component;



class PollVisitsService extends Component
{
    public function search($search_param =null){
        $builder = $this->modelsManager->createBuilder()->from("Models\TanksPollsVisits");
        $builder->innerJoin("Models\SalesVisits", "Models\SalesVisits.id = Models\TanksPollsVisits.visit_id");
        $builder->innerJoin("Models\UsersMobile", "visited_client.ID = Models\SalesVisits.client_id","visited_client");

        if(!array_key_exists(1,$this->session->get('auth-identity')['rules'])){
            $builder->inWhere("Models\SalesVisits.sales_person_branch_id",$this->session->get('auth-identity')['user_info']['allowed_branches']);

        }

        if(isset($search_param["client_category"])&&$search_param["client_category"]!=""){
            $builder->andWhere("visited_client.category_id={$search_param['client_category']}");
        }

        if(isset($search_param["client_name"])&&$search_param["client_name"]!=""){
            $builder->andWhere("visited_client.Title like '%{$search_param['client_name']}%'");
        }

        if(isset($search_param["client_mobile"])&&$search_param["client_mobile"]!=""){
            $builder->andWhere("visited_client.Mobile={$search_param['client_mobile']}");
        }

        if(isset($search_param["date_from"])&&$search_param["date_from"]!=""){
            $builder->andWhere("Models\SalesVisits.date >= {$search_param["date_from"]}");
        }
        if(isset($search_param["date_to"])&&$search_param["date_to"]!=""){
            $builder->andWhere("Models\SalesVisits.date <= {$search_param["date_to"]}");
        }


        if(isset($search_param["sales_person"])&&$search_param["sales_person"]!=0){
            $builder->andWhere("Models\SalesVisits.sales_person={$search_param["sales_person"]}");
        }


        $builder->orderBy("Models\TanksPollsVisits.id DESC");
        return $builder;

    }


}