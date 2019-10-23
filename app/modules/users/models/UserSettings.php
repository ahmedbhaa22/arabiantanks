<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/4/2017
 * Time: 10:49 PM
 */

namespace Vokuro\UsersModule\Models;


use Models\UsersMobile;
use Phalcon\Mvc\Model;

class UserSettings extends Model
{
    public $id;
    public $user_id;
    public $application_id;
    public $login_by_email;
    public $login_by_username;
    public $login_by_mobile;
    public $login_by_facebook;
    public $login_by_twitter;
    public $login_by_instagram;
    public $login_token_expires_in;

    public function getSource()
    {
        return 'user_module_settings';
    }

    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            'user_id',
            UsersMobile::class,
            'ID',
            [
                'alias' => 'user'
            ]
        );
    }
}