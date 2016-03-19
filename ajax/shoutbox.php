<?php

header('Content-type: text/plain');
session_start();

include_once('../config.inc.php');
include_once('../dbconn.inc.php');
include_once('global.inc.php');
include_once('checksession.inc.php');

$addbox=$db->prepare("INSERT INTO game_chat VALUES(?, ?, ?, ?, ?, ?)");

$res=$addbox->execute(
	array(
		$_POST['game'],
		floor(microtime(true)*10000),
		$_SESSION['player_id'],
		$_POST['type'],
		$_POST['reci'],
		$_POST['mesg']
	)
);

if ($res !== FALSE)
{
	echo '200 OK';
}
else
{
	echo '401 Shoutbox Message Failed!';
	var_dump($_REQUEST);
}

?>
