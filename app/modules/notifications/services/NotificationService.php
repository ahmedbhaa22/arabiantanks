<?php 

namespace Vokuro\Notifications\Services;

use Phalcon\Di;
use Vokuro\Notifications\Models\Feedback;
use Vokuro\Notifications\Models\Settings;

/**
* 
*/
class NotificationService
{
	private $settings;

	public function __construct()
	{
		$this->settings = Settings::findFirst();
	}


	public function pushMessage($msg)
	{
		if($msg->Type == 1){
			// iOS
			$this->pushiOS($msg);
		}elseif ($msg->Type == 2) {
			// Android
			$this->pushAndroid($msg);
		}elseif ($msg->Type == 3) {
			// Email
			$this->pushEmail($msg);
		}elseif ($msg->Type == 4) {
			// Sms
			$this->pushSms($msg);
		}elseif ($msg->Type == 5) {
			// chrome
			$this->pushChrome($msg);
		}
	}

	public function pushAndroid($msg)
	{
		$settings = $this->settings;
		$apikey = $settings->android_app_key;
		$message = $msg->message->Message;
		$device_token = [$msg->Token];

		$data_array = ["message" => $message];

		if($msg->message->kv){
			$kv = json_decode($msg->message->kv, true);
			$data_array = array_merge($data_array, $kv);
		}


		if($msg->message->topic){
			$topic = ["topic_id" => $msg->message->topic->id];
			$data_array = array_merge($data_array, $topic);
		}

		$url = 'https://android.googleapis.com/gcm/send';

		$fields = array('registration_ids' => $device_token, 'data' => $data_array);
		$headers = array('Authorization: key='.$apikey, 'Content-Type: application/json');
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
		$result = curl_exec($ch);
		if($result === FALSE) {
		    die('Curl failed: '.curl_error($ch));
		}
		curl_close($ch);
		echo $result;
		// add to push feedback
		$feedback = new Feedback;
		$feedback->Device_Type = 2;
		$feedback->Feedback = serialize($result);
		$feedback->Tokens = serialize($device_token);
		$feedback->save();
	}

	public function pushiOS($msg)
	{
		$settings = $this->settings;
		if($settings->enable_sandbox){
			// push to sandbox link
			$this->pushiOS_method1($msg);
			$this->pushiOS_method2($msg);
		}

		if($settings->enable_production){
			// push to production
			$this->pushiOS_method1($msg, true);
			$this->pushiOS_method2($msg, true);
		}
	}

	public function pushEmail($msg)
	{
		echo "Mailing: {$msg->Token} \n";
		// $x = mail($msg->Token, "", $msg->message->Message);
		// Di::getDefault();
		// $s = Di::getDefault()->getConfig();
		// die(var_dump($s));
		// $mail = Di::getDefault()->getMail();

		$x = Di::getDefault()->getMail()->send($msg->Token, "Penta Value", 'replayform', [
			"Application_Name"=> "Go App",
            "reply"=> "Stuff"
			]);
		// die(var_dump($x));
	}

	public function pushSms($msg)
	{
		echo "Sending \n";
	}

	public function pushChrome($msg)
	{
		
	}

	/**
	 * @param $http2ch          the curl connection
	 * @param $http2_server     the Apple server url
	 * @param $apple_cert       the path to the certificate
	 * @param $app_bundle_id    the app bundle id
	 * @param $message          the payload to send (JSON)
	 * @param $token            the token of the device
	 * @return mixed            the status code
	 */
	private function sendHTTP2Push($http2ch, $http2_server, $apple_cert, $app_bundle_id, $message, $token) {

	    // url (endpoint)
	    $url = "{$http2_server}/3/device/{$token}";

	    // certificate
	    $cert = realpath(BASE_PATH . "/public/" . $apple_cert);

	    // headers
	    $headers = array(
	        "apns-topic: {$app_bundle_id}",
	        "User-Agent: My Sender"
	    );

	    // other curl options
	    curl_setopt_array($http2ch, array(
	        CURLOPT_URL => $url,
	        CURLOPT_PORT => 443,
	        CURLOPT_HTTPHEADER => $headers,
	        CURLOPT_POST => TRUE,
	        CURLOPT_POSTFIELDS => $message,
	        CURLOPT_RETURNTRANSFER => TRUE,
	        CURLOPT_TIMEOUT => 30,
	        CURLOPT_SSL_VERIFYPEER => false,
	        CURLOPT_SSLCERT => $cert,
	        CURLOPT_HEADER => 1
	    ));

	    // go...
	    $result = curl_exec($http2ch);
	    if ($result === FALSE) {
	      throw new \Exception("Curl failed: " .  curl_error($http2ch));
	    }

	    // get response
	    $status = curl_getinfo($http2ch, CURLINFO_HTTP_CODE);
	    print_r($result);
	    $feedback = new Feedback;
		$feedback->Device_Type = 1;
		$feedback->Feedback = serialize($result);
		$feedback->Tokens = serialize($token);
		$feedback->save();
	    return $status;
	}

