<?php

namespace Vokuro\Models;

use Phalcon\Mvc\Model;

class SavedSearchKeywords extends Model
{
	public $id;
	public $keyword;
	public $count;

	public function getSource()
	{
		return 'searched_keywords';
	}
}