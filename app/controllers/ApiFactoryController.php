<?php
namespace Vokuro\Controllers;
use Phalcon\Mvc\Controller;
use Vokuro\ApiFactory;
/** HTTP Status Codes **/
//Success OK            200
//No Content            204
//No Auth               401
//Missing Parameters	422
//Bad Request           400
//Conflict              409

class ApiFactoryController extends Controller  {
    /**
     *  status = array(
     *      'code' => '', 
     *      'message' => '', 
     *      'parameters' => array(
     *          0 => array(
     *              'field_name' => 'password',
     *              'error_message' => 'password field is missing'
     *          ),
     *          1 => array(
     *              'field_name' => 'price',
     *              'error_message' => 'price field is missing'
     *          )
     *      )
     *  )
     * @param type $status
     * @param type $main_cms_data
     */
    /** CMS JSON Structure Example **/ 
    public function mainCmsJSONAction() { 
        $parameters = array(
            0 => array(
                   'field_name' => 'password',
                   'error_message' => 'password field is missing'
            ),
            1 => array(
                'field_name' => 'price',
                'error_message' => 'price field is missing'
            )
        );
        $status = $this->apiFactory->getStatus(422, 'Data returned successfully', $parameters);
        $items = \Models\Content::find(array(
            'Application_ID = {app_id}',
            'bind'=>[
                'app_id' => 535
            ]
        ));

        $array = $this->apiFactory->structureCMSResponse($status, $items);
        echo json_encode($array);exit;

    }
}
