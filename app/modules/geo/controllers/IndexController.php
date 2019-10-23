<?php

namespace Vokuro\Geo\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Geo\Models\GeoContinents;
use Vokuro\Geo\Models\GeoCountries;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoStates;
use Vokuro\Geo\Models\GeoStreets;
use Vokuro\Geo\Models\Settings;
use Vokuro\Geo\Services\GeoService;
// use Vokuro\Polls\Models\Polls;

class IndexController extends ControllerBase
{

	public function indexAction()
	{
		$app_id = $this->auth->getIdentity()["Application_ID"];
		$settings =  Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

		$this->view->langs = $settings->langs;
		$this->view->settings = $settings;

		// die(var_dump($this->auth->getIdentity()));
		$this->view->continents = GeoContinents::query()->where("application_id = {$app_id}")->execute();
		$this->view->countries = GeoCountries::query()->where("application_id = {$app_id}")->execute();
		$this->view->states = GeoStates::query()->where("application_id = {$app_id}")->execute();
		$this->view->streets = GeoStreets::query()->where("application_id = {$app_id}")->execute();
		$this->view->cities = GeoCities::query()->where("application_id = {$app_id}")->execute();
		$this->view->regions = GeoRegions::query()->where("application_id = {$app_id}")->execute();
	}

	public function viewAction($id)
	{
		$geo = GeoService::getModel($this->request->getQuery('type'));

		$geo = $geo->findFirst($id);

		$final = $geo->toArray();

		$app_id = $this->auth->getIdentity()["Application_ID"];
		$settings =  Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

		$langs = $settings->langs;

		foreach ($langs as $lang) {
			$final["langs"][$lang->code] = $geo->getLangs([
	            "lang_id = :lang:",
	            "bind" => [
	                "lang" => $lang->id
	            ]
	        ])->getFirst();
		}

		// $final['ar'] = $geo->getLangs([
  //           "lang_id = :lang:",
  //           "bind" => [
  //               "lang" => 2
  //           ]
  //       ])->getFirst();

  //       $final['en'] = $geo->getLangs([
  //           "lang_id = :lang:",
  //           "bind" => [
  //               "lang" => 1
  //           ]
  //       ])->getFirst();



		return $this->sendJson($final);
	}

	public function storeAction()
	{
		// die(var_dump($this->request->getPost()));
		$app_id = $this->auth->getIdentity()["Application_ID"];
		$settings =  Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

		$langs = $settings->langs;

		// get the type model
		$geo = GeoService::getModel($this->request->getPost('type'));
		
		// create entry and store it's langs
		$geo->application_id = $this->auth->getIdentity()["Application_ID"];

		if($this->request->getPost('parent_id')){
			$geo->addParent($this->request->getPost('parent_id'));
		}

		$geo->save();

		// store langs
		foreach ($langs as $lang) {
			$key = "geo_" . $lang->code . "_name";
			if($this->request->getPost($key)){
				$geo->addLang($lang->id, $this->request->getPost($key));
			}
		}
		
		// if($this->request->getPost('geo_en_name')){
		// 	$geo->addLang(1, $this->request->getPost('geo_en_name'));
		// }
		// die(var_dump($geo));
		// redirect back
		return $this->response->redirect('index');
	}

	public function updateAction()
	{
		// die(var_dump($this->request->getPost()));
		$app_id = $this->auth->getIdentity()["Application_ID"];
		$settings =  Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();

		$langs = $settings->langs;

		$geo_id = $this->request->getPost('geo_id');

		$geo = GeoService::getModel($this->request->getPost('type'));

		$geo = $geo->findFirst($geo_id);

		if($this->request->getPost('parent_id')){
			$geo->addParent($this->request->getPost('parent_id'));
		}

		$geo->save();

		$geo->langs->delete();

		// store langs
		foreach ($langs as $lang) {
			$key = "geo_" . $lang->code . "_name";
			if($this->request->getPost($key)){
				$geo->addLang($lang->id, $this->request->getPost($key));
			}
		}
		
		// if($this->request->getPost('geo_ar_name')){
		// 	$geo->addLang(2, $this->request->getPost('geo_ar_name'));
		// }
		// if($this->request->getPost('geo_en_name')){
		// 	$geo->addLang(1, $this->request->getPost('geo_en_name'));
		// }
		
		// redirect back
		return $this->response->redirect('index');
	}

	public function deleteAction($id)
	{
		$geo = GeoService::getModel($this->request->getQuery('type'));

		$geo = $geo->findFirst($id);

		$geo->delete();

		return $this->response->redirect('index');
	}


}

