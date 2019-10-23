<?php
/**
 * Created by PhpStorm.
 * User: Ash
 * Date: 8/29/2017
 * Time: 10:49 AM
 */

namespace Vokuro\UsersModule\Services;


use Vokuro\UsersModule\ServicesInterfaces\UploadFileServiceInterface;

class UploadFileService implements UploadFileServiceInterface
{

    protected $upload_path;
    protected $files;
    private $upload_paths= [];

    private function __construct(){}

    public static function _instantiate()
    {
        static $instance = null;

        if($instance === null)
        {
            $instance = new UploadFileService();

        }
    }

    public function setUploadPath($upload_path)
    {
       if(isset($upload_path) && is_string($upload_path) && strlen($upload_path))
       {
           $this->upload_path = (substr($upload_path, -1) != '/')?$upload_path.'/':$upload_path;
       }

        return $this;
    }

    public function getUploadPath()
    {
        return $this->upload_path;
    }

    public function getFiles()
    {
        return $this->files;
    }

    public function upload($request)
    {
        if($request->hasFiles())
        {

            $this->files = $request->getUploadedFiles();

            foreach($request->getUploadedFiles as $file)
            {
                $extension = pathinfo($file->getName(), PATHINFO_EXTENSION);
                $upload_path = $this->getUploadPath().$file->getName().'-'.$this->getRandomString().$extension;

                if($file->moveTo($upload_path))
                {
                    $this->appendPaths($upload_path);
                }
            }
        }

        return $this->upload_paths;
    }

    public function getRandomString($length = 10)
    {
        $characters = 'abc012def345ghi678jkl91011mno1213pqr141516stw171819vyz';
        $random_string = '';
        for($i = 0; $i < $length; $i++)
        {
            $random_string .= $characters[rand(0, strlen($characters))];
        }
        return $random_string;
    }

    private function appendPaths($path)
    {
        $this->upload_paths[] = $path;
    }
}