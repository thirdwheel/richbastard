<?php

header('Content-type: text/plain');

include_once('../config.inc.php');
include_once('../dbconn.inc.php');
include_once('global.inc.php');

$chknick=$db->prepare(
	 'SELECT player_nickname, player_cleanup_time '
	.'FROM player '
	.'WHERE player_nickname = ?');
$newuser=$db->prepare(
	 'INSERT INTO player '
	.'(player_id, player_nickname, player_ip_addr, player_cleanup_time) '
	.'VALUES (:id, :nick, :ipaddr, :cleanup)');
$blcheck=$db->prepare(
	 'SELECT blacklist_reason '
	.'FROM blacklist '
	.'WHERE blacklist_ip = ?');

$chknick->execute(array($_GET['nickname']));
foreach ($chknick as $nickinfo)
{
	if ($nickinfo[1] > (microtime(true) * 10000))
	{
		die('401 Nickname already in use');
	}
	//echo $nickinfo[1], ' - ', (microtime(true) * 10000), "\n";
}
$blcheck->execute(array($_SERVER['REMOTE_ADDR']));
foreach ($blcheck as $entry)
{
	die('403 Blacklisted: '.$entry[0]);
}

$res=$newuser->execute(
	array(
		'id' => generate_unique_id('player', 'player_id'),
		'nick' => $_GET['nickname'],
		'ipaddr' => $_SERVER['REMOTE_ADDR'],
		'cleanup' => (microtime(true) + 3600) * 10000
	)
);
if ($res)
	echo '200 OK';
else
	echo '501 Database Error';
?>
