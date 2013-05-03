<?php

	//info from form	
	
	$membernumber = $_POST['membernumber'];
	$cardnumber  = $_POST['cardnumber'];
	$type  = $_POST['type'];

	include 'dbConnection.php';

	// Establish the connection
	$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	// Performing SQL query
	$query = "INSERT INTO project.billinginformation(membernumber, cardnumber, type) VALUES('";
			$query .= $membernumber;
			$query .= "', '";
			$query .= $cardnumber;
			$query .= "', '";
			$query .= $type;
			$query .= "');";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());
	echo "true";
	// Free resultset
	pg_free_result($result);

	// Closing connection
	pg_close($dbconn);
?>
