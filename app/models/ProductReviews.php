<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 11/1/2017
 * Time: 10:57 AM
 */

namespace Vokuro\Models;


use Models\Content;
use Models\UsersMobile;
use Phalcon\Mvc\Model;

class ProductReviews extends Model
{
    public $id;
    public $user_id;
    public $product_id;
    public $rating;
    public $review;
    public $status_id;
    public $created_at;

    public function getSource()
    {
        return 'product_reviews';
    }

    public function initialize()
    {
        $this->hasOne(
            "product_id",
            Content::class,
            "ID",
            [
                "alias" => "product"
            ]
        );

        $this->hasOne(
            "user_id",
            UsersMobile::class,
            "ID",
            [
                "alias" => "user"
            ]
        );

        $this->belongsTo(
            'status_id',
            ReviewsStatuses::class,
            'id',
            [
                'alias' => 'status'
            ]
        );
    }

    public function addReview($data)
    {
        $result['status']   = 0;
        $result['messages'] = [];
        $result['content']  = [];

        $this->user_id    = $data['user_id'];
        $this->product_id = $data['product_id'];
        $this->rating     = $data['rating'];
        $this->review     = $data['review'];
        $this->created_at = time();

        if($this->save())
        {
            $result['status']  = 1;
            $result['content'] = $this->toArray();
        }
        else
        {
            $result['messages'] = $this->getMessages();
        }

        return $result;
    }

    public function formattedDate()
    {
        return date('d/m/Y', $this->created_at);
    }
}