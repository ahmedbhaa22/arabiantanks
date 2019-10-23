<?php
namespace Vokuro\Maintenance\Services;
use Phalcon\Mvc\User\Component;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;

class ProductsAttributesOptions extends Component{
    public function getTankCapacityInfo($dept_id,$product_id){
        $capacity_dkv =0;
        switch ($dept_id){
            case 74: //Vertical Tanks
                $capacity_dkv = 102;
                break;
            case 75: //Horizontal Tanks
                $capacity_dkv = 101;
                break;
            case 77: // Underground Tanks
                $capacity_dkv = 101;
                break;
            default:
                break;
        }
        $response =[];
        $get_capacity_value_id = \DataKeyvalueUserdata::findFirst(["DKV_ID={$capacity_dkv} AND Item_ID={$product_id}"]);
        if($get_capacity_value_id){
            $get_capacity_value = \DataKeyvalueOptionLang::findFirst(["Option_ID={$get_capacity_value_id->Value}"]);
            $response["category_attribute_id"]=$capacity_dkv;
            $response["category_attribute_value_option_id"]=$get_capacity_value_id->Value;
            $response["category_attribute_value"]=$get_capacity_value->Title;
        }
        return $response;
    }
}