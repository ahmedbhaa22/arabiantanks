<?php
namespace Vokuro\Models;

use Phalcon\Mvc\Model;

/**
 * Vokuro\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class Logs extends Model
{

    /**
     * ID
     * @var integer
     */
    public $id;

    /**
     * Name
     * @var string
     */
    public $user_id;

    /**
     * Name
     * @var string
     */
    public $module_id;

    /**
     * Name
     * @var string
     */
    public $date;

    /**
     * Name
     * @var string
     */
    public $action;

    public $link;

    public $application_id;

    public function initialize()
    {
        $this->belongsTo(
            "user_id",
            'Models\UsersMobile',
            "ID",
            [
                'alias' => 'Users',
                'reusable' => true
            ]
        );

        $this->belongsTo(
            "module_id",
            '\UsersApplicationModule',
            "ID",
            [
                'alias' => 'Module',
                'reusable' => true
            ]
        );
    }

    public function getSource()
    {
        return 'logs';
    }
}
