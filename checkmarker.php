<?php
/**
* @author Alex Steiner
* @copyright Alex Steiner
* @link http://alexsteiner.de
*/
$i = $_POST["i"];

$mysqli = new mysqli("localhost", "nerd", "nerd", "nerd");

$result = $mysqli->query("SELECT * FROM geodata WHERE id ='$i' AND status ='true' LIMIT 1");

/* determine number of rows result set */
$row_cnt = $result->num_rows;

echo $row_cnt;

/* close result set */
$result->close();

/* close connection */
$mysqli->close();


?>