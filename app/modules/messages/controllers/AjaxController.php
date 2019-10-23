<?php

namespace Vokuro\Messages\Controllers;

use Models\Content;
use Models\UsersMobile;
use Vokuro\Controllers\ControllerBase;
use Vokuro\Models\Events\Events;
use Vokuro\Models\Places;
use Vokuro\Models\Tags;

class AjaxController extends ControllerBase
{

	public function search_usersAction()
	{
		$query = $this->filter->sanitize($_GET["q"], "string");
		$app_id = $this->auth->getIdentity()["Application_ID"];
		return $this->sendJson(UsersMobile::find([
					"Title LIKE '%$query%' AND Application_ID = {$app_id}",
					]), 200);
	}

	public function search_placesAction()
	{
		$query = $this->filter->sanitize($_GET["q"], "string");

		return $this->sendJson(Places::find([
					"name LIKE '%$query%'"
					]), 200);
	}

	public function search_tagsAction()
	{
		$query = $this->filter->sanitize($_GET["q"], "string");

		return $this->sendJson(Tags::find([
					"name LIKE '%$query%'"
					]), 200);
	}

	public function search_system_usersAction()
	{
		$query = $this->filter->sanitize($_GET["q"], "string");
		$app_id = $this->auth->getIdentity()["Application_ID"];

		$user_ids = \CpUserProfile::query()->where('Profile_ID = (5)')->execute();

		$user_ids = array_map(function($item){return $item['User_ID'];}, $user_ids->toArray());

		$user_ids = implode(",", $user_ids);
 		
		$system_users = UsersMobile::query()->where("ID NOT IN ('{$user_ids}')")->andWhere("Title LIKE '%$query%'")->andWhere("application_id = {$app_id}")->execute();
		
		return $this->sendJson($system_users);
	}

	public function search_event_usersAction($event_id)
	{
		$event = Events::findFirst($event_id);
		$user_ids = [];
		$user_ids[] = $event->creator_id;
		
		$invitations = $event->invitationsLink;
		
		foreach ($invitations as $inv) {
			$user_ids[] = $inv->user_id;
		}
		$user_ids = implode(",", $user_ids);
		$query = $this->request->getPost('q');
		$users = UsersMobile::query()->where("ID NOT IN ({$user_ids})")->andWhere("Title LIKE '%$query%'")->execute();
		return $this->sendJson($users);
	}

	public function search_companyAction($event_id)
	{
		$event = Events::findFirst($event_id);
		$company = $event->companies->getFirst();
		$com_users = $company->users;
		$com_user_ids = [];
		foreach ($com_users as $user) {
			$com_user_ids[] = $user->ID;
		}
		$event_users = $event->eventCom;
		$event_users_ids = [];
		foreach ($event_users as $com) {
			$event_users_ids[] = $com->user_id;
		}
		$search_ids = array_diff($com_user_ids, $event_users_ids);
		$search_ids = implode(",", $search_ids);

		$users = UsersMobile::query()->where("ID IN ({$search_ids})")->andWhere("Title LIKE '%$query%'")->execute();
		return $this->sendJson($users);
	}

	public function search_contentAction()
	{
		$query = $this->filter->sanitize($_GET["q"], "string");

		return $this->sendJson(Content::find([
					"conditions" => "Content LIKE '%{$query}%' or Title LIKE '%{$query}%'" 
					]));
	}

}

