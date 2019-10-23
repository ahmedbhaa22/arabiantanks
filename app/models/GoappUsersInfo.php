<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Models\Behaviors\Loggable;

class GoappUsersInfo extends Model
{
	public $id;
	public $user_id;
	public $zone_id;
	public $birth_date;
	public $application_id=593;	
	public function getSource() 
    {
        return 'goapp_users_info';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
	
	 public function initialize()
    {
        $this->belongsTo(
            "zone_id",
            'Models\GeoCities',
            "id",
            [
                'alias' => 'Zone',
                'reusable' => true
            ]
        );
	}
}