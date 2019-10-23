<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 9/6/2017
 * Time: 4:06 PM
 */

namespace Vokuro\UsersModule\Models;


use Phalcon\Mvc\Model;

class TokenSecretKeys extends Model
{
    public $id;
    public $key;
    public $token_id;

    public function getSource()
    {
        return 'user_module_token_secret_keys';
    }

    public function initialize()
    {
        $this->belongsTo(
            'token_id',
            UserTokens::class,
            'id',
            [
                'alias' => 'token'
            ]
        );
    }
}