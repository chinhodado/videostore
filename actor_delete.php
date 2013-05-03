<?php
	include 'dbConnection.php';

	// Establish the connection
	$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	// Performing SQL query
	$query = "delete from project.actor a where a.actorid='".$_POST['todelete']."'";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Free resultset
	pg_free_result($result);

	// Closing connection
	pg_close($dbconn);
?>