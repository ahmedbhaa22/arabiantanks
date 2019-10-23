<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Pentavalue\RequestValidation;
use Vokuro\Pentavalue\FileUploadService;
use Models\SeoSettings;

class ManufacturersController extends ControllerBase
{
	private $module_id    = 8;
	private $core_dept_id = 5;

	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$page = $this->request->get('page');
		$page = isset($page)?$page:1;

		$manufacturers_builder = $this->createManufacturersBuilder();

		$paginator = new PaginatorQueryBuilder([
			'builder' => $manufacturers_builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$temp_builder = $this->createManufacturersBuilder();

		$all_ids = [];
		$all_manfcts_ids = $temp_builder->columns('ID')->getQuery()->execute();

		foreach($all_manfcts_ids as $manfct_id)
		{
			$all_ids[] = current($manfct_id);
		}

		$this->view->page    = $paginator->getPaginate();
		$this->view->all_ids = json_encode($all_ids);
	}

	public function addAction()
	{
		//
	}

	public function editAction($id)
	{
		$manfct = \DataCmsDeptsRel::findFirst([
			'ID = :id: and Module_ID = :module_id: and Core_Depts_ID = :core_id:',
			'bind' => [
				'id'        => $id,
				'module_id' => $this->module_id,
				'core_id'   => $this->core_dept_id
			]
		]);

		$manfct_media = \DataCmsMedia::findFirst([
			'dept_id = :dept: and Application_ID = :app_id: and Module_ID = :module_id: and Type = :type:',
			'bind' => [
				'dept'      => $id,
				'app_id'    => 1,
				'module_id' => $this->module_id,
				'type'      => 'Img'
			]
		]);

		$this->view->manfct = $manfct;
		$this->view->media  = $manfct_media;
	}

	public function viewAction($id)
	{
		$manfct = \DataCmsDeptsRel::findFirst([
			'ID = :id: and Module_ID = :module_id: and Core_Depts_ID = :core_id:',
			'bind' => [
				'id'        => $id,
				'module_id' => $this->module_id,
				'core_id'   => $this->core_dept_id
			]
		]);

		$img    = \DataCmsMedia::findFirst([
			'dept_id = :dept: and Application_ID = :app_id: and Module_ID = :module_id: and Type = :type:',
			'bind' => [
				'dept'      => $id,
				'app_id'    => 1,
				'module_id' => $this->module_id,
				'type'      => 'Img'
			]
		]);

		$this->view->manfct = $manfct;
		$this->view->img  = $img;
	}

	public function updateSeoAction()
	{
		$manfct_id     = $this->request->getPost('manfct_id');
		$meta_keywords = $this->request->getPost('MetaKeywords');
		$meta_desc     = $this->request->getPost('MetaDescription');
		$meta_title    = $this->request->getPost('MetaTitle');
		$page_title    = $this->request->getPost('SeName');

		$manfct = \DataCmsDeptsRel::findfirst($manfct_id);

		if(!$manfct)
		{
			$this->redirectService->withMessage('error', 'Invalid Manufacturer', 
				$this->url->get('manufacturers/index'));
			return;
		}

		$seo_settings = SeoSettings::findFirst([
						'dept_id = :dept:',
						'bind' => [
							'dept' => $manfct->ID
						]
					]);

		if(!$seo_settings)
		{
			$seo_settings = new SeoSettings;
		}

		$seo_settings->meta = $meta_keywords;
		$seo_settings->meta_description = $meta_desc;
		$seo_settings->title_description = $meta_title;
		$seo_settings->page_title = $page_title;
		$seo_settings->dept_id = $manfct->ID;

		if(!$seo_settings->save())
		{
			$this->redirectService->withMessage('error', 'خطأ أثناء حفظ إعدادات SEO', 
				$this->url->get('manufacturers/view/'.$manfct->ID));
			return;
		}

		$this->redirectService->withMessage('success', 'تم حفظ إعدادات SEO بنجاح', 
				$this->url->get('manufacturers/view/'.$manfct->ID));
			return;
	}


	public function saveAction($id=null)
	{
		if(!$this->request->isPost())
		{
			$this->redirectService->withMessage('error', 'Invalid request', 
				$this->url->get('manufacturers/add'));
			return;
		}

		$validator = new RequestValidation($this->request);
		$validator->required([
			'name', 'order', 'desc'
		]);

		$validation_result = $validator->validate();

		if(count($validation_result))
		{
			$this->session->set('error_msgs', $validation_result);

			return $this->response->redirect($this->url->get('manufacturers/add'));
		}

		$name      = $this->request->getPost('name');
		$order     = $this->request->getPost('order');
		$desc      = $this->request->getPost('desc');
		$active    = $this->request->getPost('active');
		$img_title = $this->request->getPost('image_title');
		$img_alt   = $this->request->getPost('img_alt');

		$meta_keywords = $this->request->getPost('meta_keyword');
		$meta_desc     = $this->request->getPost('meta_desc');
		$meta_title    = $this->request->getPost('meta_title');
		$seo_page      = $this->request->getPost('seo_page');

		$uploaded_file_path  = '';
		$upload_file_service = new FileUploadService('uploads/');

		$upload_file_result = $upload_file_service->upload($this->request);


		if(count($upload_file_result))
		{
			$uploaded_file_path = $upload_file_result[0];
		}

		$from_action = $this->request->getPost('from_action');

		$manfct = new \DataCmsDeptsRel;

		if(isset($id))
		{
			$manfct = \DataCmsDeptsRel::findFirst($id);
		}

		$manfct->Title  = $name;
		$manfct->Des    = $desc;
		$manfct->Orders = $order;

		if(strlen($uploaded_file_path) > 0)
		{
			$manfct->Img = $uploaded_file_path;
		}
		else
		{
			$manfct->Img    = 0;
		}

		$manfct->Active = isset($active)?1:0;
		$manfct->Core_Depts_ID = $this->core_dept_id;
		$manfct->Module_ID     = $this->module_id;
		$manfct->Application_ID= 1;

		if(!$manfct->save())
		{
			if($from_action == 'edit')
			{
				$this->redirectService->withMessage('error', 'خطأ أثناء تعديل المصنع، حاول مرة أخرى', 
				$this->url->get('manufacturers/edit/'.$id));
				return;
			}

			$this->redirectService->withMessage('error', 'خطأ أثناء حفظ المصنع، حاول مرة أخرى', 
				$this->url->get('manufacturers/add'));
			return;
		}

		if(strlen($uploaded_file_path) > 0)
		{
			$dept_media = new \DataCmsMedia;

			if(isset($id))
			{
				$dept_media = \DataCmsMedia::findFirst([
					'dept_id = :dept:',
					'bind' => [
						'dept' => $manfct->ID
					]
				]);

				if(!$dept_media)
				{
					$dept_media = new \DataCmsMedia;
				}
			}

			$dept_media->dept_id        = $manfct->ID;
			$dept_media->Application_ID = 1;
			$dept_media->Module_ID      = $this->module_id;
			$dept_media->Type           = 'Img';
			$dept_media->Img            = 'uploads/users/' . $uploaded_file_path;
			$dept_media->img_title      = $img_title;
			$dept_media->img_alt        = $img_alt;
			$dept_media->datetime       = date('Y-m-d H:i:s');

			$dept_media->save();
		}

		$dept_seo = new SeoSettings;

		if(isset($id))
		{
			$dept_seo = SeoSettings::findFirst([
				'dept_id = :dept:',
				'bind' => [
					'dept' => $manfct->ID
				]
			]);

			if(!$dept_seo)
			{
				$dept_seo = new SeoSettings;
			}
		}

		$dept_seo->dept_id = $manfct->ID;
		$dept_seo->meta    = $meta_keywords;
		$dept_seo->meta_description  = $meta_desc;
		$dept_seo->title_description = $meta_title;
		$dept_seo->page_title        = $seo_page;

		$dept_seo->save();

		if($from_action == 'edit')
		{
			$this->redirectService->withMessage('success', 'تم تعديل المصنع بنجاح', $this->url->get('manufacturers/index'));
			return;

		}

		$this->redirectService->withMessage('success', 'تم إنشاء المصنع بنجاح', $this->url->get('manufacturers/index'));
		return;
	}

	private function createManufacturersBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(\DataCmsDeptsRel::class)
		->where('Core_Depts_ID = :core_id:', ['core_id'=>$this->core_dept_id])
		->andWhere('Module_ID = 8');

		return $builder;
	}

