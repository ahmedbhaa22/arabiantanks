<?php
namespace Vokuro\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Submit;
use Phalcon\Forms\Element\Check;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\Identical;
use Phalcon\Validation\Validator\StringLength;
use Phalcon\Validation\Validator\Confirmation;

class SignUpForm extends Form
{

    public function initialize($entity = null, $options = null)
    {
        $name = new Text('name');

        $name->setLabel('الإسم');

        $name->addValidators([
            new PresenceOf([
                'message' => 'The name is required'
            ])
        ]);

        $this->add($name);

        // Email
        $email = new Text('email');

        $email->setLabel('البريد الإلكتروني');

        $email->addValidators([
            new PresenceOf([
                'message' => 'الايميل مطلوب'
            ]),
            new Email([
                'message' => 'الايميل ليس سليم'
            ])
        ]);

        $this->add($email);

        // User
        $user = new Text('User');

        $user->setLabel('ااسم المستخدم');

        $email->addValidators([
            new PresenceOf([
                'message' => 'اسم المستخدم مطلوب'
            ]),
        ]);

        $this->add($user);

        // Password
        $password = new Password('password');

        $password->setLabel('كلمة المرور');

        $password->addValidators([
            new PresenceOf([
                'message' => 'كلمة المرور مطلوبة'
            ]),
            new StringLength([
                'min' => 8,
                'messageMinimum' => 'كلمة المرور قصيرة جداً، اختار 8 خانات'
            ]),
            new Confirmation([
                'message' => 'كلمة المرور لا تطابق',
                'with' => 'confirmPassword'
            ])
        ]);

        $this->add($password);

        // Confirm Password
        $confirmPassword = new Password('confirmPassword');

        $confirmPassword->setLabel('تأكيد كلمة المرور');

        $confirmPassword->addValidators([
            new PresenceOf([
                'message' => 'تأكيد كلمة المرور مطلوب'
            ])
        ]);

        $this->add($confirmPassword);

        // Remember
        $terms = new Check('terms', [
            'value' => 'yes'
        ]);

        $terms->setLabel('الموافقة على الشروط');

        $terms->addValidator(new Identical([
            'value' => 'yes',
            'message' => 'لابد أن توافق على الشروط'
        ]));

        $this->add($terms);

        // CSRF
        $csrf = new Hidden('csrf');

        $csrf->addValidator(new Identical([
            'value' => $this->security->getSessionToken(),
            'message' => 'CSRF validation failed'
        ]));

        $csrf->clear();

        $this->add($csrf);

        // Sign Up
        $this->add(new Submit('Sign Up', [
            'class' => 'btn btn-success'
        ]));
    }

    /**
     * Prints messages for a specific element
     */
    public function messages($name)
    {
        if ($this->hasMessagesFor($name)) {
            foreach ($this->getMessagesFor($name) as $message) {
                $this->flash->error($message);
            }
        }
    }
}
