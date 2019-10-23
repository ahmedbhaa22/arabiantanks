<?php

namespace Vokuro\Models;

use Models\TanksCities;
use Models\TanksRegions;
use Vokuro\Geo\Models\GeoCities;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Impexp\Models\Users;
use Vokuro\Models\Companies;

class CompanyBranches extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $company_id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=false)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $address;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'company_branches';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CompanyBranches[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CompanyBranches
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "company_id",
            Companies::class,
            "id",
            [
                'alias' => "company"
            ]
        );

        $this->hasManyToMany(
            "id",
            CompanyBranchUsers::class,
            "branch_id", "user_id",
            Users::class,
            "ID",
            [
                "alias" => "users"
            ]
        );

        $this->hasMany(
            "id",
            BranchContacts::class,
            "branch_id",
            [
                'alias' => 'contacts'
            ]
        );

        //Tanks
        $this->belongsTo(
            "region_id",
            GeoRegions::class,
            "id",
            [
                'alias' => "region"
            ]
        );

        //Branch Lang
        $this->belongsTo(
            "id",
            SetupEntityLanguages::class,
            "item_id",
            [
                'alias' => "english",
                'params'   => [
                    'conditions' => "entity_id = '21' AND lang_id= 2"
                ]
            ]
        );

        //Tanks
        $this->belongsTo(
            "region_id",
            TanksRegions::class,
            "id",
            [
                'alias' => "tanks_region"
            ]
        );

        $this->belongsTo(
            "city_id",
            TanksCities::class,
            "id",
            [
                'alias' => "tanks_city"
            ]
        );
    }


    public static function getDetailed($region_id,$lang_id)
    {
        $detailed_branches = [];
        $branch_model = [];

        if(isset($region_id))
        {
            //Get All Cities in Regions
            //This is because region_id is for city and vice versa
            $mohafzat = GeoRegions::find(["city_id={$region_id}"]);
            $cities = [];
            if(count($mohafzat)>0){
                foreach ($mohafzat as $city){
                    $cities[]= $city->id;
                }
            }
            $builder = new \Phalcon\Mvc\Model\Query\Builder();
            $builder->from("Vokuro\Models\CompanyBranches");
            $builder->inWhere("Vokuro\Models\CompanyBranches.region_id",$cities);
            $branches = $builder->getQuery()->execute();

//            $branches = static::find([
//                'region_id = {region_id}',
//                'bind' => [
//                    'region_id' => $region_id
//                ]
//            ]);


        }
        else
        {
            $branches = static::find();
        }

        foreach ($branches as $branch) {
            $branch_model['id'] = $branch->id;
            $branch_model['name'] = $branch->name;
            if($lang_id==2){
                $branch_model['name'] = $branch->english->translation;
            }
            //$branch_model['name_eng'] = $branch->english->translation;
            $branch_model['image'] = '';
            $branch_model['description'] = '';
            $branch_model['content'] = '';
            $branch_model['created_at'] = '';
            $branch_model['duration'] = '';
            $branch_model['visit_num'] = '';
            $branch_model['order'] = '';
            $branch_model['link_share'] = '';
            $branch_model['more'] = static::structureBranchMore($branch);
            $branch_model['media'] = [];

            $detailed_branches[] = $branch_model;
        }

        return $detailed_branches;
    }

    private static function structureBranchMore($branch)
    {
        $more = [];

        $more[] = static::structureBranchContacts($branch, 'email');
        $more[] = static::structureBranchContacts($branch, 'mobile');
        $more[] = static::structureBranchKeyvalues($branch);

        return $more;
    }

    private static function structureBranchKeyvalues($branch)
    {
        $structured_keyvalue = [];

        $branch_keyvalue_model['key'] = 'keyvalue';
        $branch_keyvalue_model['group_name'] = 'Key Value Fields';
        $branch_keyvalue_model['value'] = [];

        $kv['id']         = '';
        $kv['paramter']   = '';
        $kv['value']      = [];
        $kv['dkv_id']     = '';
        $kv['setting_id'] = '';

        foreach($branch->toArray() as $k=>$v)
        {
            if($k === 'address' || $k === 'lat' || $k === 'long')
            {
                $kv['paramter'] = $k;
                $kv['value'][]    = ['value_id'=>'', 'value_title'=>$v];

                $structured_keyvalue[] = $kv;

                $kv['paramter'] = '';
                $kv['value']    = [];
            }
        }

        $branch_keyvalue_model['value'] = $structured_keyvalue;


        return $branch_keyvalue_model;
    }

    private static function structureBranchContacts($branch, $type)
    {
        $structured_contacts = [];
        $contact_model_container = [];
        $contact_model['parameter'] = '';
        $contact_model['value'] = '';

        $branch_more_model['key'] = 'email_contacts';
        $branch_more_model['group_name'] = 'Branch Email Contacts';
        $branch_more_model['value'] = $structured_contacts;

        if($type === 'email')
        {
            $contacts = $branch->getContacts(['type_id = 1']);

            $branch_more_model['key'] = 'email_contacts';
            $branch_more_model['group_name'] = 'Branch Email Contacts';
        }
        else
        {
            $contacts = $branch->getContacts(['type_id = 2']);

            $branch_more_model['key'] = 'mobile_contacts';
            $branch_more_model['group_name'] = 'Branch Mobile Contacts';
        }

        if(count($contacts))
        {
            foreach($contacts->toArray() as $contact)
            {
                foreach($contact as $k=>$v)
                {
                   if($k !== 'branch_id' && $k !== 'type_id')
                   {
                       $contact_model['parameter'] = $k;
                       $contact_model['value']     = $v;
                       $contact_model_container[] = $contact_model;
                   }
                }

                $structured_contacts[] = $contact_model_container;
                $contact_model_container = [];
            }
        }

        $branch_more_model['value'] = $structured_contacts;

        return $branch_more_model;
    }
}
