<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/28/2017
 * Time: 4:16 PM
 */

namespace Vokuro\Models;


use Phalcon\Mvc\Model;

class BranchContacts extends Model
{
    public $id;
    public $branch_id;
    public $type_id;
    public $name;

    public function getSource()
    {
        return 'company_branch_contacts';
    }

    public function initialize()
    {
        // define relations
    }
}