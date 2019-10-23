<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/28/2017
 * Time: 3:16 PM
 */

namespace Vokuro\UsersModule\ServicesInterfaces;


interface ValidationServiceInterface
{
    public static function _instantiate();

    public function getValidator();

    public function validateRequest($request, $required=[], $email=[], $alnum=[],
                                    $password_confirm=['password'=>'', 'confirm'=>''], $file=[],
                                    $stringLen=['fields'=>['name'=>'', 'min'=>8, 'max'=>20]]);
//    public function validateDataArrayRequest($request, $required=[], $email=[], $alnum=[],
//                                    $password_confirm=['password'=>'', 'confirm'=>''], $file=[],
//                                    $stringLen=['fields'=>['name'=>'', 'min'=>8, 'max'=>20]]);
    public function getRequestData($request);
}