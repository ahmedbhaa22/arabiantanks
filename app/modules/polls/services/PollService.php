<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 12/18/2017
 * Time: 11:31 AM
 */
namespace Vokuro\Polls\Services;

use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Polls\Models\Answers;
use Vokuro\Polls\Models\PollQuestionsUsers;


class PollService extends Component
{
    public function search($search_param){
        $builder = $this->modelsManager->createBuilder()->from("Vokuro\Polls\Models\Polls");
        $builder->andWhere("Vokuro\Polls\Models\Polls.application_id=1");
        if(isset($search_param["id"])){
            $builder->andWhere("Vokuro\Polls\Models\Polls.id={$search_param["id"]}");
        }
        if(isset($search_param["page"])){
            $page= $search_param["page"];
        }else{
            $page= 1;
        }
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit" => 10,
                "page" => $page,
            ]
        );
        $params=null;
        if(isset($search_param["answer_stats"])){
            $params["answer_stats"]=1;
        }
        $result= $this->getPaginationInfo($paginator,$params);
        return $result;
    }

    public function getPaginationInfo(PaginatorQueryBuilder $paginator,$params=null){
        $result = [];
        $result["items"] =[];
        foreach ($paginator->getPaginate()->items as $info){
            $row= $info->toArray();
            $questions = $info->getQuestions();
            $row["questions"]=$questions->toArray();
            foreach ($questions as $k=>$v){
                $answers = $v->getAnswers();
                $row["questions"][$k]["answers"]=$answers->toArray();
                $total_answers = PollQuestionsUsers::find(["question_id={$v->id}"]);
                $row["questions"][$k]["total_answers"] = count($total_answers);
                if(isset($params["answer_stats"])){
                    foreach ($row["questions"][$k]["answers"] as $answer_k=>$answer_v){
                        $users = PollQuestionsUsers::find(["answer_id={$row["questions"][$k]["answers"][$answer_k]["id"]}"]);
                        $row["questions"][$k]["answers"][$answer_k]["count_answer"] = count($users);

                    }


                }
            }
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
        return $result;
    }

    public function getQuestionStat($search_param){
        $row=[];
        $answers = Answers::find(["question_id={$search_param['id']}"]);
        $total_answers = PollQuestionsUsers::find(["question_id={$search_param['id']}"]);
        $row["total_answers"] = count($total_answers);
        $row["answers"]=$answers->toArray();
        foreach ($row["answers"] as $k=>$v){
            $users = PollQuestionsUsers::find(["answer_id={$v['id']}"]);
            $row["answers"][$k]["count_answer"] = count($users);
        }
        return $row;
    }
}