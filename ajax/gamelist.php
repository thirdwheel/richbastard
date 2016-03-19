<?php

header('Content-type: text/plain');
session_start();

include_once('../config.inc.php');
include_once('../dbconn.inc.php');
include_once('global.inc.php');
include_ince('checksession.inc.php');

$game=$db->exec(
	 "SELECT g.game_id, game_desc, COUNT(player_id) "
	."FROM game g "
	."INNER JOIN game_player gp on g.game_id = gp.game_id")

$first=true;
foreach ($game as $instance)
{
	if ($first) echo '200 OK';
	$first=false;
	echo '300 ', $instance[0], ',', $instance[2], ',', $instance[1];
}

?>
