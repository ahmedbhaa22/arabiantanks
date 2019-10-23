<?php

namespace Vokuro\Cms\Controllers;

use Models\TanksTaxes;
use Vokuro\Controllers\ControllerBase;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Models\SeoSettings;
use Vokuro\Discounts\Models\Discounts;
use Vokuro\Pentavalue\FileUploadService;
use Vokuro\Models\ProductExtraFields;
use Models\Content;
use Vokuro\Pentavalue\Keyvalue;
use Vokuro\Pentavalue\RequestValidation;
use Vokuro\Discounts\Models\DiscountRelItems;

class CategoriesController extends ControllerBase
{
	private $application_id = 1;
	private $module_id      = 8;
	private $core_dept_id   = 4;

	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$page = $this->request->get('page');
		$page = isset($page)?$page:1;

		$categories_builder = $this->createCategoriesBuilder();

		$paginator = new PaginatorQueryBuilder([
			'builder' => $categories_builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$temp_builder = $this->createCategoriesBuilder();

		$all_ids = [];
		$all_cats_ids = $temp_builder->columns('ID')->getQuery()->execute();

		foreach($all_cats_ids as $cat_id)
		{
			$all_ids = current($cat_id);
		}

		$this->view->page    = $paginator->getPaginate();
		$this->view->all_ids = json_encode($all_ids);
	}

	private function createCategoriesBuilder()
	{
		$builder = $this->modelsManager->createBuilder()->from(\DataCmsDeptsRel::class)
		->where('Core_Depts_ID = :core_dept:', ['core_dept'=>$this->core_dept_id])
		->andWhere('Application_ID = :app_id:', ['app_id'=>$this->application_id])
		->andWhere('Module_ID = :module_id:', ['module_id'=>$this->module_id])
		->orderBy('Orders asc');

		return $builder;
	}

	public function filterCategoriesAction()
	{
		// var_dump($this->request->getPost());die;
		$builder = $this->createCategoriesBuilder();

		$page = $this->request->getPost('page');
		$page = isset($page)?$page:1;

		$name   = $this->request->getPost('name');
		$active = $this->request->getPost('active');

		$valid_name = (isset($name) && strlen($name) != null)?true:false;

		if($valid_name)
		{
			$builder->andWhere('Title like :name:', ['name'=>'%'.$name.'%']);
		}

		$builder->andWhere('Active = :active:', ['active'=>$active]);

		$paginator = new PaginatorQueryBuilder([
			'builder' => $builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$categories_partial = $this->view->getRender('categories/partials', 'filteredCategories',[
			'page' => $paginator->getPaginate()
		]);

		return json_encode(['content'=>$categories_partial]);
	}

	private function getTanksSingleCategory($category_id)
	{
		return \DataCmsDeptsRel::query()->where('ID = :id:', ['id'=>$category_id])
		->andWhere('Core_Depts_ID = :core_dept:', ['core_dept'=>$this->core_dept_id])
		->andWhere('Application_ID = :app_id:', ['app_id'=>$this->application_id])
		->andWhere('Module_ID = :module_id:', ['module_id'=>$this->module_id])
		->execute()->getFirst();
	}

	private function getTanksAllCategories()
	{
		return \DataCmsDeptsRel::query()
		->where('Core_Depts_ID = :core_dept:', ['core_dept'=>$this->core_dept_id])
		->andWhere('Application_ID = :app_id:', ['app_id'=>$this->application_id])
		->andWhere('Module_ID = :module_id:', ['module_id'=>$this->module_id])

		->execute();
	}

	private function getTanksCategoriesUsingIDs($ids=[])
	{
		if(count($ids))
		{
			return \DataCmsDeptsRel::query()
			->where('Core_Depts_ID = :core_dept:', ['core_dept'=>$this->core_dept_id])
			->andWhere('Application_ID = :app_id:', ['app_id'=>$this->application_id])
			->andWhere('Module_ID = :module_id:', ['module_id'=>$this->module_id])
			->orderBy('Orders asc')
			->inWhere('ID', $ids)->execute();
		}
		else
		{
			return null;
		}
	}

	public function deleteAction($id)
	{
		$response['status'] = 0;
		$response['msg'] = '';

        if(in_array($id,[80,81,82,83])){
            $response['msg'] = 'لا يمكن حذف هذا القسم';
            return json_encode($response);
        }

		$category = $this->getTanksSingleCategory($id);

		if(!$category)
		{
			$response['msg'] = 'القسم غير صحيح';
			return json_encode($response);
		}

		$cat_rel_items = $category->DeptsContent;

		if(!$category->delete())
		{
			$response['msg'] = 'خطأ أثناء حذف القسم، حاول مرة أخرى';
			return json_encode($response);
		}

		foreach ($cat_rel_items as $item) 
		{
			$item->delete();
		}

		$response['status'] = 1;
		$response['msg']    = 'تم حذف القسم بنجاح';

		return json_encode($response);
	}

	public function deleteSelectedAction()
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$ids = $this->request->getPost('ids');

		$categories = $this->getTanksCategoriesUsingIDs($ids);

		foreach($categories as $category)
		{
			$category_rel_items = $category->DeptsContent;

			if(!$category->delete())
			{
				$response['msg'] = 'خطأ أثناء حذف القسم، حاول مرة أخرى';

				return json_encode($response);
			}

			foreach ($category_rel_items as $item) 
			{
				$item->delete();
			}
		}

		$response['status'] = 1;
		$response['msg'] = 'تم حذف الأقسام بنجاح';

		return json_encode($response);
	}

	public function activateSelectedAction()
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$ids = $this->request->getPost('ids');
		$categories = $this->getTanksCategoriesUsingIDs($ids);

		foreach ($categories as $category) 
		{
			if($category->Active != 1)
			{
				$category->Active = 1;

				if(!$category->save())
				{
					$response['msg'] = 'خطأ أثناء تفعيل القسم، حاول مرة أخرى';

					return json_encode($response);
				}
			}
		}

		$response['status'] = 1;
		$response['msg'] = 'تم تفعيل الأقسام بنجاح';

		return json_encode($response);
	}

	public function deactivateSelectedAction()
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$ids = $this->request->getPost('ids');
		$categories = $this->getTanksCategoriesUsingIDs($ids);

		foreach ($categories as $category) 
		{
			if($category->Active == 1)
			{
				$category->Active = 0;

				if(!$category->save())
				{
					$response['msg'] = 'خطأ أثناء إلغاء تفعيل القسم، حاول مرة أخرى';

					return json_encode($response);
				}
			}
		}

		$response['status'] = 1;
		$response['msg'] = 'تم عدم تفعيل الأقسام بنجاح';

		return json_encode($response);
	}

