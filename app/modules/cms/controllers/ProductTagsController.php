<?php
namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\Models\Tags;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;

class ProductTagsController extends ControllerBase
{
	public function initialize()
	{
		parent::initialize();
		$this->redirectService->setControllerObj($this);
	}

	public function indexAction()
	{
		$page = $this->request->get('page');
		$page = isset($page)?$page:1;

		$tags_builder = $this->modelsManager->createBuilder()
		->from(Tags::class);


		$paginator = new PaginatorQueryBuilder([
			'builder' => $tags_builder,
			'limit'   => 5,
			'page'    => $page
		]);

		$this->view->page = $paginator->getPaginate();
	}

	public function deleteAction($tag_id)
	{
		$response['status'] = 0;
		$response['msg']    = '';

		$tag = Tags::findFirst($tag_id);

		if(!$tag)
		{
			$response['msg'] = 'التاج غير صحيح';
			return json_encode($response);
		}

		if(!$tag->delete())
		{
			$response['msg'] = 'خطأ أثناء مسح التاج، حاول مرة أخرى';
			return json_encode($response);
		}

		$response['status'] = 1;
		$response['msg']    = 'تم مسح التج بنجاح';

		return json_encode($response);
	}

	public function deleteSelectedAction()
	{
		$response['status'] = 0;
		$response['msg'] = '';

		$ids = $this->request->getPost('selected_ids');

		$tags = Tags::query()->inWhere('id', $ids)->execute();

		foreach($tags as $tag)
		{
			if(!$tag->delete())
			{
				$response['msg'] = 'خطأ أثناء حذف التاج، حاول مرة أخرى';
				return json_encode($response);
			}
		}

		$response['status'] = 1;
		$response['msg'] = 'تم حذف التاجات بنجاح';

		return json_encode($response);
	}
}