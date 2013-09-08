<?php
	class MySQL {
		private $host		= "localhost"; 
		private $username	= "d0181b74";
		private $password	= "gnpGDs8tCHKHxTYa";
		private $database	= "d0181b74";
		public  $query 		= "";

		public function connect()	{
			$connection = mysql_connect($this->host, $this->username, $this->password) or die ("Connection Error.");
			mysql_select_db($this->database, $connection) or die ("Database not found.");
		}
		
		public function query($query){
			$query = mysql_query($query);
			$this->query = $query;
		}
		
		public function fetchObject($query)	{
			$query = mysql_fetch_object(mysql_query($query));
			$this->query = $query;
		}
		
		public function rows($query){
			$query = mysql_num_rows(mysql_query($query));
			$this->query = $query;
		}
		
		public function fetchArray($query)	{
			$query = mysql_fetch_array(mysql_query($query));
			$this->query = $query;
		}
	}