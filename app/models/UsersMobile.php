<?php
/**
 * Created by PhpStorm.
 * User: iSlAm
 * Date: 11/15/2016
 * Time: 3:08 PM
 */
namespace Models;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Vokuro\Cart\Models\Orders;
use Vokuro\Cart\Models\OrderStatuses;
use Vokuro\Models\Companies;
use Vokuro\Models\CompanyBranchUsers;
use Vokuro\Models\CompanyBranches;
use Vokuro\Models\CompanyUser;
use Vokuro\Models\DataCms;
use Vokuro\Models\ProductReviews;
use Vokuro\Models\Profiles;
use Vokuro\Models\ProjectClient;
use Vokuro\Models\Projects;
use Vokuro\Models\Tags;
use Vokuro\Models\UserInformation;
use Vokuro\Models\UserTags;
use Vokuro\Models\UsersRules;
use Vokuro\Models\UsersUsersRules;
use Vokuro\UsersModule\Models\UserAddresses;
use Vokuro\UsersModule\Models\UserData;
use Vokuro\UsersModule\Models\UserTokens;

class UsersMobile extends Model{
    public $ID;
    public $Title;
    public $User;
    public $Pass;
    public $Img;
    public $Gender;
    public $Access_Token;
    public $Social_Avatar;
    public $Login_Type;
    public $Mail;
    public $Social_ID;
    public $Social_Type;
    public $Join_Date;
    public $Application_ID;
    public $Module_ID;
    public $Active;
    public $City_ID;
    public $Type;
    public $Mobile;
    public $is_admin;
    public $token_id;
    public $confirm_code;
    public $confirm_code_expired;
    public $device_token;
    public $category_id;

    // the formatted join date
    public $formatted_join_date;

