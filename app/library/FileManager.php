<?php

namespace Vokuro;

/**
* File manager class
*/
class FileManager
{

	public static function moveFile($path, $file)
	{
		return (bool)($file->moveTo($path));
	}

	public static function moveMultipleFiles($base_path, $files)
	{
		foreach ($files as $file) {

            $path = $base_path . md5(uniqid(rand(), true)) . '-' . strtolower($file->getname());

	        if(!(self::moveFile($path, $file))) return false;
		}

		return true;
	}

	public static function delete($path)
	{
		return unlink($path);
	}

	public static function deleteDirectory($dirPath)
	{
		if (! is_dir($dirPath)) {
	        throw new InvalidArgumentException("$dirPath must be a directory");
	    }

	    if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
	        $dirPath .= '/';
	    }

	    array_map('unlink', glob("{$dirPath}/*.*"));

	    rmdir($dirname);
	}
}