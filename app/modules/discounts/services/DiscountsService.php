<?php
namespace Vokuro\Discounts\Services;

use Phalcon\Mvc\User\Component;

class DiscountsService extends Component
{
    public function ajaxgetDiscounts($search_param=null)
    {
        $content_search = $this->modelsManager->createBuilder()
            ->from("Vokuro\Discounts\Models\Discounts");
        //$content_search->leftJoin("Vokuro\Offers\Models\OfferRelTypes", "Vokuro\Offers\Models\OfferRelTypes.offer_id = Vokuro\Offers\Models\Offers.id");
        if(isset($search_param['name'])){
            $content_search->andWhere("Vokuro\Discounts\Models\Discounts.name like '%{$search_param['name']}%'");
        }
        if(isset($search_param['coupon'])){
            $content_search->andWhere("Vokuro\Discounts\Models\Discounts.coupon like '%{$search_param['coupon']}%'");
        }
        if (isset($search_param['date_from']) && isset($search_param['date_to'])) {
            $date_from = strtotime($search_param['date_from']);
            $beginOfDay = strtotime("midnight", $date_from);
            $date_to = strtotime($search_param['date_to']);
            $endOfDayTo = strtotime("tomorrow", $date_to) - 1;
            $content_search->andWhere("Vokuro\Discounts\Models\Discounts.start_date>='{$beginOfDay}'");
            $content_search->andWhere("Vokuro\Discounts\Models\Discounts.end_date<='{$endOfDayTo}'");
        }
        $content_search->groupBy(array('Vokuro\Discounts\Models\Discounts.id'));
        //GET Total Count Of Results
        $total_results = clone $content_search;
        $total_results->columns("COUNT(*) rowcount");
        if(isset($search_param['pagination'])){
            $numberPage= $search_param['pagination']['page'];
            $num_rec_per_page = $search_param['pagination']['num_rec'];
            $start_from = ($numberPage-1) * $num_rec_per_page;
            //echo($num_rec_per_page);exit;
            $content_search->limit($num_rec_per_page,$start_from);
        }
        $result = $content_search->getQuery()->execute();
        $arr["result"]=$result;
        $arr["total"]=$total_results->getQuery()->execute();
        return $arr;

    }


    public function discount_products_search($search_param=null){
        $content_search = $this->modelsManager->createBuilder()
            ->from("Vokuro\Discounts\Models\DiscountRelItems");
        $content_search ->andWhere("Vokuro\Discounts\Models\DiscountRelItems.discount_id={$search_param["discount_id"]}");

        $content_search->leftJoin("Models\Content","Models\Content.ID = Vokuro\Discounts\Models\DiscountRelItems.data_cms_id");
        $content_search->leftJoin("DataCmsDeptsRelItem","DataCmsDeptsRelItem.Item_ID = Vokuro\Discounts\Models\DiscountRelItems.data_cms_id");
        $content_search->leftJoin("Vokuro\Models\ProductExtraFields","Vokuro\Models\ProductExtraFields.item_id = Vokuro\Discounts\Models\DiscountRelItems.data_cms_id");
        if(isset($search_param['lang_id'])){
            if(!$this->isDefaultAppLang($search_param['application_id'],$search_param['lang_id'])){
                $content_search->innerJoin("DataCmsLang","DataCmsLang.data_cms_id = Models\Content.ID");
                $content_search->andWhere("DataCmsLang.lang_id={$search_param['lang_id']}");
                if(isset($search_param['name'])){
                    $content_search->andWhere("DataCmsLang.title like '%{$search_param['name']}%'");
                }

            }else{
                if(isset($search_param['name'])){
                    $content_search->andWhere("Models\Content.Title like '%{$search_param['name']}%'");
                }

            }
        }

        //Extra Fields
        if(isset($search_param['extra_fields']['price_from'])&& isset($search_param['extra_fields']['price_to'])){
            $content_search->betweenWhere("Vokuro\Models\ProductExtraFields.price", $search_param['extra_fields']['price_from'], $search_param['extra_fields']['price_to']);
        }

        //Manufacturers
        if(isset($search_param['manufacturer'])){
            $content_search->innerJoin("DataCmsDeptsRelItem","manufacturer.Item_ID = Models\Content.ID","manufacturer");
            $content_search->andWhere("manufacturer.Depts_ID={$search_param['manufacturer']}");
        }

        $content_search->groupBy(array('Vokuro\Discounts\Models\DiscountRelItems.data_cms_id'));
        $total_results = clone $content_search;
        $total_results->columns("COUNT(*) rowcount");
        if(isset($search_param['pagination'])){
            $numberPage= $search_param['pagination']['page'];
            $num_rec_per_page = $search_param['pagination']['num_rec'];
            $start_from = ($numberPage-1) * $num_rec_per_page;
            //echo($num_rec_per_page);exit;
            $content_search->limit($num_rec_per_page,$start_from);
        }
        $result = $content_search->getQuery()->execute();
        $items =[];
        foreach ($result as $item){
            $items[] = $item;
        }
        return [
            "items"=>$items,
            "total"=>$total_results->getQuery()->execute()
        ];

    }
    public function isDefaultAppLang($app_id,$lang_id){
        $check = \ApplicationCmsLang::findFirst(["application_id={$app_id} and lang_id={$lang_id} and is_default=1"]);
        if(!$check){
            //echo "adsadasdd";die;
            return false;
        }
        return true;
    }
}