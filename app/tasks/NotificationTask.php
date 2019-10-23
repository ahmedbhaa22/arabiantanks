<?php

use Carbon\Carbon;
use Phalcon\Cli\Task;
use Vokuro\Models\Events\Events;
use Vokuro\NotificationManager;

class NotificationTask extends Task
{
    public function mainAction()
    {
    	date_default_timezone_get('Africa/Cairo');
        // echo date('Y-m-d H:i:s');
        // Carbon::setTimezone('Africa/Cairo');
        $today = Carbon::now('Africa/Cairo');
        $mng = new NotificationManager;
        // die(var_dump($event->getInvitationsLink(['order'=>'user_order ASC'])->toArray()));
        $events = Events::query()
            ->where("start_date < '{$today}'")
            ->andWhere("end_date > '{$today}'")
            ->execute();

        // loop on current events ... and optionally "open" events
        foreach ($events as $event) {
            // $last_notification = $event->notified;
            $scheduleType = 0;
            if($event->scheduleType){
                $scheduleType = $event->scheduleType->id;
            }
            $confirmation = $event->getInvitationsLink(['confirm = 1'])->toArray();

            $last_notification = Carbon::parse($event->notified, 'Africa/Cairo');
            if(empty($confirmation)){
                // not confirmed by anyone yet, check intervals
                $interval = $event->response_interval;

                if($last_notification->addMinutes($interval) < $today){
                    // interval passed notify next
                    $invitations = $event->getInvitationsLink(['order' => 'user_order ASC'])->toArray();

                    $next = '';
                    if($event->notified_user){
                        foreach ($invitations as $key => $inv) {
                            if($inv['user_id'] == $event->notified_user){
                                if(isset($invitations[$key + 1])){
                                    $next = $invitations[$key + 1];
                                }
                            }
                        }
                    }else{
                        $next = $invitations[0];
                    }


                    if($next){
                        $event->notified_user = $next['user_id'];
                        $event->notified = date("Y-m-d H:i:s");
                        $event->save();
                        $mng->notifyEvent($event, UsersMobile::findFirst($next['user_id']));
                    }
                }
            }else{
                // already confirmed by someone, notify periodically
                if($scheduleType == 1){
                    // daily schedule
                    if($last_notification < (string)$today->subDay(1)){
                        // a day passed - send notification
                        echo "VVVVVVVVV";
                        $event->notified = date("Y-m-d H:i:s");
                        $event->save();
                        $mng->notifyEvent($event, $event->notifiedUser);
                    }

                }elseif ($scheduleType == 2) {
                    // weekly
                    if($last_notification < (string)$today->subDay(7)){
                        // a week passed - send notification
                        $event->notified = date("Y-m-d H:i:s");
                        $event->save();
                        $mng->notifyEvent($event, $event->notifiedUser);
                    }
                }elseif ($scheduleType == 3) {
                    // monthly
                    if($last_notification < (string)$today->subDay(30)){
                        // a month passed - send notification
                        $event->notified = date("Y-m-d H:i:s");
                        $event->save();
                        $mng->notifyEvent($event, $event->notifiedUser);
                    }
                }elseif ($scheduleType == 4) {
                    // yaerly
                    if($last_notification < (string)$today->subDay(365)){
                        // a year passed - send notification
                        $event->notified = date("Y-m-d H:i:s");
                        $event->save();
                        $mng->notifyEvent($event, $event->notifiedUser);
                    }
                }elseif ($scheduleType == 5) {
                    // once
                    if($last_notification == (string)$today){
                        // send a one time notification at the start date
                        $event->notified = date("Y-m-d H:i:s");
                        $event->save();
                        $mng->notifyEvent($event, $event->notifiedUser);
                    }
                }else{
                    // throw new \Exception("Invalid Schedule Type");
                }
            }

        }
    }
}