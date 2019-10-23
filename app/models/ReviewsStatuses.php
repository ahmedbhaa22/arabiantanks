<?php

namespace Vokuro\Models;

use Phalcon\Mvc\Model;

class ReviewsStatuses extends Model
{
	public $id;
	public $name;
	public $name_ar;

	public function getSource()
	{
		return 'reviews_statuses';
	}
}