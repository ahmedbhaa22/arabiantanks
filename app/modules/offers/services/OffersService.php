<?php
namespace Vokuro\Offers\Services;

use Phalcon\Mvc\User\Component;

class OffersService extends Component
{
    public function ajaxgetOffers($search_param=null)
    {
        $content_search = $this->modelsManager->createBuilder()
            ->from("Vokuro\Offers\Models\Offers");
        $content_search->leftJoin("Vokuro\Offers\Models\OfferRelTypes", "Vokuro\Offers\Models\OfferRelTypes.offer_id = Vokuro\Offers\Models\Offers.id");
        $content_search->leftJoin("Vokuro\Offers\Models\OfferRegions", "Vokuro\Offers\Models\OfferRegions.offer_id = Vokuro\Offers\Models\Offers.id");
        if(isset($search_param['name'])){
            $content_search->andWhere("Vokuro\Offers\Models\Offers.name like '%{$search_param['name']}%'");
        }
        if (isset($search_param['date_from']) && isset($search_param['date_to'])) {
            $date_from = strtotime($search_param['date_from']);
            $beginOfDay = strtotime("midnight", $date_from);
            $date_to = strtotime($search_param['date_to']);
            $endOfDayTo = strtotime("tomorrow", $date_to) - 1;
            $content_search->andWhere("Vokuro\Offers\Models\OfferRelTypes.start_date>='{$beginOfDay}'");
            $content_search->andWhere("Vokuro\Offers\Models\OfferRelTypes.end_date<='{$endOfDayTo}'");
        }
        if(isset($search_param['region'])){
            $content_search->andWhere("Vokuro\Offers\Models\OfferRegions.region_id = {$search_param['region']}");
        }
        $content_search->groupBy(array('Vokuro\Offers\Models\Offers.id'));
        $total = clone $content_search;
        if(isset($search_param['pagination'])){
            $numberPage= $search_param['pagination']['page'];
            $num_rec_per_page = $search_param['pagination']['num_rec'];
            $start_from = ($numberPage-1) * $num_rec_per_page;
            //echo($num_rec_per_page);exit;
            $content_search->limit($num_rec_per_page,$start_from);
        }

        $result = $content_search->getQuery()->execute();
        $offers=[];
//        foreach ($result as $row){
//            $item=[];
//            $item['id']= $row->id;
//            $item['name']= $row->name;
//            $item['description']= $row->description;
//            $item['image']= $row->description;
//            $item['start_date']="";
//            $item['start_date']="";
//            foreach($row->getOffer_types('type_id=2') as $rel_type ){
//                $item['start_date']=$rel_type->start_date;
//                $item['end_date']=$rel_type->end_date;
//            }
//            $offers[]= $item;
//
//        }
        return [
            "items"=>$result,
            "total"=>$total->getQuery()->execute()
        ];;

    }
}