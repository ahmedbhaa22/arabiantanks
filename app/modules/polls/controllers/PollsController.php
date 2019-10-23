<?php

namespace Vokuro\Polls\Controllers;

use Google\Cloud\Storage\StorageClient;
use League\Flysystem\Filesystem;
use Models\TanksPollsVisits;
use Models\UserCategories;
use Superbalist\Flysystem\GoogleStorage\GoogleStorageAdapter;
use Vokuro\Controllers\ControllerBase;
use Vokuro\Polls\Models\Answers;
use Vokuro\Polls\Models\PollQuestionsUsers;
use Vokuro\Polls\Models\Polls;
use Vokuro\Polls\Models\Questions;
use Vokuro\Polls\Models\Settings;
use google\appengine\api\cloud_storage\CloudStorageTools;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Models\UsersMobile;
use Vokuro\Polls\Services\PollService;
use Vokuro\UsersModule\Models\UserData;

class PollsController extends ControllerBase
{
    public $MODULE_ID = 9;

    public function initialize()
    {
        parent::initialize();
        $app_id = $this->auth->getIdentity()["Application_ID"];
        $settings = Settings::query()->where("application_id = {$app_id}")->execute()->getFirst();
        if (!$settings) {
            $settings = new Settings;
            $settings->application_id = $app_id;
            $settings->save();
        }

        $this->settings = $settings;

        $this->view->settings = $settings;
    }

    public function createAction()
    {
        if ($this->settings->use_fb) {
            return $this->response->redirect("polls/create_fire");
        }

    }

    public function create_fireAction()
    {

    }

    public function storeAction()
    {
        $app_id = $this->auth->getIdentity()["Application_ID"];
        // store poll
        $poll = new Polls;
        $poll->name = $this->request->getPost('name');
        $poll->application_id = $app_id;
        $poll->mobule_id = $this->MODULE_ID;
        $poll->created_at = time();
        $poll->modified_at = time();
        $poll->save();


        // store questions
        if ($this->request->getPost('questions')) {
            foreach ($this->request->getPost('questions') as $q => $question) {
                $newQuestion = new Questions;
                $newQuestion->text = $question["text"];
                $newQuestion->poll_id = $poll->id;
                $newQuestion->data_type_id = 0;
                $newQuestion->save();

                // store answers for the question
                foreach ($question['answers'] as $key => $answer) {
                    $newAnswer = new Answers;

                    if ($_FILES["questions"]["tmp_name"][$q]["answers"][$key]) {
                        $file = $_FILES["questions"]["tmp_name"][$q]["answers"][$key];
                        $path = 'polls/uploads';
                        $path = "$path/" . md5(uniqid(rand(), true));
                        move_uploaded_file($file, $path . ".jpg");
                        $newAnswer->photo = $path . ".jpg";
                    }

                    $newAnswer->text = $answer;
                    $newAnswer->question_id = $newQuestion->id;
                    $newAnswer->save();
                }
            }
        }


        $this->response->redirect('polls/view/' . $poll->id);
    }

    public function store_fireAction()
    {

        // Your Google Cloud Platform project ID
        $projectId = 'AIzaSyB3SSCHIZlBsVcaildCtAqUSE6Tmn31EQg';

        $DEFAULT_URL = $this->settings->fb_url;
        $DEFAULT_TOKEN = $this->settings->fb_token;
        $DEFAULT_PATH = '/data';

        $firebase = new \Firebase\FirebaseLib($DEFAULT_URL, $DEFAULT_TOKEN);

        $storageClient = new StorageClient([
            'projectId' => $this->settings->fb_project_id,
            'keyFilePath' => BASE_PATH . '/' . $this->settings->fb_service_key,
        ]);

        $bucket = $storageClient->bucket($this->settings->fb_bucket_name);

        $adapter = new GoogleStorageAdapter($storageClient, $bucket);

        $filesystem = new Filesystem($adapter);

        $questions = [];
        $event_id = rand(100, 1000);
        foreach ($this->request->getPost('questions') as $q => $question) {
            $questions[$question["text"]] = [];
            $firebase->set($DEFAULT_PATH . '/' . $question["text"], ["event_id" => $event_id]);
            foreach ($question["answers"] as $key => $answer) {

                if ($_FILES["questions"]["tmp_name"][$q]["answers"][$key]) {

                }
                $file = $_FILES["questions"]["tmp_name"][$q]["answers"][$key];

                $file_name = rand(100, 1000) . "-" . $_FILES["questions"]["name"][$q]["answers"][$key];
                $filesystem->write($file_name, file_get_contents($file));
                // die(var_dump($filesystem->getMetadata($file_name)));
                // $contents = $filesystem->read('581204_231468613627008_972804652_n.jpg');
                // $stream = fopen($_FILES["questions"]["tmp_name"][$q]["answers"][$key], 'r+');
                // $filesystem->writeStream($_FILES["questions"]["name"][$q]["answers"][$key], $stream);
                // fclose($stream);

                $a = [];
                $a["name"] = $answer["text"];
                $a["rate"] = 0;
                $a["image_url"] = "https://firebasestorage.googleapis.com/v0/b/{$this->settings->fb_project_id}.appspot.com/o/" . $file_name . "?alt=media";
                $firebase->set($DEFAULT_PATH . '/' . $question["text"] . "/" . $answer["text"], $a);
            }
        }

        $this->response->redirect('index/fire');
    }

