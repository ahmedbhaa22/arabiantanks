<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 7/9/2018
 * Time: 12:25 PM
 */

namespace Vokuro\Cms\Services;
use Models\UsersMobile;
use Phalcon\Mvc\User\Component;

class SalesRepsService extends Component
{
    public function search($search_params=null){
        $builder = $this->modelsManager->createBuilder()->from(UsersMobile::class)
        ->innerJoin("Vokuro\Models\UsersUsersRules","Models\UsersMobile.ID = Vokuro\Models\UsersUsersRules.user_id")
        ->andWhere("Vokuro\Models\UsersUsersRules.rule_id = 7");
        return $builder;

    }
}