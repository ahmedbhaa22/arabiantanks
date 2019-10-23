<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 12/18/2017
 * Time: 11:31 AM
 */
namespace Vokuro\Maintenance\Services;

use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Maintenance\Models\TicketProblemDetails;
use Vokuro\Maintenance\Models\TicketProblems;

class MaintenanceStatisticsApi extends Component
{
    public function general($search_param)
    {
        $builder = $this->modelsManager->createBuilder()->columns(
            [
                "category_attribute_value",
                "COUNT(Vokuro\Maintenance\Models\Tickets.id) as count_group",
            ]
        )->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["dept_id"])){
            $builder->leftJoin("DataCmsDeptsRelItem", "dept.Item_ID = Vokuro\Maintenance\Models\Tickets.data_cms_id", "dept");
            $builder->andWhere("dept.Depts_ID={$search_param['dept_id']}");
        }
        if(isset($search_param["category_attribute_value"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.category_attribute_value={$search_param['category_attribute_value']}");

        }
        if(isset($search_param["date_from"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.created_at >= '{$search_param['date_from']}'");
        }
        if(isset($search_param["date_to"])){
            $builder->andWhere("Vokuro\Maintenance\Models\Tickets.created_at <= '{$search_param['date_to']}'");
        }
        $builder->groupBy(
            [
                "Vokuro\Maintenance\Models\Tickets.category_attribute_value",
            ]
        );
        if(isset($search_param["stat_pic"])){
            $builder->leftJoin("Vokuro\Maintenance\Models\TicketProblemDetails", "problem.id = Vokuro\Maintenance\Models\Tickets.ticket_problem_id", "problem");
            $builder->groupBy(
                [
                    "problem.category_attribute_value",
                ]
            );
        }
        if(isset($search_param["page"])){
            $page= $search_param["page"];
        }else{
            $page= 1;
        }
        //$open= $builder->getQuery()->execute();
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit" => 10,
                "page" => $page,
            ]
        );
        $result= $this->getPaginationInfo($paginator);
        return $result;
    }

    public function stat_pic_search(){
        $builder = $this->modelsManager->createBuilder()->columns(
            [
                "ticket_problem_id",
                "COUNT(Vokuro\Maintenance\Models\Tickets.id) as count_group",
            ]
        )->from("Vokuro\Maintenance\Models\Tickets");
        if(isset($search_param["page"])){
            $page= $search_param["page"];
        }else{
            $page= 1;
        }
        $builder->groupBy(
            [
                "Vokuro\Maintenance\Models\Tickets.ticket_problem_id",
            ]
        );
        //$open= $builder->getQuery()->execute();
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit" => 10,
                "page" => $page,
            ]
        );
        $result= $this->getPaginationInfoPic($paginator);
        return $result;

    }

    public function getPaginationInfoPic(PaginatorQueryBuilder $paginator){
        $result = [];
        $result["items"] =[];
        foreach ($paginator->getPaginate()->items as $info){
            $row= $info->toArray();
            $problem_details= TicketProblemDetails::findFirst(["id={$info->ticket_problem_id}"]);
            $row["problem_name"]=$problem_details->name;
            $row["problem_spot"]=$problem_details->spot_on_photo;
            $problem_photo= $problem_details->ticket->photo;
            $result["items"]["result"][$problem_photo]["problems"][]=$row;
            $result["items"]["result"][$problem_photo]["photo"] = $problem_photo;
            $row=[];
        }
        //$result["items"] = $paginator->getPaginate()->items->toArray();
        $result["before"] = $paginator->getPaginate()->before;
        $result["next"] = $paginator->getPaginate()->next;
        $result["last"] = $paginator->getPaginate()->last;
        $result["total_pages"] = $paginator->getPaginate()->total_pages;
        $result["current"] = $paginator->getPaginate()->current;
        $result["total_items"]=$paginator->getPaginate()->total_items;
//GET Total Requests to properly calculate percentage
        $builder = $this->modelsManager->createBuilder()->columns(
            [
                "COUNT(id) as count_total",
            ]
        )->from("Vokuro\Maintenance\Models\Tickets");
        $count_result = $builder->getQuery()->execute();
        foreach ($count_result as $res){
            $result["total_requests"] = $res->count_total;
        }
        return $result;
    }


    public function getPaginationInfo(PaginatorQueryBuilder $paginator){
        $result = [];
        $result["items"] =[];
        foreach ($paginator->getPaginate()->items as $info){
            $row= $info->toArray();
            $result["items"][] = $row;
            $row=[];
        }
        //$result["items"] = $paginator->getPaginate()->items->toArray();
        $result["before"] = $paginator->getPaginate()->before;
        $result["next"] = $paginator->getPaginate()->next;
        $result["last"] = $paginator->getPaginate()->last;
        $result["total_pages"] = $paginator->getPaginate()->total_pages;
        $result["current"] = $paginator->getPaginate()->current;
        $result["total_items"]=$paginator->getPaginate()->total_items;
        //GET Total Requests to properly calculate percentage
        $builder = $this->modelsManager->createBuilder()->columns(
            [
                "COUNT(id) as count_total",
            ]
        )->from("Vokuro\Maintenance\Models\Tickets");
        $count_result = $builder->getQuery()->execute();
        foreach ($count_result as $res){
            $result["total_requests"] = $res->count_total;
        }
        return $result;
    }
}