    public function editAction($id)
    {
        if ($this->settings->use_fb) {
            return $this->response->redirect("polls/edit_fire");
        }
        $this->view->poll = Polls::findFirst($id);
    }

    public function edit_fireAction($event_id)
    {
        $DEFAULT_URL = 'https://tabyb-com.firebaseio.com/';
        $DEFAULT_TOKEN = 'bE5pTGY6hd0x5qJNJsSGBXYM3nPhgpQVl8rv8KoP';
        $DEFAULT_PATH = '/data';

        $firebase = new \Firebase\FirebaseLib($DEFAULT_URL, $DEFAULT_TOKEN);
        $questions = json_decode($firebase->get($DEFAULT_PATH, array('orderBy' => '"event_id"', 'equalTo' => $event_id)), true);

        // die(var_dump($questions));
        $this->view->event_id = $event_id;
        $this->view->questions = $questions;
    }

    public function updateAction($id)
    {
        $poll = Polls::findFirst($id);
        $poll->name = $this->request->getPost('name');
        $poll->modified_at = time();
        $poll->save();
        // die(var_dump($this->request->getPost()['questions']));
        // update
        if ($this->request->getPost('questions')) {
            foreach ($this->request->getPost('questions') as $q => $question) {
                if (isset($question["id"])) {
                    // question exists, update
                    $newQuestion = Questions::findFirst($question["id"]);
                    $newQuestion->text = $question["text"];
                    $newQuestion->save();

                } else {
                    // new question
                    $newQuestion = new Questions;
                    $newQuestion->text = $question["text"];
                    $newQuestion->poll_id = $poll->id;
                    $newQuestion->data_type_id = 0;
                    $newQuestion->save();

                }


                // store answers for the question
                foreach ($question['answers'] as $key => $answer) {
                    if (isset($answer["id"])) {
                        // questions fucking exists
                        $file = $_FILES["questions"]["tmp_name"][$q]["answers"][$key];
                        $path = 'polls/uploads';
                        $path = "$path/" . md5(uniqid(rand(), true));
                        move_uploaded_file($file, $path . ".jpg");

                        $newAnswer = Answers::findFirst($answer["id"]);
                        $newAnswer->text = $answer["text"];
                        $newAnswer->photo = $path;
                        $newAnswer->save();
                    } else {
                        $file = $_FILES["questions"]["tmp_name"][$q]["answers"][$key];
                        $path = 'polls/uploads';
                        $path = "$path/" . md5(uniqid(rand(), true));
                        move_uploaded_file($file, $path . ".jpg");

                        $newAnswer = new Answers;
                        $newAnswer->text = $answer;
                        $newAnswer->question_id = $newQuestion->id;
                        $newAnswer->photo = $path;
                        $newAnswer->save();
                    }

                }
            }
        }

        $this->response->redirect('index');
    }

