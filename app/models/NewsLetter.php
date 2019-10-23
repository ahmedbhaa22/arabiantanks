<?php

namespace Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Query\Builder;
use Vokuro\Discounts\Models\DiscountRelItems;
use Vokuro\Discounts\Models\Discounts;
use Vokuro\Models\Behaviors\Loggable;
use Phalcon\Mvc\Model\Behavior\Timestampable;
use DateTime;
use DateTimeZone;
use Vokuro\Models\ProductExtraFields;
use Vokuro\Models\ProductReviews;

class NewsLetter extends Model
{
    public $mail;
    public $application_id;
    public function getSource()
    {
        return 'newsletter';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Content
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public static function unsubscribe($user)
    {
        $result =  false;
        $record = static::findFirst([
            'mail like {email}',
            'bind' => [
                'email' => $user->Mail
            ]
        ]);

        if($record && $record->delete())
        {
            $result = true;
        }

        return $result;
    }
}