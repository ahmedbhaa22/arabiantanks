<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/25/2017
 * Time: 8:54 PM
 */

namespace Vokuro\UsersModule\Models;


use Models\TanksCities;
use Models\TanksRegions;
use Models\UsersMobile;
use Phalcon\Mvc\Model;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Models\CompanyBranches;

class UserData extends Model
{
    public $id;
    public $user_id;
    public $gender_id;
    public $birthdate;
    public $timezone;
    public $country_id;
    public $city_id;
    public $region_id;
    public $supervisor_comment;
    public $branch_id;

    public function getSource()
    {
        return 'user_data';
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
            'region_id',
            TanksRegions::class,
            'id',
            [
                'alias' => 'region'
            ]
        );

        $this->belongsTo(
            'city_id',
            TanksCities::class,
            'id',
            [
                'alias' => 'city' 
            ]
        );

        $this->belongsTo(
            'branch_id',
            CompanyBranches::class,
            'id',
            [
                'alias' => 'branch'
            ]
        );
    }
}