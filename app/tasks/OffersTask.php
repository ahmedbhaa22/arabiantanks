<?php

use Phalcon\Cli\Task;

class OffersTask extends Task
{
    public function deactivateAction()
    {

        //today date
        $current_date = time();
        $beginOfDay = strtotime("midnight", $current_date);
        $content_search = $this->modelsManager->createBuilder()
            ->from("Vokuro\Offers\Models\Offers");
        $content_search->leftJoin("Vokuro\Offers\Models\OfferRelTypes", "Vokuro\Offers\Models\OfferRelTypes.offer_id = Vokuro\Offers\Models\Offers.id");
        $content_search->andWhere("Vokuro\Offers\Models\OfferRelTypes.end_date<='{$beginOfDay}'");
        $content_search->groupBy("Vokuro\Offers\Models\Offers.id");

        $result = $content_search->getQuery()->execute();
        if(count($result)>0){
            foreach ($result as $row){
                if($row->active=0){
                    continue;
                }
                $row->active= 0;
                if($row->save()){
                    echo "Offer Deactivated".PHP_EOL;;
                }
            }
        }
    }
}