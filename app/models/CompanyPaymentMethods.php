<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 10/31/2017
 * Time: 4:07 PM
 */

namespace Vokuro\Models;


use Phalcon\Mvc\Model;

class CompanyPaymentMethods extends Model
{
    public $id;
    public $bank_name;
    public $account_name;
    public $account_number;
    public $company_id;

    public function getSource()
    {
        return 'company_payment_methods';
    }

    public function initialize()
    {
        $this->belongsTo(
            'company_id',
            Companies::class,
            'id',
            [
                'alias' => 'company'
            ]
        );
    }
}