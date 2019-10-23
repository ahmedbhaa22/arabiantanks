<?php 

namespace Vokuro\Geo\Services;

use Vokuro\Geo\Models\GeoCities;
use Vokuro\Geo\Models\GeoContinents;
use Vokuro\Geo\Models\GeoCountries;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoStates;
use Vokuro\Geo\Models\GeoStreets;

/**
* 
*/
class GeoService
{
	public static function getModel($type)
	{
		switch ($type) {
			case 1:
				return new GeoContinents;
				break;
			case 2:
				return new GeoCountries;
				break;
			case 3:
				return new GeoStates;
				break;
			case 4:
				return new GeoCities;
				break;
			case 5:
				return new GeoRegions;
				break;
			case 6:
				return new GeoStreets;
				break;
			
			default:
				throw new \Exception("Invalid Geo Type", 1);
				
				break;
		}
	}
}