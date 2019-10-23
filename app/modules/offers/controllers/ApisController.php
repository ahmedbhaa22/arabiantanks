<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/19/2017
 * Time: 11:36 AM
 */

namespace Vokuro\Offers\Controllers;

use Vokuro\Pentavalue\Helpers;

class ApisController extends ApiControllerBase
{
    /**
     * @param null $offer_id
     *
     * - if param offer_id is sent => the api returns a specific offer ELSE all offers are returned
     * - if the HTTP param region_id is sent => the api filters the offers with the region id ELSE all offers
     * in all regions returned
     */
    public function getAction($offer_id = null)
    {
        $region_id = ($this->request->get('region_id'))?$this->request->get('region_id'):null;
        $lang_id = (null != $this->request->get('lang_id'))?$this->request->get('lang_id'):null;
        $this->sendJson($this->apiFactory->getOffers($offer_id, $region_id,$lang_id));
    }

    public function inHomePageAction()
    {
        $lang_id = (null != $this->request->get('lang_id'))?$this->request->get('lang_id'):null;
        $this->sendJson($this->apiFactory->getHomePageOffers($lang_id));
    }

    public function regionsAction($city_id = null)
    {
        $lang_id = (null != $this->request->get('lang_id'))?$this->request->get('lang_id'):null;
        $this->sendJson($this->apiFactory->getRegions($city_id, $lang_id));
    }

    public function citiesAction($country_id = null)
    {
        $lang_id = (null != $this->request->get('lang_id'))?$this->request->get('lang_id'):null;
        $this->sendJson($this->apiFactory->getCities($country_id, $lang_id));
    }

    public function countriesAction()
    {
        $lang_id = (null != $this->request->get('lang_id'))?$this->request->get('lang_id'):null;
        $this->sendJson($this->apiFactory->getCountries($lang_id));
    }

    public function itemsAction($offer_id)
    {
        $this->sendJson($this->apiFactory->getOfferItems($offer_id));
    }

    public function getOffersByNameAction($name)
    {
        Helpers::saveSearchKeyword($name);
        $this->sendJson($this->apiFactory->getOffersByName($name));
    }
}