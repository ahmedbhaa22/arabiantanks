<?php 

namespace Vokuro\Notifications\Models;

use Models\UsersMobile;

/**
* 
*/
class User extends UsersMobile
{
	/**
     * returns user notification token
     * 
     */
	public function getQueueToken($queue_type)
    {
        switch ($queue_type) {
            case 1:
                //android
                if($this->androidTokens){
                    return $this->androidTokens->getFirst()->Token;
                }
                return "";
                break;
            case 2:
                //ios
                if($this->iosTokens){
                    return $this->iosTokens->getFirst()->Token;
                }
                return "";
                break;
            case 3:
                //email
                return $this->Mail;
                break;
            case 4:
                //sms
                return $this->mobile;
                break;
            case 5:
                // chrome
                break;
            default:
                # code...
                break;
        }
    }

    public function getQueueTokenID($queue_type)
    {
        switch ($queue_type) {
            case 1:
                //android
                if($this->androidTokens){
                    return $this->androidTokens->getFirst()->ID;
                }
                return "";
                break;
            case 2:
                //ios
                if($this->iosTokens){
                    return $this->iosTokens->getFirst()->ID;
                }
                return "";
                break;
            default:
                return;
                break;
        }
    }

    public function initialize()
    {
        $this->hasMany(
            "ID",
            Token::class,
            "User_ID",
            [
                'alias' => "androidTokens",
                "params" => [
                    'conditions' => 'Type = 2'  
                ]
            ]
        );

        $this->hasMany(
            "ID",
            Token::class,
            "User_ID",
            [
                'alias' => "iosTokens",
                "params" => [
                    'conditions' => 'Type = 1'
                ]
            ]
        );
    }
}