<?php

	//info from form	
	
	$membernumber = $_POST['membernumber'];
	$address1  = $_POST['address1'];
	$address2  = $_POST['address2'];
	$city  		= $_POST['city'];
	$phone 		 = $_POST['phone'];
	$postalcode  = $_POST['postalcode'];

	include 'dbConnection.php';

	// Establish the connection
	$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	// Performing SQL query
	$query = "INSERT INTO project.billingaddress(membernumber, address1, address2, city, phone, postalcode) VALUES('";
			$query .= $membernumber;
			$query .= "', '";
			$query .= $address1;
			$query .= "', '";
			$query .= $address2;
			$query .= "', '";
			$query .= $city;
			$query .= "', '";
			$query .= $phone;
			$query .= "', '";
            $query .= $postalcode;
			$query .= "');";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());
	echo "true";
	// Free resultset
	pg_free_result($result);

	// Closing connection
	pg_close($dbconn);
?>
