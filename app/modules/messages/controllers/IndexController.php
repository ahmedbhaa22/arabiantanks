<?php 

namespace Vokuro\Messages\Controllers;

use Models\UsersMobile;
use Vokuro\Controllers\ControllerBase;
use Vokuro\Messages\Models\DataMessagesDrafts;
use Vokuro\Messages\Models\MessagesRelation;
use Vokuro\Messages\Models\Settings;

/**
* 
*/
class IndexController extends ControllerBase
{
    // public function initialize()
    // {
    //     parent::initialize();
        // $user = $this->auth->getIdentity();
        // $application_id = $user['Application_ID'];
        // $this->view->settings = Settings::query()->where("application_id = {$application_id}")->execute()->getFirst();
    // }
	
	public function indexAction()
    {
        $user = $this->auth->getIdentity();
        // die(var_dump($user));
        $user_id = $user['id'];
        if(!$user_id){
            $this->url->setBaseUri("/cms/public/");
            $this->response->redirect('session/logout');
        }
        $application_id = $user['Application_ID'];
        $this->view->settings = Settings::query()->where("application_id = {$application_id}")->execute()->getFirst();

        $messages = MessagesRelation::find([
            // "Module_ID = {20195}",
            "Application_ID = {$application_id} AND Deleted != {$user_id} AND To_User_ID = {$user_id}",
            "group" => ['Parent_ID']
            ]);

        $this->view->messages = $messages;
    }

    public function allAction()
    {
        $user = $this->auth->getIdentity();
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];
        $messages = MessagesRelation::find([
            // "Module_ID = {20195}",
            "Application_ID = {$application_id}",
            "Deleted != {$user_id}",
            "group" => ['Parent_ID']
            ]);

