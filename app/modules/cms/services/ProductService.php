<?php
namespace Vokuro\Cms\Services;

use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;


class ProductService extends Component{
    //Get Product That matches category and category attribute option
    public function getProductWithAttributeOption($search_param){
        $content_search = $this->modelsManager->createBuilder()->from("DataCmsDeptsRelItem")
            ->andWhere("DataCmsDeptsRelItem.Depts_ID ={$search_param['dept_id']}");
        $content_search->leftJoin("DataKeyvalueUserdata","DataKeyvalueUserdata.Item_ID = DataCmsDeptsRelItem.Item_ID");
        $content_search->andWhere("DataKeyvalueUserdata.DKV_ID ={$search_param['dkv_id']}");
        $content_search->andWhere("DataKeyvalueUserdata.Value ={$search_param['value']}");
        $content_search->leftJoin("Models\Content","products.ID= DataKeyvalueUserdata.Item_ID","products");
        $result = $content_search->getQuery()->execute();
        $items=[];
        foreach ($result as $res){
            $items[] = $res->Content->toArray();

        }
        return $items;


    }

    public function getProductWithAttributeOptionOther($search_param){
        $content_search = $this->modelsManager->createBuilder()->from("DataCmsDeptsRelItem")
            ->andWhere("DataCmsDeptsRelItem.Depts_ID ={$search_param['dept_id']}");
        $content_search->leftJoin("DataKeyvalueUserdata","DataKeyvalueUserdata.Item_ID = DataCmsDeptsRelItem.Item_ID");
        $content_search->andWhere("DataKeyvalueUserdata.DKV_ID ={$search_param['dkv_id']}");
        $content_search->andWhere("DataKeyvalueUserdata.Value ={$search_param['value']}");
        $content_search->leftJoin("Models\Content","products.ID= DataKeyvalueUserdata.Item_ID","products");
        $result = $content_search->getQuery()->execute();
        $items=[];
        foreach ($result as $res){
            $items[] = $res->Content->toArray();

        }
        return $items;


    }
}