	public function filterManufacturersAction()
	{
		$builder      = $this->createManufacturersBuilder();
		$temp_builder = $this->createManufacturersBuilder();

		$page = $this->request->getPost('page');
		$page = isset($page)?$page:1;

		$name   = $this->request->getPost('name');
		$active = $this->request->getPost('active');

		$valid_name = (isset($name) && strlen($name) > 0)?true:false;

		if($valid_name)
		{
			$builder->andWhere('Title like :name:', ['name'=>'%'.$name.'%']);
			$temp_builder->andWhere('Title like :name:', ['name'=>'%'.$name.'%']);
		}

		$builder->andWhere('Active = :active:', ['active'=>$active]);
		$temp_builder->andWhere('Active = :active:', ['active'=>$active]);

		$paginator = new PaginatorQueryBuilder([
			'builder' => $builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$all_ids = [];
		$all_manfcts_ids = $temp_builder->columns('ID')->getQuery()->execute();

		foreach($all_manfcts_ids as $manfct_id)
		{
			$all_ids[] = current($manfct_id);
		}

		$manfcts_partial = $this->view->getRender('manufacturers/partials', 'filteredManfcts',[
			'page'    => $paginator->getPaginate(),
			'all_ids' => json_encode($all_ids)
		]);

		return json_encode(['content' => $manfcts_partial]);
	}

	public function exportExcelAction()
	{
		$all_ids = $this->request->getPost('all_ids');

		if(count($all_ids) < 1)
		{
			return json_encode(['status' => 0, 'file_name' => '']);
		}

		$manfacts = \DataCmsDeptsRel::query()->where('Core_Depts_ID = :core_dept:', 
			['core_dept'=>$this->core_dept_id])
		->andWhere('Module_ID = :module_id:', ['module_id'=>$this->module_id])
		->inWhere('ID', $all_ids)->execute();

		$phpexcel = new \PHPExcel;

		$phpexcel->getProperties()->setCreator('Appox');
        $phpexcel->getProperties()->setTitle('Manufacturers');
        $phpexcel->getProperties()->setSubject('Manufacturers Data');
        $phpexcel->setActiveSheetIndex(0);
        $phpexcel->getActiveSheet()->setRightToLeft(true);

        $header_fields = ['ID', "الأسم", "منشور", "ترتيب العرض"];

        $export_data = $this->prepareData($manfacts);

        $file_header = $this->createFileHeader();

        for ($i = 0; $i < count($header_fields); $i++) {
            $phpexcel->getActiveSheet()->setCellValue($file_header[$i], $header_fields[$i]);

            $phpexcel->getActiveSheet()->getStyle($file_header[$i])->applyFromArray([
                'fill' => [
                    'type' => \PHPExcel_Style_Fill::FILL_SOLID,
                    'color' => [
                        'rgb' => 'D3D3D3'
                    ]
                ]
            ]);

            $phpexcel->getActiveSheet()->getStyle($file_header[$i])->getFont()->setBold(true);
        }

        $sheet_row = 2;
		foreach($export_data as $row)
		{
			$col = 0;

			foreach($row as $data)
			{
				$phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $sheet_row, $data);
				$col++;
			}

			$sheet_row++;
		}

		$obj_writer = new \PHPExcel_Writer_Excel2007($phpexcel);
		$file_name = 'Manufacturers_Exported_' . date('Y-m-d H-i-s') . '.xlsx';

		if(!file_exists(BASE_PATH . '/public/manufacturers/'))
		{
			mkdir(BASE_PATH . '/public/manufacturers/');
		}

		$file_path = BASE_PATH . '/public/manufacturers/' . $file_name;
		ob_clean();
        $obj_writer->save($file_path);
        return json_encode(['status' => 1, 'file_name' => $file_name]);
	}

	private function prepareData($manfacts)
	{
		$prepared_data = [];

		foreach($manfacts as $manfct)
		{
			$prepared_data[$manfct->ID]['id'] = $manfct->ID;
			$prepared_data[$manfct->ID]['name'] = $manfct->Title;
			$prepared_data[$manfct->ID]['active'] = ($manfct->Active == 1)?'نعم':'لا';
			$prepared_data[$manfct->ID]['order'] = $manfct->Orders;
		}

		return $prepared_data;
	}

	private function createFileHeader($start_index = -1, $header = [])
    {
        $chars = range('A', 'Z');
        $header = $header;

        if ($start_index === -1) {
            foreach ($chars as $char) {
                $header[] = $char . '1';
            }

            $this->createFileHeader($start_index + 1, $header);
        } elseif ($start_index !== 26) {
            foreach ($chars as $char) {
                $header[] = $chars[$start_index] . $char . '1';
            }

            $this->createFileHeader($start_index + 1, $header);
        }

        return $header;
    }

    public function deleteAction($id)
    {
    	$response['status'] = 0;
		$response['msg'] = '';

		$manfct = \DataCmsDeptsRel::query()
		->where('ID = :id:')
		->andWhere('Core_Depts_ID = :core_dept:')
		->andWhere('Module_ID = :module_id:')
		->bind([
			'id'        => $id,
			'core_dept' => $this->core_dept_id,
			'module_id' => $this->module_id
		])->execute()->getFirst();

		if(!$manfct)
		{
			$response['msg'] = 'المصنع غير موجود';
			return json_encode($response);
		}

		if(!$manfct->delete())
		{
			$response['msg'] = 'خطأ أثناء حذف المصنع، حاول مرة أخرى';
			return json_encode([$response]);
		}

		$response['status'] = 1;
		$response['msg'] = 'تم حذف المصنع بنجاح';

		return json_encode($response);
    }

    public function deleteSelectedAction()
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$ids = $this->request->getPost('manfcts');
		
		$manfcts = \DataCmsDeptsRel::query()->inWhere("ID", $ids)
		->andWhere('Core_Depts_ID = :core_dept:', ['core_dept'=>$this->core_dept_id])
		->andWhere('Module_ID = :module_id:', ['module_id'=>$this->module_id])
		->execute();

		foreach($manfcts as $manfct)
		{
			if(!$manfct->delete())
			{
				$response['msg'] = 'خطأ أثناء حذف المصنعين، حاول مرة أخرى';
				return json_encode($response);
			}
		}

		$response['status'] = 1;
		$response['msg'] = 'تم حذف المصنعين بنجاح';

		return json_encode($response);
	}
}