	public function addAction()
	{
		$this->view->categories = $this->getTanksAllCategories();
	}

	public function saveAction($category_id=null)
	{
		$name_ar            = $this->request->getPost('name_ar');
		$name_en            = $this->request->getPost('name_en');
		$parent_category_id = $this->request->getPost('paret_category_id');
		$order              = $this->request->getPost('order');
		$des_ar             = $this->request->getPost('des_ar');
		$des_en             = $this->request->getPost('des_en');
		$show_in_home_page  = $this->request->getPost('show_in_home_page');
		$active             = $this->request->getPost('active');
		$img_title          = $this->request->getPost('img_title');
		$img_alt            = $this->request->getPost('img_alt');
		$meta_keywords      = $this->request->getPost('meta_keywords');
		$meta_desc          = $this->request->getPost('meta_desc');
		$meta_title         = $this->request->getPost('meta_title');
		$page_title         = $this->request->getPost('page_title');
		$discount_name      = $this->request->getPost('discount_name');
		$discount_percent   = $this->request->getPost('discount_percent');
		$discount_coupon    = $this->request->getPost('discount_coupon');
		$start_date         = $this->request->getPost('start_date');
		$end_date           = $this->request->getPost('end_date');
		$maintainable       = $this->request->getPost('maintainable');
		$videos             = $this->request->getPost('videos');

		$from_action = $this->request->getPost('from_action');

		// $upload_file_service = new FileUploadService('uploads/users');
		// $uploaded_files_paths = $upload_file_service->upload($this->request);

		$main_image_path = '';
		$uploaded_files_paths = [];

		if($this->request->hasFiles())
		{
			foreach($this->request->getUploadedFiles() as $file)
			{
				if($file->isUploadedFile())
				{
					$extension = $file->getExtension();
					$file_name = time() . str_random(16) . '.' . $extension;
					$file_path = 'uploads/users/'.$file_name;
					$file->moveTo($file_path);

					if($file->getKey() == 'main_image')
					{					
						$main_image_path = 'users/' . $file_name;
					}
					else
					{
						$uploaded_files_paths[] = $file_name;
					}
				}
			}
		}


		$category = new \DataCmsDeptsRel;

		if(isset($category_id))
		{
			$category = $this->getTanksSingleCategory($category_id);

			if(!$category)
			{
				$category = new \DataCmsDeptsRel;
			}
		}

		$category->Title                  = $name_en;
		$category->Parent_Depts_ID        = $parent_category_id;
		$category->Application_ID         = $this->application_id;
		$category->Module_ID              = $this->module_id;
		$category->Core_Depts_ID          = $this->core_dept_id;
		$category->Des                    = $des_en;
		$category->Orders                 = (isset($order) && strlen($order) > 0)?$order:0;
		$category->Active                 = isset($active)?1:0;
		$category->show_in_homepage       = isset($show_in_home_page)?1:0;

		if($from_action == 'edit')
		{
			if($category->Img == 0)
			{
				if(strlen($main_image_path) > 0)
				{
					$category->Img = $main_image_path;
				}
//				else
//				{
//					$category->Img = 0;
//				}
			}
		}
		else
		{
			if(strlen($main_image_path) > 0)
			{
				$category->Img = $main_image_path;
			}
			else
			{
				$category->Img = 0;
			}
		}

		$category->subject_to_maintenance = isset($maintainable)?1:0;

		if($from_action != 'edit')
		{
			$category->created_at = date('Y-m-d H:i:s');
		}

		if(!$category->save())
		{
			var_dump($category->getMessages());die;
			if($from_action == 'edit')
			{
				$this->redirectService->withMessage('error', 'خطأ أثناء تعديل القسم، حاول مرة أخرى', 
					$this->url->get('categories/edit/'.$category_id));
				return;
			}

			$this->redirectService->withMessage('error', 'خطأ أثناء حفظ القسم، حاول مرة أخرى', 
				$this->url->get('categories/add'));
			return;
		}

        //check for attributes
        $data_kv_dept_cms=\DataKeyvalueDeptCms::find(["dept_id={$category->ID}"]);
        foreach ($data_kv_dept_cms as $v){
            $v->delete();
        }
        $keyvalue = new Keyvalue();
        $category_attributes = $keyvalue->getKeyvalues(0, 2, 4);
        foreach ($category_attributes as $group) {
            foreach ($group['keyvalues'] as $attribute) {
                if ($this->request->getPost("keyvalue_attribute{$attribute['kv_id']}")) {
                    $data_keyvalue_dept_cms = \DataKeyvalueDeptCms::findFirst(["dkv_id={$attribute['kv_id']} and dept_id={$category->ID}"]);
                    if (!$data_keyvalue_dept_cms) {
                        $data_keyvalue_dept_cms = new \DataKeyvalueDeptCms();
                        $data_keyvalue_dept_cms->dkv_id = $attribute['kv_id'];
                        $data_keyvalue_dept_cms->dept_id = $category->ID;
                        $data_keyvalue_dept_cms->application_id = $category->Application_ID;
                        if (!$data_keyvalue_dept_cms->save()) {
                            foreach ($data_keyvalue_dept_cms->getMessages() as $msg) {
                                $this->falshSession->error($msg);
                            }
                        };
                    }
                }
            }
        }

		// handle media
		$category_media = \DataCmsMedia::find([
			'dept_id = :dept: and Type = :type:',
			'bind' => [
				'dept' => $category->ID,
				'type' => 'Img'
			] 
		]);

		if(count($uploaded_files_paths) > 0)
		{
//			foreach($category_media as $media)
//			{
//				$media->delete();
//			}

			foreach($uploaded_files_paths as $key=>$img_path)
			{
				$category_media = new \DataCmsMedia;

				$category_media->Application_ID = $this->application_id;
				$category_media->Module_ID      = $this->module_id;
				$category_media->Type           = 'Img';
				$category_media->datetime       = date('Y-m-d H:i:s');
				$category_media->dept_id        = $category->ID;
				$category_media->Img            = 'uploads/users/'.$img_path;

				if(count($img_title) > 0)
				{
					$category_media->img_title      = $img_title[$key];
				}

				if(count($img_alt) > 0)
				{
					$category_media->img_alt        = $img_alt[$key];
				}

				$category_media->save();
			}
		}

		if(count($videos))
		{
			$category_videos = \DataCmsMedia::find([
			'dept_id = :dept: and Type = :type:',
			'bind' => [
				'dept' => $category->ID,
				'type' => 'Video'
			]
			]);

			foreach($category_videos as $cat_video)
			{
				$cat_video->delete();
			}

			foreach($videos as $video)
			{
				$category_video = new \DataCmsMedia;

				$category_video->Application_ID = $this->application_id;
				$category_video->Module_ID      = $this->module_id;
				$category_video->Type           = 'Video';
				$category_video->datetime       = date('Y-m-d H:i:s');
				$category_video->dept_id        = $category->ID;
				$category_video->Img            = 0;
				$category_video->Link           = $video;

				$category_video->save();

			}
		}

		// handle languages
		$category_lang_ar = new \DataCmsDeptsRelLang;
		$category_lang_en = new \DataCmsDeptsRelLang;

		if(isset($category_id))
		{
			$category_lang_ar = \DataCmsDeptsRelLang::query()
			->where('dept_id = :dept:', ['dept'=>$category_id])
			->andWhere('lang_id = 1')->execute()->getFirst();

			if(!$category_lang_ar)
			{
				$category_lang_ar = new \DataCmsDeptsRelLang;
			}

			$category_lang_en = \DataCmsDeptsRelLang::query()
			->where('dept_id = :dept:', ['dept'=>$category_id])
			->andWhere('lang_id = 2')->execute()->getFirst();

			if(!$category_lang_en)
			{
				$category_lang_en = new \DataCmsDeptsRelLang;
			}
		}

		$category_lang_ar->dept_id = $category->ID;
		$category_lang_ar->title   = $name_ar;
		$category_lang_ar->des     = $des_ar;
		$category_lang_ar->lang_id = 1;

		$category_lang_ar->save();

		$category_lang_en->dept_id = $category->ID;
		$category_lang_en->title   = $name_en;
		$category_lang_en->des     = $des_en;
		$category_lang_en->lang_id = 2;

		$category_lang_en->save();

		$category_seo = new SeoSettings;

		if(isset($category_id))
		{
			$category_seo = SeoSettings::findFirst([
				'dept_id = :dept:',
				'bind' => [
					'dept' => $category_id
				]
			]);

			if(!$category_seo)
			{
				$category_seo = new SeoSettings;
			}
		}

		// handle SEO settings
		$category_seo->dept_id = $category->ID;
		$category_seo->meta    = $meta_keywords;
		$category_seo->meta_description = $meta_desc;
		$category_seo->title_description = $meta_title;
		$category_seo->page_title = $page_title;

		$category_seo->save();
		//Tax 01/05/2018
        $dept_tax = TanksTaxes::findFirst(["dept_id={$category->ID}"]);
        if(!$dept_tax){
            $dept_tax= new TanksTaxes();
            $dept_tax->dept_id= $category->ID;
        }
        $dept_tax->tax = $this->request->getPost("cat_tax","int");
        $dept_tax->save();

		// TODO handle saving the discount to a department...

		if($from_action == 'edit')
		{
			$this->redirectService->withMessage('success', 'تم تعديل القسم بنجاح', 
				$this->url->get('categories/index'));
			return;			
		}

		$this->redirectService->withMessage('success', 'تم حفظ القسم بنجاح', 
			$this->url->get('categories/index'));
		return;
	}

