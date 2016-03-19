<?php

$chksess=$db->prepare(
	 'SELECT player_cleanup_time '
	.'FROM player '
	.'WHERE player_id = ?');
$delsess=$db->prepare(
	 'DELETE FROM player '
	.'WHERE player_id = ?');

if (!isset($_SESSION['player_id'])) die('501 No session active');

$chksess->execute(array($_SESSION['player_id']));
foreach ($chksess as $sess)
{
	if ((microtime(true) * 10000) > $sess[0])
	{
		$delsess->execute(array($_SESSION['player_id']));
		die('502 Session Expired');
	}
}

?>
