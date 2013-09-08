<?php
	echo '<pre>';
	var_dump(filter_var('lol@alenan.com', FILTER_VALIDATE_EMAIL));

	var_dump(filter_var('shfnksj13!§$%&@alenan.com', FILTER_VALIDATE_EMAIL));