	public function editAction($category_id)
	{
		$this->view->category   = $this->getTanksSingleCategory($category_id);
		$this->view->categories = $this->getTanksAllCategories();
        //language id for view language
        $lang_code = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$lang_code}'"]);
        $this->view->lang = $lang->id;
        //New Keyvalue Type
        $keyvalue = new Keyvalue();
        $category_attributes = $keyvalue->getKeyvalues(0, 2, 4,null,$lang->id);
        $this->view->category_attributes = $category_attributes;
        //Set Default Keyvalues Type 2
        $data_kv_dept_cms=\DataKeyvalueDeptCms::find(["dept_id=$category_id"]);
        foreach ($data_kv_dept_cms as $v){
            $this->tag->setDefault("keyvalue_attribute{$v->dkv_id}", $v->dkv_id);
        }

        //New Tax 01/05/2018
        $this->view->cat_tax = 0;
        $dept_tax = TanksTaxes::findFirst(["dept_id={$category_id}"]);
        if($dept_tax){
            $this->view->cat_tax = $dept_tax->tax;
        }
	}

	public function viewAction($category_id)
	{
		$category = $this->getTanksSingleCategory($category_id);

		if($category)
		{
			$this->view->category = $this->getTanksSingleCategory($category_id);
			$this->view->lang     = $this->session->get('auth-identity')['Lang_ID'];
			$this->view->manufacturers = \DataCmsDeptsRel::find([
	            'Core_Depts_ID = :core_dept: and Module_ID = :module:',
	            'bind' => [
	                'core_dept' => 5,
	                'module'    => $this->module_id
	            ]
	            ]);
		}
		else
		{
			$this->flashSession->error('القسم غير موجود');
			return $this->response->redirect('categories/index');
		}
		
	}

	public function filterCategoryProductsAction()
	{
		$builder = $this->modelsManager->createBuilder()->from(Content::class)
        ->where('Module_ID = :module_id:', ['module_id' => $this->module_id]);

        $product_name = $this->request->getPost('name');
        $manfct       = $this->request->getPost('manfct');
        $price_from   = $this->request->getPost('price_from');
        $price_to     = $this->request->getPost('price_to');
        $category_id  = $this->request->getPost('category_id');


        $category = \DataCmsDeptsRel::findFirst($category_id);

        $category_products_ids = [];

        foreach($category->items as $product)
        {
        	$category_products_ids[] = $product->ID;
        }

        if(isset($product_name) && strlen($product_name) > 0)
        {
            $builder->andWhere('Title like :name:', [
                'name' => '%'.$product_name.'%'
                ]);
        }

        $manfacts_items_rel = $this->modelsManager->createBuilder()
	        ->from(\DataCmsDeptsRelItem::class)
	        ->columns('Item_ID');

        $extra_fields = $this->modelsManager->createBuilder()
            ->from(ProductExtraFields::class)
            ->columns('item_id');

        $valid_manfact    = (isset($manfct) && strlen($manfct) > 0)?true:false;
        $valid_catgs      = (isset($categories) && count($categories) > 0)?true:false;
        $valid_price_from = (isset($price_from) && strlen($price_from) > 0)?true:false;
        $valid_price_to   = (isset($price_to) && strlen($price_to) > 0)?true:false;


        $items_ids = [];

        if($valid_manfact)
        {
            $manfacts_items_rel->where('Depts_ID = :manfct:', ['manfct'=>$manfct]);
            $manfacts_items_ids   = $manfacts_items_rel->getQuery()->execute()->toArray();
            // var_dump($manfacts_items_ids);die();
            foreach($manfacts_items_ids as $m_item_id)
	        {
	            if(!in_array(current($m_item_id), $items_ids))
	            {
	                $items_ids[] = current($m_item_id);
	            }
	        }
        }

        if($valid_price_from && $valid_price_to)
        {
            $extra_fields->betweenWhere('price', $price_from, $price_to);
        }
        elseif($valid_price_from && !$valid_price_to)
        {
            $extra_fields->andWhere('price = :price:', ['price' => $price_from]);
        }
        elseif(!$valid_price_from && $valid_price_to)
        {
            $extra_fields->andWhere('price = :price:', ['price' => $price_to]);
        }
        else
        {
            $extra_fields->betweenWhere('price', 0, 0);
        }

        $extra_fields_result  = $extra_fields->getQuery()->execute()->toArray();

        foreach($extra_fields_result as $e_item_id)
        {
            if(!in_array(current($e_item_id), $items_ids))
            {
                $items_ids[] = current($e_item_id);
            }
        }

        if($valid_manfact || $valid_price_from || $valid_price_to)
        {
            $builder->inWhere('ID', $items_ids);
        }

        $products = $builder->columns('ID')->getQuery()->execute()->toArray();

        $filtered_products_ids = [];

        foreach($products as $product_id)
        {
        	if(in_array(current($product_id), $category_products_ids))
        	{
        		$filtered_products_ids[] = current($product_id);
        	}
        }

        $products = Content::query()->inWhere('ID', $filtered_products_ids)->execute();

        $products_view = $this->view->getRender('partials', 'categoryProducts', [
        	'products' => $products
        ]);

        $response['content'] = $products_view;

        return json_encode($response);
	}

	public function addCategoryDiscountAction()
	{
		$validator = new RequestValidation($this->request);

		$validator->required([
			'discount_name', 'discount_percent', 'start_date', 'end_date'
		]);

		$validation_result = $validator->validate();

		$category_id      = $this->request->getPost('category_id');

		if(count($validation_result))
		{
			foreach($validation_result as $result)
			{
				$this->session->set($result['field'], $result['message']);
			}

			return $this->response->redirect('categories/view/'.$category_id.'/#discounts');
		}

		$discount_name    = $this->request->getPost('discount_name');
		$discount_percent = $this->request->getPost('discount_percent');
		$discount_coupon  = $this->request->getPost('discount_coupon');
		$start_date       = $this->request->getPost('start_date');
		$end_date         = $this->request->getPost('end_date');

		$discount = new Discounts;

		$discount->name        = $discount_name;
		$discount->percentage  = $discount_percent;
		$discount->coupon      = $discount_coupon;
		$discount->start_date  = strtotime($start_date);
		$discount->end_date    = strtotime($end_date);
		$discount->category_id = $category_id;
		$discount->created_at  = time();
		$discount->updated_at  = time();

		if(!$discount->save())
		{
			$this->flashSession->error('خطأ أثناء حفظ الخصم، حاول مرة أخرى');
			return $this->response->redirect('categories/view/'.$category_id.'/#discounts');
		}

		$category = $this->getTanksSingleCategory($category_id);

		foreach($category->items as $product)
		{
			$discount_rel_item = new DiscountRelItems;

			$discount_rel_item->discount_id = $discount->id;
			$discount_rel_item->data_cms_id = $product->ID;
			$discount_rel_item->created_at  = time();
			$discount_rel_item->updated_at  = time();

			$discount_rel_item->save();

			$product_extra_field = ProductExtraFields::findFirst([
				'item_id = :product_id:',
				'bind' => [
					'product_id' => $product->ID
				]
			]);

			if($product_extra_field)
			{
				$product_extra_field->price = ($product_extra_field->old_price * $discount_percent) / 100;

				$product_extra_field->save();
			}
		}

		$this->flashSession->success('تم حفظ الخصم بنجاح');
		return $this->response->redirect('categories/view/'.$category_id.'/#discounts');
	}

	public function filterCategoryDiscountsAction()
	{
		$discount_name    = $this->request->getPost('discount_name');
		$discount_percent = $this->request->getPost('discount_percent');
		$discount_coupon  = $this->request->getPost('discount_coupon');
		$start_date       = $this->request->getPost('start_date');
		$end_date         = $this->request->getPost('end_date');
		$category_id      = $this->request->getPost('category_id');

		$builder = $this->modelsManager->createBuilder()->from(['discount'=>Discounts::class])
		->where('category_id = :category_id:', ['category_id'=>$category_id]);

		$valid_discount_name = (isset($discount_name) && strlen($discount_name) > 0)?true:false;
		$valid_discount_percent = (isset($discount_percent) && strlen($discount_percent) > 0)?true:false;
		$valid_discount_coupon = (isset($discount_coupon) && strlen($discount_coupon) > 0)?true:false;
		$valid_start_date = (isset($start_date) && strlen($start_date) > 0)?true:false;
		$valid_end_date = (isset($end_date) && strlen($end_date) > 0)?true:false;


		if($valid_discount_name)
		{
			$builder->andWhere('discount.name like :name:', ['name' => '%'.$discount_name.'%']);
		}

		if($valid_discount_percent)
		{
			$builder->andWhere('discount.percentage = :percent:', ['percent' => $discount_percent]);
		}

		if($valid_discount_coupon)
		{
			$builder->andWhere('discount.coupon like :coupon:', ['coupon' => '%'.$discount_coupon.'%']);
		}

		if($valid_start_date)
		{
			$start_date = date('Y-m-d', strtotime($start_date));
			$builder->andWhere('date(from_unixtime(discount.start_date)) = :start_date:', [
				'start_date' => $start_date
			]);
		}

		if($valid_end_date)
		{
			$end_date = date('Y-m-d', strtotime($end_date));
			$builder->andWhere('date(from_unixtime(discount.end_date)) = :end_date:', [
				'end_date' => $end_date
			]);
		}

		$filtered_discounts = $this->view->getRender('categories/partials', 'filteredDiscounts', [
			'discounts' => $builder->getQuery()->execute()
		]);

		return json_encode(['content' => $filtered_discounts]);
	}

	public function delete_mediaAction($id){
        $id =(int)$id;
        $media=\DataCmsMedia::findFirst(["ID={$id}"]);
        if($media){
            $media->delete();
            unlink(BASE_URL."public/".$media->Img);
        }
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }
}