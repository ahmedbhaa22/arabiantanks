<?php

namespace Models;

use Phalcon\Mvc\Model;
use Vokuro\Models\UsersUsersRules;

class UserCategories extends Model
{
	public $id;
	public $name;
	public $application_id;

	public function getSource()
	{
		return 'user_categories';
	}

	public function initialize()
	{
		$this->hasMany(
			'id',
			UsersMobile::class,
			'category_id',
			[
				'alias' => 'users'
			]
		);

        $this->hasMany(
            "id",
            UsersUsersRules::class,
            "rule_id",
            [
                'alias' => 'RulesUser',
                'reusable' => true
            ]
        );
	}
}