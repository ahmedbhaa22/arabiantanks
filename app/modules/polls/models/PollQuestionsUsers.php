<?php

namespace Vokuro\Polls\Models;

use Models\UsersMobile;

class PollQuestionsUsers extends \Phalcon\Mvc\Model
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
    public $question_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=false)
     */
    public $user_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'poll_questions_users';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollAnswersUsers[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollAnswersUsers
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
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
            'question_id',
            Questions::class,
            'id',
            [
                'alias' => 'question'
            ]
        );

        $this->belongsTo(
            'answer_id',
            Answers::class,
            'id',
            [
                'alias' => 'answers'
            ]
        );
    }
}
