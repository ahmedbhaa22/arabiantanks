<?php

// created by Ash

namespace Vokuro\Pentavalue;

class FileUploadService extends \Phalcon\DI\Injectable
{
	private $upload_base_path;
	private $upload_path;

	public function __construct($upload_path)
	{
		$this->upload_base_path = $this->url->getStatic();
		$this->upload_path      = (substr($upload_path, -1) != '/')?$upload_path.'/':$upload_path;
	}

	public function setUploadBasePath($upload_base_path)
	{
		if(isset($upload_base_path) && is_string($upload_base_path) && strlen($upload_base_path) > 0)
		{
			$this->upload_base_path =(substr($upload_base_path, -1) != '/')?$upload_base_path.'/':$upload_base_path;
		}

		return $this;
	}

	public function setUploadPath($upload_path)
	{
		if(isset($upload_path) && is_string($upload_path) && strlen($upload_path) > 0)
		{
			$this->upload_path = (substr($upload_path, -1) != '/')?$upload_path.'/':$upload_path;
		}

		return $this;
	}

	public function getFullUploadPath()
	{
		return $this->upload_base_path . $this->upload_path;
	}

	public function getUploadPath()
	{
		return $this->upload_path;
	}

	public function getUploadBasePath()
	{
		return $this->upload_base_path;
	}

	public function upload($request)
	{
		$uploaded_files = [];

		if($request->hasFiles())
		{
			foreach($request->getUploadedFiles() as $file)
			{
				$extension   = $file->getExtension();
				$file_name   = time() . str_random(16) . '.' . $extension;
				$file_path   = $this->upload_path . $file_name;

				if($file->moveTo($file_path))
				{
					$uploaded_files[] = $file_name;
				}
			}
		}

		return $uploaded_files;
	}
}