    public function update_fireAction($event_id)
    {
        $projectId = 'AIzaSyB3SSCHIZlBsVcaildCtAqUSE6Tmn31EQg';

        $DEFAULT_URL = $this->settings->fb_url;
        $DEFAULT_TOKEN = $this->settings->fb_token;
        $DEFAULT_PATH = '/data';

        $firebase = new \Firebase\FirebaseLib($DEFAULT_URL, $DEFAULT_TOKEN);

        $storageClient = new StorageClient([
            'projectId' => $this->settings->fb_project_id,
            'keyFilePath' => BASE_PATH . '/' . $this->settings->fb_service_key,
        ]);

        $bucket = $storageClient->bucket($this->settings->fb_bucket_name);

        $adapter = new GoogleStorageAdapter($storageClient, $bucket);

        $filesystem = new Filesystem($adapter);
        $events = json_decode($firebase->get($DEFAULT_PATH, array('orderBy' => '"event_id"', 'equalTo' => "$event_id")), true);

        foreach ($events as $key => $event) {
            $x = $firebase->delete($DEFAULT_PATH . "/" . $key);

        }

        $questions = [];
        foreach ($this->request->getPost('questions') as $q => $question) {
            $questions[$question["text"]] = [];
            $firebase->set($DEFAULT_PATH . '/' . $question["text"], ["event_id" => (int)$event_id]);
            foreach ($question["answers"] as $key => $answer) {
                $a = [];

                if ($_FILES["questions"]["tmp_name"][$q]["answers"][$key]) {
                    $file = $_FILES["questions"]["tmp_name"][$q]["answers"][$key];

                    $file_name = rand(100, 1000) . "-" . $_FILES["questions"]["name"][$q]["answers"][$key];
                    $filesystem->write($file_name, file_get_contents($file));

                    $a["image_url"] = "https://firebasestorage.googleapis.com/v0/b/{$this->settings->fb_project_id}.appspot.com/o/" . $file_name . "?alt=media";
                } else {
                    $a["image_url"] = "";
                }

                $a["name"] = $answer["text"];
                $a["rate"] = isset($answer["rate"]) ? $answer["rate"] : 0;
                $firebase->set($DEFAULT_PATH . '/' . $question["text"] . "/" . $answer["text"], $a);
            }
        }

        // die('xx');
        $this->response->redirect('polls/view_fire/' . $event_id);
    }

    public function deleteAction($id)
    {
        Polls::findFirst($id)->delete();

        return $this->redirectBack();
    }

    public function delete_answerAction($answer_id){
        $answer = Answers::findFirst($answer_id);
        $answer->delete();

        return $this->redirectBack();
    }

    public function delete_fireAction($event_id)
    {
        $projectId = 'AIzaSyB3SSCHIZlBsVcaildCtAqUSE6Tmn31EQg';

        $DEFAULT_URL = $this->settings->fb_url;
        $DEFAULT_TOKEN = $this->settings->fb_token;
        $DEFAULT_PATH = '/data';

        $firebase = new \Firebase\FirebaseLib($DEFAULT_URL, $DEFAULT_TOKEN);

        $storageClient = new StorageClient([
            'projectId' => $this->settings->fb_project_id,
            'keyFilePath' => BASE_PATH . '/' . $this->settings->fb_service_key,
        ]);

        $bucket = $storageClient->bucket($this->settings->fb_bucket_name);

        $adapter = new GoogleStorageAdapter($storageClient, $bucket);

        $filesystem = new Filesystem($adapter);
        $events = json_decode($firebase->get($DEFAULT_PATH, array('orderBy' => '"event_id"', 'equalTo' => "$event_id")), true);

        foreach ($events as $key => $event) {
            $x = $firebase->delete($DEFAULT_PATH . "/" . $key);

        }

        return $this->redirectBack();
    }

    public function viewAction($id)
    {
        if ($this->settings->use_fb) {
            return $this->response->redirect("polls/view_fire");
        }

        $this->view->poll = Polls::findFirst($id);
    }

    public function view_fireAction($event_id)
    {
        $DEFAULT_URL = $this->settings->fb_url;
        $DEFAULT_TOKEN = $this->settings->fb_token;
        $DEFAULT_PATH = '/data';

        $firebase = new \Firebase\FirebaseLib($DEFAULT_URL, $DEFAULT_TOKEN);
        $questions = json_decode($firebase->get($DEFAULT_PATH, array('orderBy' => '"event_id"', 'equalTo' => $event_id)), true);

        // die(var_dump($questions));
        $this->view->event_id = $event_id;
        $this->view->questions = $questions;
    }

