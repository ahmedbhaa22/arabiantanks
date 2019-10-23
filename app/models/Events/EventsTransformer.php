<?php

namespace Vokuro\Models\Events;

use Vokuro\Transformer;

/**
* 
*/
class EventsTransformer extends Transformer
{
	public function transform($event)
	{
		$current_event = Events::findFirst($event['id']);

		return [
			'id' => $current_event->id,
			'name' => $current_event->name,
			'description' => $current_event->description,
			'start_date' => date("Y-m-d", strtotime($current_event->start_date)),
			'end_date' => $current_event->end_date ? date("Y-m-d", strtotime($current_event->end_date)) : null,
			'purpose' => $current_event->purpose ? $current_event->purpose->name : null,
			'event_purpose' => $current_event->event_purpose,
			'schedule_type' => $current_event->scheduleType ? $current_event->scheduleType->name: null,
			'schedule_type_id' => $current_event->schedule_type,
			'creator' => $current_event->creator->name,
			'invited_users' => $current_event->invitations->toArray(),
			'notification_types' => $current_event->notification_types->toArray(),
		];
	}
}