	private function pushiOS_method1($msg, $production = false)
	{
		$deviceToken = $msg->Token;
		$appid = $this->settings->iphone_bundle_id;
		//$apnsHost = 'gateway.sandbox.push.apple.com';
		//for the development app, sand box

		$message = $msg->message->Message;
		
		$apnsPort = 2195;
		if($production){
			$serverAPNS = 'https://api.push.apple.com/3/device/'; // production  
			$cert = BASE_PATH . "/public/" . $this->settings->production_certificate;
			$passphrase = $this->settings->production_passphrase;
		}else{
			$serverAPNS = 'gateway.sandbox.push.apple.com';
			$cert = BASE_PATH . "/public/" . $this->settings->sandbox_certificate;
			$passphrase = $this->settings->sandbox_passphrase;
		}

		$body = array();
		//$body['aps']['notifurl'] = $payload;
		//$body['aps']['badge'] = 0;



		$body['aps'] = array('alert' => $message);
		$body['aps']['sound'] = "default";

		if($msg->message->kv){
			$kv = json_decode($msg->message->kv, true);
			$body['aps'] = array_merge($body["aps"], $kv);
		}

		if($msg->message->topic){
			$topic = ["topic_id" => $msg->message->topic->id];
			$body['aps'] = array_merge($body['aps'], $topic);
		}

		$payload = json_encode($body);
		$chandle = curl_init();
		curl_setopt($chandle, CURLOPT_URL, $serverAPNS . $deviceToken);
		curl_setopt($chandle, CURLOPT_PORT, 443);
		curl_setopt($chandle, CURLOPT_POST, true);
		curl_setopt($chandle, CURLOPT_HTTPHEADER, array('apns-topic: ' . $appid));
		curl_setopt($chandle, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($chandle, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($chandle, CURLOPT_SSLCERT, $cert);
		curl_setopt($chandle, CURLOPT_SSLCERTPASSWD, $passphrase);
		curl_setopt($chandle, CURLOPT_POSTFIELDS, $payload);
		curl_setopt($chandle, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2_0);
		$response = curl_exec($chandle);
		
		$feedback = new Feedback;
		$feedback->Device_Type = 1;
		$feedback->Feedback = serialize($response);
		$feedback->Tokens = serialize($deviceToken);
		$feedback->save();

		$httpcode = curl_getinfo($chandle, CURLINFO_HTTP_CODE);
		curl_close($chandle);
	}

	private function pushiOS_method2($msg, $production = false)
	{
		if (!defined('CURL_HTTP_VERSION_2_0')) {
		  define('CURL_HTTP_VERSION_2_0', 3);
		}

		// open connection 
		$http2ch = curl_init();
		curl_setopt($http2ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2_0);
		 
		// send push
		if($production){
			$apple_cert = $this->settings->production_certificate;
			$http2_server = 'https://api.push.apple.com'; // or 'api.push.apple.com' if production			
		}else{
			$apple_cert = $this->settings->sandbox_certificate;
			$http2_server = 'https://api.development.push.apple.com'; // or 'api.push.apple.com' if production
		}
		$m = $msg->message->Message;

		$body = array();
		//$body['aps']['notifurl'] = $payload;
		//$body['aps']['badge'] = 0;


		$body['aps'] = array('alert' => $m);
		$body['aps']['sound'] = "default";

		if($msg->message->kv){
			$kv = json_decode($msg->message->kv, true);
			$body['aps'] = array_merge($body["aps"], $kv);
		}

		if($msg->message->topic){
			$topic = ["topic_id" => $msg->message->topic->id];
			$body['aps'] = array_merge($body['aps'], $topic);
		}
		
		$message = json_encode($body);
		// $message = '{"aps":{"alert":"'.$m.'","sound":"default"}}';
		$token = $msg->Token;
		$app_bundle_id = $this->settings->iphone_bundle_id;
		// echo $token . "\n"; 
		$status = $this->sendHTTP2Push($http2ch, $http2_server, $apple_cert, $app_bundle_id, $message, $token);

		// close connection
		curl_close($http2ch);
	}
}