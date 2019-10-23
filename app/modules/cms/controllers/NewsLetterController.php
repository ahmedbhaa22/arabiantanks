<?php

namespace Vokuro\Cms\Controllers;

use Models\DataCmsSavedFilter;
use Models\EntityTags;
use Models\NewsLetter;
use Phalcon\Mvc\Model\Resultset\Simple;
use Vokuro\Controllers\ControllerBase;

use Models\Content;
use Models\DataCmsFilterSearch;
use Phalcon\Http\Request;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Mvc\Url;
use Vokuro\Forms\AdvancedSearchForm;
use Vokuro\Models\ProductExtraFields;
use Vokuro\Models\Tags;
use Vokuro\Pentavalue\Keyvalue;
use Phalcon\Mvc\Model\Query\Builder;


class NewsLetterController extends ControllerBase
{
    public function indexAction(){
        $application_id= $this->session->get('auth-identity')['Application_ID'];
        $newsletter = NewsLetter::find(["application_id={$application_id}"]);
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'NewsLetter', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $paginator = new Paginator([
            'data' => $newsletter,
            'limit' => 30,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
    }

    public function newMailAction(){

    }

    public function sendAction(){
        if(!$this->request->isPost()){
            die("Not Allowed");
        }
        $content_mails = CharityNewsLetter::find(
            array(
                "application_id=583",
                "order" => "id Desc"
            ));
        $title = $this->request->getPost('Title');
        $content = $this->request->getPost('Content');
        foreach($content_mails as $value){
            $this->sendNewsLetter($title, $content, $value->email);
        }
        $this->flashSession->success("News Letter Has Been Sent");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    public function exportAction(){
        $application_id= $this->session->get('auth-identity')['Application_ID'];
        $content_mails = NewsLetter::find(
            array(
                "application_id={$application_id}",
                "order" => "id Desc"
            ));
        $output ="";

        foreach ($content_mails as $mail){
            $output .='"'.$mail->mail.'",';
            $output .="\n";
        }
        $filename = "NewsLetter.csv";
        header('Content-type: application/csv');
        header('Content-Disposition: attachment; filename='.$filename);

        echo $output;
        exit;
    }

    public function sendNewsLetter($title,$content,$mail){
        $this->getDI()
            ->getMail()
            ->send([
                $mail => $mail
            ], "News Letter", 'news_letter', [
                'content' => $content,
                'title' => $title,
            ]);
    }

}