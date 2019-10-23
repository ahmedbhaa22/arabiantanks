<?php

namespace Models;

use Phalcon\Mvc\Model;

class MissionTypes extends Model
{
	public function getSource()
	{
		return 'mission_types';
	}

	public function initialize()
	{
		$this->hasMany(
			'id',
			SalesVisits::class,
			'mission_type_id',
			[
				'alias' => 'salesVisits'
			]
		);
	}
}