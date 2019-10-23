<?php
namespace Vokuro\Pentavalue;
use Phalcon\Mvc\User\Component;
use Phalcon\Security\Random;
use Phalcon\Image;
use Phalcon\Image\Adapter\Gd;

class ImgThumb extends Component
{
	const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';
    
    public function apiThumbs($img_name){
		$image = new Gd(static::UPLOAD_LOCATION.$img_name);
		$image->resize(300,null,Image::WIDTH);
		$image->save(static::UPLOAD_LOCATION."resized-{$img_name}");
		return "resized-{$img_name}";
		
	}
}