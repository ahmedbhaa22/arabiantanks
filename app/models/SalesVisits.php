<?php

namespace Models;

use Phalcon\Mvc\Model;

class SalesVisits extends Model
{
	public function getSource()
	{
		return 'sales_visits';
	}

	public function initialize()
	{
		$this->belongsTo(
			'client_id',
			UsersMobile::class,
			'ID',
			[
				'alias' => 'client',
				'params' => [
					'conditions' => UsersMobile::class . '.category_id is not null'
				]
			]
		);

		$this->belongsTo(
			'mission_type_id',
			MissionTypes::class,
			'id',
			[
				'alias' => 'missionType'
			]
		);

		$this->belongsTo(
			'created_by',
			UsersMobile::class,
			'ID',
			[
				'alias' => 'createdBy',
//				'params' => [
//					'conditions' => UsersMobile::class . '.category_id is null'
//				]
			]
		);

        $this->belongsTo(
            'sales_person',
            UsersMobile::class,
            'ID',
            [
                'alias' => 'salesPerson',
            ]
        );
	}

	public static function instantiate()
	{
		$visit = new SalesVisits;

		$visit->created_at = time();
		$visit->updated_at = time();

		return $visit;
	}

	public function formattedDate($format='d/m/Y')
	{
		return date($format, $this->date);
	}
}