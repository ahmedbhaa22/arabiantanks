<?php
namespace Vokuro\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Submit;
use Phalcon\Forms\Element\Check;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\Identical;
use Phalcon\Forms\Element\Select;

class LoginForm extends Form
{

    public function initialize()
    {
        // Email
        $User = new Text('User', [
            'placeholder' => 'اسم المستخدم',
            'class' => 'form-control form-control-solid placeholder-no-fix',
            'autocomplete' => 'off',
            
        ]);
        $User->addValidators([
            new PresenceOf([
                'message' => 'The UserName is required'
            ]),
        ]);

        $this->add($User);

        // Password
        $Pass= new Password('Pass', [
            'placeholder' => 'كلمة المرور',
            'class' => 'form-control form-control-solid placeholder-no-fix',
            'autocomplete' => 'off',
        ]);

        $Pass->addValidator(new PresenceOf([
            'message' => 'The password is required'
        ]));

        $Pass->clear();

        $this->add($Pass);

        // Application_ID

        $Application_ID = new Select(
            'Application_ID', \UsersApplication::find(), array('using' => array('ID', 'Title'),'class'=>'form-control')
        );
        $Application_ID->addValidator(new PresenceOf([
            'message' => 'Application_ID is required'
        ]));
        $this->add($Application_ID);

        // Remember
        $remember = new Check('remember', [
            'value' => 'yes'
        ]);

        $remember->setLabel('Remember me');

        $this->add($remember);

        // CSRF
        $csrf = new Hidden('csrf');

        $csrf->addValidator(new Identical([
            'value' => $this->security->getSessionToken(),
            'message' => 'CSRF validation failed'
        ]));

        $csrf->clear();

        $this->add($csrf);

        $this->add(new Submit('go', [
            'class' => 'btn btn-success'
        ]));
    }
}
