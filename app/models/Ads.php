<?php

namespace Vokuro\Models;

class Ads extends \Phalcon\Mvc\Model
{
	public $ID;
	public $Link;
	public $Img;
	public $Height;
	public $Width;
	public $Module_ID;
	public $Title;
	public $Des;
	public function getSource()
	{
		return 'users_application_ads';
	}
}