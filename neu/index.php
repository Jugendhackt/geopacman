<?php
	include('lib/class.mysql.php');
	include('lib/class.user.php');

	$user = new User();
	//$user->addUser('test@test.de', 'TEST');
	$user->addPoints(1000000000, 17);

?> 