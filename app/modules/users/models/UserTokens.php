<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/4/2017
 * Time: 11:17 PM
 */

namespace Vokuro\UsersModule\Models;


use Models\UsersMobile;
use Phalcon\Mvc\Model;

class UserTokens extends Model
{
    public $id;
    public $token;
    public $is_expired;
    public $type;
    public $user_id;
    public $created_at;
    public $expired_at;

    public function getSource()
    {
        return 'user_module_tokens';
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

        $this->belongsTo(
            'type',
            LoginTypes::class,
            'id',
            [
                'alias' => 'loginType'
            ]
        );

        $this->hasOne(
            'id',
            TokenSecretKeys::class,
            'token_id',
            [
                'alias' => 'secretKey'
            ]
        );
    }
}