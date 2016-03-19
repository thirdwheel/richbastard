<?php

try
{
	$db=new PDO($q='mysql:host='.$config['dbaddr'].';dbname='.$config['dbname'].
		';', $config['dbuser'], $config['dbpass']);
}
catch (PDOException $e)
{
	die('500 Could not connect to database: '.$e->getMessage());
}

?>
