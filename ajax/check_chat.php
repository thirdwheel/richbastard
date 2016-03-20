<?php

header('Content-type: text/plain');
session_start();

include_once('../config.inc.php');
include_once('../dbconn.inc.php');
include_once('global.inc.php');
include_once('checksession.inc.php');

if ($_GET['last'] == 0) $_GET['last']=microtime(true) * 10000;

$chat=$db->prepare(
	 'SELECT p1.player_nickname, message_type, p2.player_nickname, '
	.'       message_content, timestamp '
	.'FROM game_chat gc '
	.'INNER JOIN player p1 on p1.player_id = gc.player_id '
	.'LEFT  JOIN player p2 on p2.player_id = gc.message_recipient '
	.'WHERE timestamp > ? '
	.'AND   message_recipient in (-1,?) '
	.'AND   game_id = ?');

$res=$chat->execute(
	array(
		$_GET['last'],
		$_SESSION['player_id'],
		$_GET['game']
	)
);

if ($res)
{
	echo '200 OK', "\n";
	$lastts=$_GET['last'];
	foreach ($chat as $message)
	{
		$lastts=$message[4];
		echo '202 ', $message[4], ',', $message[1], ',', $message[0], ',',
		     $message[2], ',', $message[3], "\n";
	}
	echo '203 ', $lastts, "\n";
}
else {
	var_dump($chat->errorInfo());
	die('401 Message Check Error');
}
?>
