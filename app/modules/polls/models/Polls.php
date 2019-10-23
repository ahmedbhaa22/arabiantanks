<?php

namespace Vokuro\Polls\Models;

class Polls extends \Phalcon\Mvc\Model
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
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $description;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $created_at;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $modified_at;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'poll_polls';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollPolls[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollPolls
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function getAnswersCount()
    {
        $questions = $this->questions;
        $count = 0;
        foreach ($questions as $question) {
            $count += $question->getTotalCount();
        }

        return $count;
    }

    public function initialize()
    {
        $this->hasMany(
            "id",
            Questions::class,
            "poll_id",
            [
                'alias' => "questions"
            ]
        );
    }

    public function formattedDate()
    {
        return date('d/m/Y', strtotime($this->created_at));
    }

}
