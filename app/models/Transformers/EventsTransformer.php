<?php

namespace Vokuro\Models\Transformers;

use Vokuro\Transformer;

/**
* 
*/
class EventsTransformer extends Transformer
{

	public function transformResultSet($items)
	{
		if($items instanceof \Traversable){

			// dd('s');
			if(!count($items)){
				return [];
			}
			$result = [];
			foreach ($items as $item) {
				$result[] = $this->transform($item);
			}
			// dd($result);
			return $result;
		}

		if(!$items) return [];
		return $this->transform($items);	
	}

	public function transform($event)
	{
		return [
			'id' => $event->id,
			'name' => $event->name,
			'description' => $event->description,
			'start_date' => date("Y-m-d", strtotime($event->start_date)),
			'end_date' => $event->end_date ? date("Y-m-d", strtotime($event->end_date)) : null,
			'purpose' => $event->purpose ? $event->purpose->name : null,
			'event_purpose' => $event->event_purpose,
			'schedule_type' => $event->scheduleType ? $event->scheduleType->name: null,
			'schedule_type_id' => $event->schedule_type,
			'creator' => $event->creator->Title,
			'invited_users' => $event->invitations->toArray(),
			'notification_types' => $event->notification_types->toArray(),
		];
	}
}