    public function detailsAction($id)
    {
        // $q = Questions::findFirst($id);
        // die(var_dump($q->poll));
        $this->view->question = Questions::findFirst($id);
    }

    public function resultsAction($id)
    {
        $this->view->poll = Polls::findFirst($id);
    }

    public function askAction()
    {
        $clients_categories= UserCategories::find();
        $this->view->client_categories = $clients_categories;
    }

    public function clients_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $clients_builder = $this->getClientsBuilder();
        $page = $this->request->getQuery("page", "int");
        if (!$page) {
            $page = 1;
        }
        $paginator = new PaginatorQueryBuilder([
            "builder" => $clients_builder,
            "limit" => 10,
            "page" => $page
        ]);
        $this->view->page = $paginator->getPaginate();
    }

    public function polls_tableAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $search_param = [];
        $poll_service = new PollService();
        $search = $poll_service->search($search_param);
        $this->view->items = $search;
    }

    public function poll_detailsAction($poll_id)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $search_param = [];
        $search_param["id"] = (int)$poll_id;
        $poll_service = new PollService();
        $search = $poll_service->search($search_param);
        $this->view->item = $search["items"][0];
    }

    public function create_poll_userAction()
    {
        if (!$this->request->isPost()) {
            die("Wrong Request");
        }
        $client_id = $this->request->getPost("client_id", "int");
        $poll_id = $this->request->getPost("poll_id", "int");
        $questions = [];
        if (!$client_id || !$poll_id) {
            $this->flashSession->error("You Must Select Client/Poll/Answers");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        foreach ($_POST as $k => $v) {
            if (strpos($k, 'answers_question') !== false) {
                $questions_ids[] = (int)str_replace('answers_question', '', $k);
            }
        }
        foreach ($questions_ids as $k => $v) {
            $question["question_id"] = $v;
            foreach ($this->request->getPost("answers_question{$v}") as $answer_question) {
                $question["answers"] = $answer_question;
            }
            $questions[] = $question;
        }
        if(count($questions) < 1){
            $this->flashSession->error("You Must Select Question");
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        foreach ($questions as $question) {
            if(!isset($question['answers'])){
                $this->flashSession->error("You Must Select Answers To All Questions");
                return $this->response->redirect($_SERVER['HTTP_REFERER']);
            }
            $poll_question_users = new PollQuestionsUsers();
            $poll_question_users->question_id = $question["question_id"];
            $poll_question_users->answer_id = $question['answers'];
            $poll_question_users->user_id = $client_id;
            if (!$poll_question_users->save()) {
                $this->flashSession->error("Error in Saving");
            }
        }
        //Set Visit Poll is Done
        $visit_id = $this->request->get("visit_id");
        if($visit_id){
            $visit_id = (int)$visit_id;
            $poll_visit=TanksPollsVisits::findfirst(["visit_id={$visit_id}"]);
            if($poll_visit){
                $poll_visit->done= 1;
                $poll_visit->save();
            }
        }
        $this->flashSession->success("تم استبيان العميل");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }

    public function poll_statAction($id){
        $id =(int)$id;
        $polls_service = new PollService();
        $search_param["id"]=$id;
        $search_param["answer_stats"]=1;
        $search = $polls_service->search($search_param);
        $this->view->content = $search["items"][0];
    }

    public function poll_question_statAction($id){
        $id =(int)$id;
        $polls_service = new PollService();
        $search_param["id"]=$id;
        $search = $polls_service->getQuestionStat($search_param);
        $this->view->content = $search;
    }

    private function getClientsBuilder()
    {
        $builder = $this->modelsManager->createBuilder()->from(UsersMobile::class)
            ->where('is_admin = 0')
            ->andWhere('category_id != "null"');

        if ($this->request->getPost()) {
            // var_dump($this->request->getPost());die;
            $cat_id = $this->request->getPost('category_id');
            $client_name = $this->request->getPost('client_name');
            $email = $this->request->getPost('email');
            $last_login = $this->request->getPost('last_login');
            $company_name = $this->request->getPost('company_name');
            $mobile = $this->request->getPost('mobile');
            $country_id = $this->request->getPost('country_id');
            $region_id = $this->request->getPost('region_id');
            $is_active = $this->request->getPost('is_active');

            if (isset($cat_id) && strlen($cat_id) > 0 && $cat_id!="") {
                $builder->andWhere('category_id = :cat_id:', [
                    'cat_id' => $cat_id
                ]);
            }

            if (isset($client_name) && strlen($client_name) > 0  && $client_name!="") {
                $builder->andWhere('Title like :client_name:', [
                    'client_name' => '%' . $client_name . '%'
                ]);
            }

            if (isset($email) && strlen($email) > 0 && $email!="" ) {
                $builder->andWhere('Mail = :email:', [
                    'email' => $email
                ]);
            }

            if (isset($mobile) && strlen($mobile) > 0 && $mobile!="") {
                $builder->andWhere('Mobile like :mobile:', [
                    'mobile' => '%' . $mobile . '%'
                ]);
            }

            if (isset($is_active) && strlen($is_active) > 0) {
                $builder->andWhere('Active = :is_active:', [
                    'is_active' => $is_active
                ]);
            }

            // get user data
            $user_data_builder = $this->modelsManager->createBuilder()->from(UserData::class);

            if (isset($last_login) && strlen($last_login) > 0 && $last_login!="") {
                $date = date('d/m/Y', strtotime($last_login));

                $user_data_builder->andWhere('last_login_date = :last_login:', [
                    'last_login' => $date
                ]);
            }

            if (isset($company_name) && strlen($company_name) > 0 && $company_name!="") {
                $user_data_builder->andWhere('company_name like :company_name:', [
                    'company_name' => '%' . $company_name . '%'
                ]);
            }

            if (isset($country_id) && strlen($country_id) > 0) {
                $user_data_builder->andWhere('country_id = :country_id:', [
                    'country_id' => $country_id
                ]);
            }

            if (isset($region_id) && strlen($region_id) > 0) {
                $user_data_builder->andWhere('region_id = :region_id:', [
                    'region_id' => $region_id
                ]);
            }

            $user_data = $user_data_builder->columns('user_id')->getQuery()->execute()->toArray();

            $users_ids = [];

            foreach ($user_data as $ud) {
                $users_ids[] = current($ud);
            }


            $builder->inWhere('ID', $users_ids);

        }

        return $builder;
    }

    public function saveAction()
    {
        $answers_files = [];

        if($this->request->hasFiles())
        {
            foreach($this->request->getUploadedFiles() as $file)
            {
                // var_dump($file->isUploadedFile());die;
                $file_key = $file->getKey();
                $answer_index = explode('.file', explode('answers.', $file_key)[1])[0];
                $answers_files[$answer_index] = $file;
            }
        }
        // var_dump($answers_files);die;

        
        $poll_title = $this->request->getPost('poll_title');
        $poll     = $this->request->getPost('poll');
        $sections = $poll['sections'];

        // foreach($sections as $section)
        // {
        //    foreach($section['answers'] as $k=>$answer)
        //    {
        //     var_dump($answer['text']);
        //    }
        // }die;

        $new_poll = new Polls;

        $new_poll->name           = $poll_title;
        $new_poll->application_id = 1;
        $new_poll->created_at     = date('Y-m-d H:i:s');
        $new_poll->modified_at    = date('Y-m-d H:i:s');

        if($new_poll->save())
        {
            foreach($sections as $section)
            {
                $poll_q = new Questions;

                $poll_q->text    = $section['question'];
                $poll_q->poll_id = $new_poll->id;

                if($poll_q->save())
                {
                    foreach($section['answers'] as $k=>$answer)
                    {
                        $poll_q_answer = new Answers;

                        $poll_q_answer->text        = $answer['text'];
                        $poll_q_answer->question_id = $poll_q->id;

                        if(array_key_exists($k, $answers_files))
                        {
                            if($answers_files[$k]->isUploadedFile())
                            {
                                $file = $answers_files[$k];
                                $ext  = $file->getExtension();
                                $upload_path = 'polls/uploads/'.$file->getName().'-'.time().rand(1,1000000).'.'.$ext;

                                if($file->moveTo($upload_path))
                                {
                                    $poll_q_answer->photo = $upload_path;
                                }
                            }
                        }

                        if(!$poll_q_answer->save())
                        {
                            $this->flashSession->error('خطأ أثناء حفظ إجابة');
                            return $this->response->redirect('index');
                        }
                    }
                }
                else
                {
                    $this->flashSession->error('خطأ أثناء حفظ سؤال');
                    return $this->response->redirect('index');
                }
            }
        }
        else
        {
            $this->flashSession->error('خطأ أثناء حفظ الإستبيان');
            return $this->response->redirect('index');
        }

        $this->flashSession->success('تم إنشاء الإستبيان بنجاح');
        return $this->response->redirect('index');
    }

    public function viewPollResponsesAction($poll_id)
    {
        $page = 1;
        if($this->request->getQuery("page","int")){
            $page =    $this->request->getQuery("page","int");
        }
        $poll = Polls::findFirst($poll_id);

        $poll_question_users_builder = $this->modelsManager->createBuilder()->from([
            'poll_q_u' => PollQuestionsUsers::class
        ]);

        $poll_question_users_builder->leftJoin(Questions::class, 'q.id = poll_q_u.question_id', 'q');
        $poll_question_users_builder->where('q.poll_id = :poll_id:', ['poll_id' => $poll_id]);
        $poll_question_users_builder->columns('distinct poll_q_u.user_id');
        $poll_question_users_builder->orderBy('poll_q_u.id DESC');
        $paginator = new PaginatorQueryBuilder([
            'builder' => $poll_question_users_builder,
            'limit'   => 5,
            'page'    => $page
        ]);

       $page_results = $paginator->getPaginate();
        $result = $page_results->items;
        $this->view->page= $page_results;
        
        $users = [];

        foreach($result as $record)
        {
            $users[] = UsersMobile::findFirst($record->user_id);
        }

        $this->view->users = $users;
        $this->view->poll  = $poll;
    }

    public function userAnswersAction()
    {
        $poll_id = $this->request->get('poll_id');
        $user_id = $this->request->get('user_id');

        $poll = Polls::findFirst([
            'id = :id:',
            'bind' => [
                'id' => $poll_id
            ]
        ]);

        $user = UsersMobile::findFirst([
            'ID = :id:',
            'bind' => [
                'id' => $user_id
            ]
        ]);

        $this->view->poll = $poll;
        $this->view->user = $user;
    }

    public function deleteUserAnswersAction()
    {
        $response['status'] = 0;
        $response['msg']    = '';

        $user_id = $this->request->getPost('user_id');
        $poll_id = $this->request->getPost('poll_id');

        $user_poll_q_a = $this->modelsManager->createBuilder()->from([
            'user_poll' => PollQuestionsUsers::class
        ]);

        $user_poll_q_a->leftJoin(Questions::class, 'q.id = user_poll.question_id', 'q');
        $user_poll_q_a->where('q.poll_id = :poll_id:', ['poll_id' => $poll_id]);
        $user_poll_q_a->andWhere('user_poll.user_id = :user:', ['user' => $user_id]);

        $result = $user_poll_q_a->getQuery()->execute();

        foreach($result as $record)
        {
            if(!$record->delete())
            {
                $response['msg'] = 'خطأ أثناء حذف التقرير ، حاول مرة أخرى';
                return json_encode($response);
            }
        }

        $response['status'] = 1;
        $response['msg']    = 'تم حذف التقرير بنجاح';
        $this->flashSession->success($response['msg']);

        return json_encode($response);
    }

    public function deletePollAction()
    {
        $response['status'] = 0;
        $response['msg']    = '';

        $poll_id = $this->request->getPost('poll_id');

        $poll = Polls::findFirst([
            'id = :id:',
            'bind' => [
                'id' => $poll_id
            ]
        ]);

        if($poll->delete())
        {
            $questions = Questions::find([
                'poll_id = :poll_id:',
                'bind' => [
                    'poll_id' => $poll_id
                ]
            ]);

            foreach($questions as $question)
            {
                foreach($question->answers as $answer)
                {
                    $answer->delete();
                }

                $user_responses = PollQuestionsUsers::find([
                    'question_id = :q_id:',
                    'bind' => [
                        'q_id' => $question->id
                    ]
                ]);

                foreach($user_responses as $response)
                {
                    $response->delete();
                }

                $question->delete();
            }
        }
        else
        {
            $response['msg'] = 'Error deleting poll';
            $this->flashSession->error($response['msg']);
            return json_encode($response);
        }

        $response['status'] = 1;
        $response['msg']    = 'تم حذف الإستبيان بنجاح';
        $this->flashSession->success($response['msg']);

        return json_encode($response);
    }
}

