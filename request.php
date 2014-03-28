<?php
class MysqlTools {

	private $host;
	private $username;
	private $password;
	private $database;
	private $encode;

	function __construct($host, $username, $password, $database, $encode) {
		$this->host = $host;
		$this->username = $username;
		$this->password = $password;
		$this->database = $database;
		$this->encode 	= $encode;

		$this->connect();
	}

	function connect() {
		// connect mysql
		$connect = mysql_connect($this->host, $this->username, $this->password, $this->database);
		if (!$connect) {
			die('mysql connect failure with '.$this->error()."\n");
		}

		// select database
		$db = mysql_select_db($this->database, $connect);
		if (!$db) {
			die('select db '.$this->database.' failure with '.$this->error()."\n");
		}

		$query = mysql_query("SET NAMES '$this->encode'");
		if (!$query) {
			die('set '.$this->encode.' failure'."\n");
		}
	}
}

$instance = new MysqlTools('localhost', 'cuan', 'chinou', 'lighter_reader', 'utf8');

if ($get = $_POST['paramJson']) {

	$obj = json_decode($get, true);
	
	$response = $obj['emailAddress'];
	$responseArray = array(
		"code" => "1",
		"content" => $response
	);
	
	echo json_encode($responseArray, true);
} else {
	$responseArray = array(
		"code" => "0",
		"content" => null
	);
	
	echo json_encode($responseArray, true);
}


?>
