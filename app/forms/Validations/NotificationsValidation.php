<?php

namespace Vokuro\Forms\Validations;

use Phalcon\Validation;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\PresenceOf;

class NotificationsValidation extends Validation
{
    public function initialize()
    {
        $this->add(
            "message",
            new PresenceOf(
                [
                    "message" => "The message is required",
                ]
            )
        );

        $this->add(
            "topic_id",
            new PresenceOf(
                [
                    "message" => "The topic_id is required",
                ]
            )
        );

        $this->add(
            "module_id",
            new PresenceOf(
                [
                    "message" => "The module_id is required",
                ]
            )
        );

        // $this->add(
        //     "message_tone",
        //     new PresenceOf(
        //         [
        //             "message" => "The message_tone is required",
        //         ]
        //     )
        // );
    }
}