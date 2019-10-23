<?php
namespace Vokuro\Cms\Controllers; use Vokuro\Controllers\ControllerBase;


/**
 * Display the default index page.
 */
class IndexController extends ControllerBase
{

    /**
     * Default action. Set the public layout (layouts/public.volt)
     */
    public function indexAction()
    {
        $this->view->setTemplateBefore('public_view');
        $this->view->setVar('logged_in', is_array($this->auth->getIdentity()));
        return $this->dispatcher->forward([
            'controller' => 'session',
            'action' => 'login'
        ]);


    }

    public function noaccessAction()
    {
        $this->view->message = $this->getTranslation()->_("You Have no access to this page");
    }
}
