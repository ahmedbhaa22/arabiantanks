<?php

namespace Vokuro;

use Models\DataCmsMenus;
use Phalcon\Mvc\User\Component;
use Vokuro\Models\Menus as AppMenu;
use Phalcon\Mvc\View;
use Vokuro\Models\TanksSideMenu;


/**

 * Menus

 *

 * Helps to build UI Menus for the application

 */

class Menus extends Component

{

    

    public function getMenu() {

        $menus = TanksSideMenu::find(["parent_id=0 and active=1"]);

        $this->view->result = $menus->toArray();
        if(array_key_exists(1,$this->session->get('auth-identity')['rules'])){
            return $this->view->getRender(APP_PATH.'/views/shared/', 'menu');
        }
        return $this->view->getRender('shared', 'menu');

    }

    

}