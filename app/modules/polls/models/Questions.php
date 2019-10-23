<?php

namespace Vokuro\Polls\Models;

class Questions extends \Phalcon\Mvc\Model
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
    public $data_type_id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $answers_limit;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $total_answers;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $poll_id;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'poll_questions';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollQuestions[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PollQuestions
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    public function initialize()
    {
        $this->hasMany(
            "id",
            Answers::class,
            "question_id",
            [
                'alias' => "answers"
            ]
        );

        $this->belongsTo(
            "poll_id",
            Polls::class,
            "id",
            [
                'alias' => "poll"
            ]
        );
    }

    public function getTotalCount()
    {
        $answers = $this->answers;
        $count = 0;
        foreach ($answers as $answer) {
            $count = $count + $answer->count;
        }

        return $count;
    }

    public function getAnswersJson()
    {
        $json = [];
        $answers = $this->answers;
        foreach ($answers as $key => $answer) {
            $json[$key]["name"] = $answer->text;
            $json[$key]["y"] = (int)$answer->count;
        }
        // dd($json);
        return json_encode($json);
    }

    public function userAnswer($user_id)
    {
        $answer_id = null;

        $user_question_answer = PollQuestionsUsers::findFirst([
            'question_id = :q: and user_id = :user:',
            'bind' => [
                'q'    => $this->id,
                'user' => $user_id
            ]
        ]);

        if($user_question_answer)
        {
            $answer_id = $user_question_answer->answer_id;
        }

        return $answer_id;
    }
}
