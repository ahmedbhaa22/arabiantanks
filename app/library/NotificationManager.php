<?php 

namespace Vokuro;

use Vokuro\Models\Events\Events;

/**
* 
*/
class NotificationManager
{
	
	function __construct()
	{
		
	}

	public function notifyEvent(Events $event, $user)
	{
		$notification_types = $event->notification_types;

		foreach ($notification_types as $type) {
			if ($type->name == "مسج") {
				// send message
			}elseif ($type->name == "ميل") {
				// send mail
				foreach ($event->invitations as $inv) {
					die(var_dump($this->sendMail($user->Mail, $event->name, $event->description)));
				}
			}
		}
	}

	public function sendMail($to, $subject = '', $body = '')
	{
		$to      = $to;
        $subject = 'Event Reminder: ' . $subject;
        $message = $body;
        $headers = 'From: pentavalue@pentavalue.com' . "\r\n" .
            'Reply-To: pentavalue@pentavalue.com' . "\r\n" .
            'X-Mailer: PHP/' . phpversion();

        return mail($to, $subject, $message, $headers);
	}
}