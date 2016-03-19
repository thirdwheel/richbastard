<?php

function generate_unique_id ($table, $field)
{
	global $db;
	$check=$db->prepare('SELECT 1 FROM '.$table.' WHERE '.$field.' = ?');

	$id=array(mt_rand(0, time()));
	$had=false;
	while (1)
	{
		$check->execute($id);
		foreach ($check as $value)
			$had=true;

		if (!$had) return $id[0];
		$had=false;
	}
}

?>