        return $this->sendJson($messages);
    }

    public function viewAction($message_id)
    {
        $user = $this->auth->getIdentity();
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];
        $this->view->settings = Settings::query()->where("application_id = {$application_id}")->execute()->getFirst();
        $message = MessagesRelation::findFirst([
            "ID = {$message_id} AND Application_ID = {$application_id} AND Deleted != {$user_id}",
            // "Module_ID = {20195}",
            // "",
            // ""
            ]);

        $messages = MessagesRelation::find([
            "Parent_ID = {$message->Parent_ID} AND Application_ID = {$application_id} AND Deleted != {$user_id}",
            // "Module_ID = {20195}",
            ]);
        // die(var_dump($messages));
        $this->view->Parent_ID = $messages->getFirst()->Parent_ID;
        $this->view->messages = $messages;
    }

    public function composeAction()
    {
        $user = $this->auth->getIdentity();
        $application_id = $user['Application_ID'];
        $this->view->settings = Settings::query()->where("application_id = {$application_id}")->execute()->getFirst();

        if(isset($_GET['draft'])){
            $draft = DataMessagesDrafts::findFirst($_GET['draft']);
            $this->view->draft = $draft;
        }elseif(isset($_GET['reply_to'])){
            $this->view->reply_to = UsersMobile::findFirst($_GET['reply_to']);
        }
    }

    public function sendAction()
    {
        $user = $this->auth->getIdentity();
        $application_id = $user['Application_ID'];
        $from = $user['id'];
        $to = $this->request->getPost('to');

        $parentid = $this->db->fetchOne("SELECT Parent_ID FROM data_messages_relation where (From_User_ID='".$from."' and To_User_ID='".$to."' ) or (From_User_ID='".$to."' and To_User_ID='".$from."') ORDER BY  `data_messages_relation`.`ID` DESC LIMIT 1", \Phalcon\Db::FETCH_ASSOC);

        $parentid = $parentid['Parent_ID'];
        $this->db->insert(
          'data_messages',
          array($this->request->getPost('message'), 0, time(), 20195, $this->request->getPost('subject')),
          array('Content', 'Type', 'DateTime', 'Application_ID', 'Module_ID', 'subject')
        );
        $messageid = $this->db->lastInsertId();
        $this->db->insert(
          'data_messages_relation',
          array($messageid, 0, $from, $to, $application_id, 20195),
          array('Message_ID', 'Deleted', 'From_User_ID', 'To_User_ID', 'Application_ID', 'Module_ID')
        );
        $relationid = $this->db->lastInsertId();
        if (!$parentid) {
          $parentid = $relationid;
        }
        $this->db->execute("UPDATE `data_messages_relation` SET `Parent_ID`=".$parentid." WHERE `ID`=".$relationid."");
        $this->response->redirect('index');
    }

    public function replyAction()
    {
        $user = $this->auth->getIdentity();
        $application_id = $user['Application_ID'];
        $from = $user['id'];

        

        $parentid = $this->request->getPost('Parent_ID');
        
        $rel = $this->db->fetchOne("SELECT * FROM data_messages_relation where (Parent_ID='".$parentid."') ORDER BY  `data_messages_relation`.`ID` DESC LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
        $to = $rel["From_User_ID"];
        // die(var_dump($rel));

        $this->db->insert(
          'data_messages',
          array($this->request->getPost('message'), 0, time(), $application_id, 20195, $this->request->getPost('subject')),
          array('Content', 'Type', 'DateTime', 'Application_ID', 'Module_ID', 'subject')
        );
        $messageid = $this->db->lastInsertId();
        $this->db->insert(
          'data_messages_relation',
          array($messageid, 0, $from, $to, $application_id, 20195),
          array('Message_ID', 'Deleted', 'From_User_ID', 'To_User_ID', 'Application_ID', 'Module_ID')
        );
        $relationid = $this->db->lastInsertId();
        if (!$parentid) {
          $parentid = $relationid;
        }
        $this->db->execute("UPDATE `data_messages_relation` SET `Parent_ID`=".$parentid." WHERE `ID`=".$relationid."");
        $this->response->redirect('index/view/' . $parentid);   
    }

    public function save_draftAction()
    {
        $user = $this->auth->getIdentity();
        $application_id = $user['Application_ID'];
        $user_id = $user['id'];
        $draft = new DataMessagesDrafts;
        $draft->Content = $this->request->getPost('message');
        $draft->subject = $this->request->getPost('subject');
        $draft->To_User_ID = $this->request->getPost('to');
        $draft->From_User_ID = $user_id;
        $draft->Application_ID = $application_id;
        $draft->Module_ID = 20195;
        $draft->created_at = date('Y-m-d H:i');
        $draft->save();

        $this->response->redirect('index');
    }

    public function draftsAction()
    {
        $user = $this->auth->getIdentity();
        $application_id = $user['Application_ID'];
        $user_id = $user['id'];
        $this->view->settings = Settings::query()->where("application_id = {$application_id}")->execute()->getFirst();
        $drafts = DataMessagesDrafts::find([
            "conditions" => "Application_ID = ?1 AND From_User_ID = ?2",
            "bind" => [
                // 1 => 20195,
                1 =>$application_id,
                2 =>$user_id
            ],
        ]);

        $this->view->drafts = $drafts;
    }

    public function DeletedAction($message_id)
    {
        $user = $this->auth->getIdentity();
        $user_id = $user['id'];
        $messages = MessagesRelation::find([
                "conditions" => "(From_User_ID = ?1 or To_User_ID = ?2) and Parent_ID = ?3",
                "bind" => [
                    1 => $user_id,
                    2 => $user_id,
                    3 => $message_id
                ]
            ]);

        if ($messages) {
            foreach ($messages as $message) {
                if($message->Deleted != 0){
                    $message->Deleted();
                }else{
                    $message->Deleted = $user_id;
                    $message->save();
                }
            }
            return $this->response->redirect('index');
        }else {

        }
    }

    public function fetchAction($id)
    {
        $user = $this->auth->getIdentity();
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];
        $message = MessagesRelation::findFirst([
            "ID = {$id}",
            // "Module_ID = {20195}",
            "Application_ID = {$application_id}",
            "Deleted != {$user_id}"
            ]);

        $messages = MessagesRelation::find([
            "Parent_ID = {$message->Parent_ID}",
            // "Module_ID = {20195}",
            "Application_ID = {$application_id}",
            "Deleted != {$user_id}"
            ]);

        return $this->sendJson($messages);
    }

    public function sentAction()
    {
        $user = $this->auth->getIdentity();
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];
        $this->view->settings = Settings::query()->where("application_id = {$application_id}")->execute()->getFirst();
        // die(var_dump($user_id));
        $messages = MessagesRelation::find([
            "conditions" => "Application_ID = ?1 AND Deleted != ?2 AND From_User_ID = ?3",
            "bind" => [
                // 1 => 20195,
                1 =>$application_id,
                2 =>$user_id,
                3 =>$user_id
            ],
            "group" => ['Parent_ID']
        ]);


        $this->view->messages = $messages;
    }

    public function trashedAction()
    {
        $user = $this->auth->getIdentity();
        $user_id = $user['id'];
        $application_id = $user['Application_ID'];
        $this->view->settings = Settings::query()->where("application_id = {$application_id}")->execute()->getFirst();
        $messages = MessagesRelation::find([
            "conditions" => "Application_ID = ?1 AND Deleted = ?2",
            "bind" => [
                // 1 => 20195,
                1 => $application_id,
                2 => $user_id
            ],
            "group" => ['Parent_ID']
            ]);

        $this->view->messages = $messages;
    }

    public function deleteAction($message_id)
    {
        $user = $this->auth->getIdentity();
        $user_id = $user['id'];
        $messages = MessagesRelation::find([
                "conditions" => "(From_User_ID = ?1 or To_User_ID = ?2) and Parent_ID = ?3",
                "bind" => [
                    1 => $user_id,
                    2 => $user_id,
                    3 => $message_id
                ]
            ]);

        if ($messages) {
            foreach ($messages as $message) {
                if($message->Deleted != 0){
                    $message->delete();
                }else{
                    $message->Deleted = $user_id;
                    $message->save();
                }
            }
            return $this->response->redirect('index');
        }else {

        }
    }

    public function deleteMultipleAction()
    {
        $msg_ids = json_decode($this->request->getQuery("msgs"));
        // die(var_dump($msg_ids));
        $user = $this->auth->getIdentity();
        $user_id = $user['id'];

        foreach ($msg_ids as $msg_id) {
            $messages = MessagesRelation::find([
                    "conditions" => "(From_User_ID = ?1 or To_User_ID = ?2) and Parent_ID = ?3",
                    "bind" => [
                        1 => $user_id,
                        2 => $user_id,
                        3 => $msg_id
                    ]
                ]);

            if ($messages) {
                foreach ($messages as $message) {
                    if($message->Deleted != 0){
                        $message->delete();
                    }else{
                        $message->Deleted = $user_id;
                        $message->save();
                    }
                }
            }else {

            }
        }
        return $this->response->redirect('index');
    }

    public function delete_draftAction($id)
    {
        $user = $this->auth->getIdentity();
        $application_id = $user['Application_ID'];
        $user_id = $user['id'];
        $draft = DataMessagesDrafts::find($id);
        $draft->delete();
        
        return $this->response->redirect('index/drafts');
    }
}