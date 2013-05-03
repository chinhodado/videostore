<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>query a</title>
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
	<a href="query.php">back</a>
	<?php
	include 'dbConnection.php';

	// Establish the connection
	$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	// Performing SQL query

	$query = "select v.videoid, v.videoname from project.video v";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<div id='content'>";
	echo "<form id='login-form' method='POST'>";

	echo "Video: <select name='videoid'>";
	while ($line = pg_fetch_array($result)) {
		echo "<option value=".$line[0].">".$line[1]."</option>";
	}
	echo "</select><br/>";

	echo "<input type='submit' name='submit' value='Submit'>";

	echo "</form>";
	echo "</div>";

			// Free resultset
	pg_free_result($result);

			// Closing connection
	pg_close($dbconn);
	?>

	<?php
	if (array_key_exists('submit', $_POST))
	{
		include 'dbConnection.php';

		// Establish the connection
		$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

		$query = "select v.videoname, v.yearreleased, v.salesprice, v.genre, v.rating, v.duration, v.instock, (d.firstname || ' ' || d.lastname) as dname
		from project.video v, project.director d
		where v.directorid=d.directorid and v.videoid='".$_POST['videoid']."';";
		$result = pg_query($query) or die('Query failed: ' . pg_last_error());

		// Printing results in HTML
		echo "<table id='hor-minimalist-b'><thead>
		<tr>
		<th>Video name</th>
		<th>Year released</th>
		<th>Price</th>
		<th>Genre</th>
		<th>Rating</th>
		<th>Duration</th>
		<th>In stock</th>
		<th>Director</th>
		</tr></thead>\n<tbody>";
		while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
			echo "\t<tr>\n";
			foreach ($line as $col_value) {
				echo "\t\t<td>$col_value</td>\n";
			}
			echo "\t</tr>\n";
		}
		echo "</tbody></table>\n";

		// Free resultset
		pg_free_result($result);

		// Closing connection
		pg_close($dbconn);
	}
	?>

</body>
</html>
