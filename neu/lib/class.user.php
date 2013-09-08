<?php

	class User extends MySQL{
		//Initialization of the variables
		private $password = "";
		private $regdate  = "";

		//Füllt beide salts mit einem 256 Bit langen String
		private $salt = "6aad36a39e16ec500d9ef06b0e4833ef56e9ef1a7ab9a4f2dfd745b2c4";
		private $salt2 = "6553127b6a7b11764fc0d9bd282755bc9d39643747fb286cd03b07565e";


		private function hashPW($password) {

			//Vor und nach dem Passwort wird ein Salt gesetzt. Der den vergleich mit einer "Rainbowtables" oder ähnliches.
			$this->password = $this->salt.$password.$this->salt2;

			//sha512 ist langsammer, jedoch sicherer...
			$this->password = hash("sha512", $password);
		}

		public function addUser($email, $password) {
			$this->hashPW($password);
			$this->connect();
			$email = mysql_real_escape_string(trim($email));
			$this->query("INSERT INTO user (email, password) VALUES ('$email', '$this->password')");
		}

		public function addPoints($points, $userID) {
			$this->connect();
			$this->query("UPDATE user SET points = points+100 WHERE userID = '$userID' ");
		}
	}