    public function getSource() { return 'users'; }
    public static function findIn(array $identifiers) {
        return self::query()
            ->inWhere('ID', $identifiers)
            ->execute();
    }
    public function initialize() {
        $this->hasOne(
            'ID',
            UserData::class,
            'user_id',
            [
                'alias' => 'data'
            ]
        );

        $this->hasMany(
            'ID',
            UserAddresses::class,
            'user_id',
            [
                'alias' => 'shippingAddresses'
            ]
        );

        $this->hasOne(
            'ID',
            UserAddresses::class,
            'user_id',
            [
                'alias' => 'mainAddress',
                'params' => [
                    'conditions' => UserAddresses::class.'.is_main = 1'
                ]
            ]
        );

        $this->belongsTo(
            "ID",
            '\CpUserProfile',
            "User_ID",
            [
                'alias' => 'CpUserProfile',
                'reusable' => true
            ]
        );

        $this->hasManyToMany(
            'ID',
            \CpUserProfile::class,
            'User_ID',
            'Profile_ID',
            Profiles::class,
            'id',
            [
                'alias' => 'profiles'
            ]
        );  

        $this->hasMany(
            "ID",
            \CpUserProfile::class,
            "User_ID",
            [
                'alias' => "profilesPivot"
            ]
        );

        $this->allowEmptyStringValues(
            array(
                "Access_Token",
                "Social_Avatar",
                "Social_ID",
                "Social_Type",
                "",
                "",
                "",
                ""
            )
        );

        $this->hasOne(
            'ID',
            UserInformation::class,
            'user_id',
            [
                'alias' => 'information'
            ]
        );

        $this->hasManyToMany(
            'ID',
            CompanyUser::class,
            'user_id',
            'company_id',
            Companies::class,
            'id',
            [
                'alias' => 'companies'
            ]
        );

        $this->hasMany(
            "ID",
            CompanyUser::class,
            "user_id",
            [
                'alias' => "comPivot"
            ]
        );

        $this->hasManyToMany(
            'ID',
            ProjectClient::class,
            'client_id',
            'project_id',
            Projects::class,
            'id',
            [
                'alias' => 'projects'
            ]
        );

        $this->hasManyToMany(
            "ID",
            UserTags::class,
            "user_id", "tag_id",
            Tags::class,
            "id",
            [
                "alias" => "tags"
            ]
            );

        $this->hasMany(
            "ID",
            UserTags::class,
            "user_id",
            [
                'alias' => "tagsPivot"
            ]
        );
        
        $this->hasMany(
            "ID",
            UsersUsersRules::class,
            "user_id",
            [
                'alias' => "rulesPivot"
            ]
        );

        $this->hasManyToMany(
            "ID",
            CompanyBranchUsers::class,
            "user_id", "branch_id",
            CompanyBranches::class,
            "id",
            [
                "alias" => "branches"
            ]
            );

        $this->hasMany(
            "ID",
            CompanyBranchUsers::class,
            "user_id",
            [
                'alias' => "branchesPivot"
            ]
        );
        $this->hasMany(
            "ID",
            "\UsersShippingAddresses",
            "user_id",
            [
                'alias' => "Addresses"
            ]
        );
        $this->belongsTo(
            "ID",
            '\UsersAdvanced',
            "User_ID",
            [
                'alias' => 'AdvancedInfo',
                'reusable' => true
            ]
        );

         $this->hasMany(
            "ID",
            UsersUsersRules::class,
            "user_id",
            [
                'alias' => 'UsersRule',
                'reusable' => true
            ]
        );

       $this->hasManyToMany(
           "ID",
           UsersUsersRules::class,
           "user_id", "rule_id",
           UsersRules::class,
           "id",
           array('alias' => 'user_rules')
       );

        $this->hasManyToMany(
            "ID",
            \DataCmsUsers::class,
            "user_id", "data_cms_id",
            DataCms::class,
            "ID",
            [
                "alias" => "cms"
            ]
        );

        $this->hasMany(
            'ID',
            UserTokens::class,
            'user_id',
            [
                'params' => [
                    'conditions' => 'is_expired = 1',
                ],
                'alias' => 'expiredTokens'
            ]
        );

        $this->hasOne(
            'ID',
            UserTokens::class,
            'user_id',
            [
                'params' => [
                    'conditions' => 'is_expired = 0',
                ],
                'alias' => 'activeToken'
            ]
        );

        $this->hasMany(
            'ID',
            UserTokens::class,
            'user_id',
            [
                'alias' => 'tokens'
            ]
        );

        $excluded_order_status_ids = implode(',', [OrderStatuses::cart(), OrderStatuses::wishlist()]);

        $this->hasMany(
            'ID',
            Orders::class,
            'user_id',
            [
                'alias' => 'orders',
                'params' =>[
                    'conditions' => Orders::class.".status not in ($excluded_order_status_ids)"
                ]
            ]
        );

        $this->hasMany(
            "ID",
            ProductReviews::class,
            "user_id",
            [
                "alias" => "reviews"
            ]
        );

        $this->belongsTo(
            'category_id',
            UserCategories::class,
            'id',
            [
                'alias' => 'category'
            ]
        );

        $this->belongsTo(
            'created_by',
            UsersMobile::class,
            'ID',
            [
                'alias' => 'CreatedBy'
            ]
        );
    }
    /**
     * returns user notification token
     * 
     */
    public function getQueueToken($queue_type) {
        switch ($queue_type) {
            case 1:
                //android
                break;
            case 2:
                //ios
                break;
            case 3:
                //email
                return $user->Mail;
                break;
            case 4:
                //sms
                // return $user->Mobile; // not yet implemnted
                break;
            case 5:
                // chrome
                break;
            default:
                # code...
                break;
        }
    }
//     // Before Validation Function
//    public function beforeValidationOnCreate()
//    {
//        if (empty($this->password)) {
//
//            // Generate a plain temporary password
//            $tempPassword = preg_replace('/[^a-zA-Z0-9]/', '', base64_encode(openssl_random_pseudo_bytes(12)));
//
//            // The user must change its password in first login
//            $this->mustChangePassword = 'Y';
//
//            // Use this password as default
//            $this->password = $this->getDI()
//                ->getSecurity()
//                ->hash($tempPassword);
//        } else {
//            // The user must not change its password in first login
//            $this->mustChangePassword = 'N';
//        }
//
//        // The account must be confirmed via e-mail
//        // Only require this if emails are turned on in the config, otherwise account is automatically active
//        if ($this->getDI()->get('config')->useMail) {
//            $this->active = 'N';
//        } else {
//            $this->active = 'Y';
//        }
//
//        // The account is not suspended by default
//        $this->suspended = 'N';
//
//        // The account is not banned by default
//        $this->banned = 'N';
//    }
    public function validation() {
        // $validator = new Validation();
// 
        // $validator->add('Mail', new Uniqueness([
            // "message" => "The email is already registered"
        // ]));

        // $validator->add('User', new Uniqueness([
        //     "message" => "The same Username is already registered"
        // ]));


        // return $this->validate($validator);
    }
    public function columnMap() {
        //Keys are the real names in the table and
        //the values their names in the application
        return array(
            'id' => 'ID',
            'title' => 'Title',
            'user' => 'User',
            'pass' => 'Pass',
            'img' => 'Img',
            'gender' => 'Gender',
            'access_token' => 'Access_Token',
            'social_avatar' => 'Social_Avatar',
            'login_type' => 'Login_Type',
            'mail' => 'Mail',
            'social_id' => 'Social_ID',
            'social_type' => 'Social_Type',
            'join_date' => 'Join_Date',
            'application_id' => 'Application_ID',
            'module_id' => 'Module_ID',
            'active' => 'Active',
            'city_id' => 'City_ID,',
            'type' =>'Type',
            'mobile' => 'Mobile',
            'is_admin' => 'is_admin',
            'token_id' => 'token_id',
            'confirm_code' => 'confirm_code',
            'confirm_code_expired' => 'confirm_code_expired',
            'device_token' => 'device_token',
            'category_id' => 'category_id',
            'created_by' => 'created_by'
        );
    }
    public static function alreadyRegistered($email) {
        return self::findFirst([
            "Mail = :email:",
            "bind" => [
                "email" => $email
            ]
        ]);
    }
    public static function userValid($token) {
        return self::findFirst([
            "Access_Token = :token:",
            "bind" => [
                "token" => $token
            ]
        ]);
    }
    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersMood[]
     */
    public static function find($parameters = null) {
        return parent::find($parameters);
    }
    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersMood
     */
    public static function findFirst($parameters = null) {
        return parent::findFirst($parameters);
    }
    public static function getRules($parameters = null)
    {
        return UsersRules::find($parameters);
    }

