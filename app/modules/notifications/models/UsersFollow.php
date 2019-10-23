<?php

namespace Vokuro\Notifications\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Models\Behaviors\Loggable;

class UsersFollow extends Model
{
    public $id;
    public $user_id;
    public $data_cms_id;
    public $module_id;
    public $application_id;
    public $type;

    public function getSource()
    {
        return 'data_cms_users_follow';
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
            "data_cms_id",
            'Models\Content',
            "ID",
            [
                'alias' => 'Content',
                'reusable' => true
            ]
        );
    }


}