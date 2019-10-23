<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/29/2017
 * Time: 10:46 AM
 */

namespace Vokuro\UsersModule\ServicesInterfaces;


interface UploadFileServiceInterface
{
    public static function _instantiate();
    public function setUploadPath($upload_path);
    public function getUploadPath();
    public function getFiles();
    public function upload($file);
    public function getRandomString($length=10);
}