    public static function getMainAddress($user_id)
    {
        $user = static::findFirst($user_id);
        return ($user->mainAddress)?$user->mainAddress:[];
    }

    public function editProfile($data)
    {
        $result['status']   = 0;
        $result['messages'] = [];
        $result['content']  = [];

        $this->Title  = isset($data['name'])?$data['name']:$this->Title;
        $this->Mobile = isset($data['mobile'])?$data['mobile']:$this->Mobile;
        $this->Mail   = isset($data['mail'])?$data['mail']:$this->Mail;

        if($this->save())
        {
            if($this->data)
            {
                $this->data->birthdate  = isset($data['birthdate'])?$data['birthdate']:$this->data->birthdate;
                $this->data->country_id = isset($data['country_id'])?$data['country_id']:$this->data->country_id;
                $this->data->city_id    = isset($data['city_id'])?$data['city_id']:$this->data->city_id;
                $this->data->region_id  = isset($data['region_id'])?$data['region_id']:$this->data->region_id;

                if($this->data->save())
                {
                    $result['status'] = 1;
                    $result['content'][] = userCustomColumns($this);
                }
                else
                {
                    $result['messages'] = $this->data->getMessages();
                }
            }
            else
            {
                $user_data = new UserData();

                $user_data->user_id    = $this->ID;
                $user_data->birthdate  = isset($data['birthdate'])?$data['birthdate']:null;
                $user_data->country_id = isset($data['country_id'])?$data['country_id']:null;
                $user_data->city_id    = isset($data['city_id'])?$data['city_id']:null;
                $user_data->region_id  = isset($data['region_id'])?$data['region_id']:null;

                if($user_data->save())
                {
                    $result['status'] = 1;
                    $result['content'][] = userCustomColumns($this);
                }
            }

            $result['status']  = 1;
            $result['content'] = userCustomColumns($this);
        }
        else
        {
            $result['messages'] = $this->getMessages();
        }

        return $result;
    }

    public function isSubscribed()
    {
        $subscription = NewsLetter::findFirst([
            'mail like {email}',
            'bind' => [
                'email' => $this->Mail
            ]
        ]);

        return ($subscription == false)?0:1;
    }

    public function hasCategory()
    {
        return $this->category;
    }

    public static function emailExists($email)
    {
        $exists = static::query()->where('Mail = :email:', ['email'=>$email])->execute()->count();
        return ($exists == 0)?false:true;
    }

    public static function mobileExists($mobile)
    {
       // $exists = static::query()->where('Mail = :email:', ['Mobile'=>$mobile])->execute()->count();
        $exists = static::findFirst(["Mobile={$mobile}"]);

        return ($exists == 0)?false:true;
    }

    public function formattedJoinDate()
    {
        return date('d/m/Y', $this->Join_Date);
    }

    public function getRegionID()
    {
        return ($this->data != null)?$this->data->region_id:'';
    }

    public function getCityID()
    {
        return ($this->data != null)?$this->data->city_id:'';
    }

    public function getBranchID()
    {
        return ($this->data != null)?$this->data->branch_id:'';
    }

    public function getRuleID()
    {
        return ($this->user_rules != null && count($this->user_rules) > 0)
        ?$this->user_rules[0]->id:'';
    }

    public function getSaveErrors()
    {
        $messages = [];
        
        foreach ($this->getMessages() as $error) 
        {
            $messages[] = $error;
        }
    }
}