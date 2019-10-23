<?php

namespace Vokuro\Cms\Controllers;

use Vokuro\Controllers\ControllerBase;
use Vokuro\Models\CompanyPaymentMethods;
use Vokuro\Pentavalue\RequestValidation;

class PaymentMethodsController extends ControllerBase
{
	public function indexAction()
	{
		$this->view->payment_methods = CompanyPaymentMethods::find();
	}

	public function newAction()
	{

	}

	public function editAction($bank_id)
	{
		$this->view->bank = CompanyPaymentMethods::findFirst([
			'id = :id:',
			'bind' => [
				'id' => $bank_id
			]
		]);
	}

	public function saveAction($bank_id=null)
	{
		$from_action = $this->request->getPost('from_action');

		if(!$this->request->isPost())
		{
			$this->flashSession->error('Request error');
			return $this->response->redirect($this->url->getStatic('cms_module/payment_methods/index'));
		}

		$validator = new RequestValidation($this->request);

		$validation_result = $validator->required([
			'bank_name', 'account_name', 'account_number'
		])->validate();

		if(count($validation_result))
		{
			$this->session->set('error_msgs', $validation_result);

			if($from_action == 'edit' && isset($bank_id))
			{
				return $this->response->redirect($this->url->getStatic('cms_module/payment_methods/edit/'.$bank_id));
			}
			else
			{
				return $this->response->redirect($this->url->getStatic('cms_module/payment_methods/new'));
			}
		}

		$bank_name      = $this->request->getPost('bank_name');
		$account_name   = $this->request->getPost('account_name');
		$account_number = $this->request->getPost('account_number');

		$bank = null;

		if(isset($bank_id) && $from_action == 'edit')
		{
			$bank = CompanyPaymentMethods::findFirst([
				'id = :id:',
				'bind' => [
					'id' => $bank_id
				]
			]);

			if(!$bank)
			{
				$bank = new CompanyPaymentMethods;
			}
		}
		else
		{
			$bank = new CompanyPaymentMethods;
		}

		$bank->bank_name      = $bank_name;
		$bank->account_name   = $account_name;
		$bank->account_number = $account_number;
		$bank->company_id     = 1;

		if(!$bank->save())
		{
			$this->flashSession->error('خطأ أثناء حفظ البنك، حاول مرة أخرى');

			if($from_action == 'edit' && isset($bank_id))
			{
				return $this->response->redirect($this->url->getStatic('cms_module/payment_methods/edit/'.$bank_id));
			}
			else
			{
				return $this->response->redirect($this->url->getStatic('cms_module/payment_methods/new'));
			}
		}

		$this->flashSession->success('تم حفظ البنك بنجاح');
		return $this->response->redirect($this->url->getStatic('cms_module/payment_methods/index'));
	}

	public function deleteAction($bank_id)
	{
		$response['status'] = 0;
		$response['msg']    = '';

		$bank = CompanyPaymentMethods::findFirst([
			'id = :id:',
			'bind' => [
				'id' => $bank_id
			]
		]);

		if(!$bank)
		{
			$response['msg'] = 'البنك غير موجود';
			return json_encode($response);	
		}

		if(!$bank->delete())
		{
			$response['msg'] = 'خطأ أثناء حذف البنك، حاول مرة أخرى';
			return json_encode($response);
		}

		$response['status'] = 1;
		$response['msg']    = 'تم حذف البنك بنجاح';
		
		return json_encode($response);
	}

	public function deleteSelectedAction()
	{
		$response['status'] = 0;
		$response['msg']    = '';

		$ids = $this->request->getPost('ids');

		$banks = CompanyPaymentMethods::query()
		->inWhere('id', $ids)->execute();

		foreach($banks as $bank)
		{
			if($bank instanceof CompanyPaymentMethods)
			{
				if(!$bank->delete())
				{
					$response['msg'] = 'خطأ أثناء حذف البنك، حاول مرة أخرى';
					return json_encode($response);
				}
			}
		}

		$response['status'] = 1;
		$response['msg']    = 'تم حذف البنوك بنجاح';

		return json_encode($response);
	}
}