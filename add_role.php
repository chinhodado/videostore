<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add a new actor-video star role</title>
	<link href="css/table_style.css" rel="stylesheet" />
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.css" rel="stylesheet">

	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet'>
	<link rel="stylesheet" href="css/form.css">

	<script type="text/javascript" src="js/jquery-1.9.1.js"></script> 
	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
	<script src="js/bootstrap-dropdown.js"></script>
</head>
<body>
	<a href="videostar.php">back</a>
	<?php
	//variables
	$host = "54.225.247.251";
	$password = "password";
	// $host = "localhost";
	// $password = "root";
	$username = "postgres";			
	$database = "postgres";
	$port = "5432";

	// Connecting, selecting database
	$dbconn = pg_connect("host=".$host." port=".$port." dbname=".$database." user=".$username." password=".$password)
	or die('Could not connect: ' . pg_last_error());

	// Performing SQL query
	$query1 = "select a.actorid, (a.firstname || ' ' || a.lastname) as name from project.actor a";
	$result1 = pg_query($query1) or die('Query failed: ' . pg_last_error());

	$query2 = "select v.videoid, v.videoname from project.video v";
	$result2 = pg_query($query2) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<div id='content'>";
	echo "<form id='login-form' method='POST'>";

	echo "Actor: <select name='actorid'>";
	while ($line = pg_fetch_array($result1)) {
		echo "<option value=".$line[0].">".$line[1]."</option>";
	}
	echo "</select><br/>";

	echo "Video: <select name='videoid'>";
	while ($line = pg_fetch_array($result2)) {
		echo "<option value=".$line[0].">".$line[1]."</option>";
	}
	echo "</select><br/>";
	echo "Role: <input type='text' id='rolename' name='rolename' required/>";

	echo "<input type='submit' name='submit' value='Submit'>";

	echo "</form>";
	echo "</div>";

			// Free resultset
	pg_free_result($result1);

			// Closing connection
	pg_close($dbconn);
	?>

	<?php
	if (array_key_exists('submit', $_POST))
	{
		include 'dbConnection.php';

		// Establish the connection
		$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

		// Performing SQL query
		$query = "INSERT INTO project.videostar(videoid, actorid, rolename) VALUES('";
		$query .= $_POST['videoid'];
		$query .= "', '";
		$query .= $_POST['actorid'];
		$query .= "', '";
		$query .= $_POST['rolename'];
		$query .= "');";

		$result = pg_query($query) or die('Query failed: ' . pg_last_error());

		echo "<p>Role ".$_POST['rolename']." successfully added!</p>";

		// Free resultset
		pg_free_result($result);

		// Closing connection
		pg_close($dbconn);
}
?>

</body>
</html>
