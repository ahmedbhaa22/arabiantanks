<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/21/2017
 * Time: 2:34 PM
 */

namespace Vokuro\Cart\Controllers;


class ApisController extends ApiControllerBase
{
    public function cartAction($user_id)
    {
        $this->sendJson($this->apiFactory->getCart($user_id));
    }

    public function wishlistAction($user_id)
    {
        $this->sendJson($this->apiFactory->getWishlist($user_id));
    }

    public function addToWishlistAction($user_id)
    {
        $this->sendJson($this->apiFactory->addToWishlist($user_id, $this));
    }

    public function addToCartAction($user_id)
    {
        $this->sendJson($this->apiFactory->addToCart($user_id, $this));
    }

    public function removeFromCartAction($user_id)
    {
        $this->sendJson($this->apiFactory->removeFromCart($user_id, $this));
    }

    public function extraDataAction($user_id)
    {
        $this->sendJson($this->apiFactory->getCartExtraData($user_id));
    }

    public function checkoutAction($user_id)
    {
        $this->sendJson($this->apiFactory->checkout($user_id, $this));
    }

    /**
     * add order purchase prove
     */
    public function addOrderProveAction(){
        $this->sendJson($this->apiFactory->addOrderProve($this));
    }
}