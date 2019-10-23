<?php

namespace Vokuro\Polls\Models;

class Answers extends \Phalcon\Mvc\Model
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
     * @Column(type="string", nullable=true)
     */
    public $text;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $count;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $photo;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'poll_answers';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollAnswers[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollAnswers
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->belongsTo(
            "question_id",
            Questions::class,
            "id",
            [
                'alias' => "question"
            ]
        );
    }

    public function getPercentage()
    {
        if($this->question->getTotalCount()){
            return ($this->count / $this->question->getTotalCount()) * 100;
        }

        return 0;
    }

}
