<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 2:03 PM
 */

namespace Vokuro\Discounts\Controllers;


class ApisController extends ApisControllerBase
{
    public function getAction()
    {
        $discounts = $this->apiFactory->getDiscounts();
        $this->sendJson($discounts);
    }
}