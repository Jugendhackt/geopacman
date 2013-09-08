<?php
/**
* @author Alex Steiner
* @copyright Alex Steiner
* @link http://alexsteiner.de
*/
$mysqli = new mysqli("localhost", "nerd", "nerd", "nerd");
$id = $_POST["id"];
$mysqli->query("UPDATE geodata SET status='1' WHERE id='$id'");
?>