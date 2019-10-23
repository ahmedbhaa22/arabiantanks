<?php

namespace Vokuro\Pentavalue;

use Phalcon\DI\Injectable;
use Vokuro\Models\SavedSearchKeywords;

class Helpers extends Injectable
{
	public function h_round($number)
	{
		return round($number, 2);
	}

	public static function saveSearchKeyword($keyword)
	{
		$searched_keyword = SavedSearchKeywords::findFirst([
			'keyword = :keyword:',
			'bind' => [
				'keyword' => $keyword
			]
		]);

		if(!$searched_keyword)
		{
			$searched_keyword = new SavedSearchKeywords;

			$searched_keyword->keyword = $keyword;
			$searched_keyword->count   = 1;
		}
		else
		{
			$searched_keyword->count = $searched_keyword->count + 1;
		}

		$searched_keyword->save();
	}
}