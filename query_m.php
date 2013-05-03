<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>query m</title>
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

	echo "<p style='margin:45px;'>The three movies that won the most number of Oscar awards, along with their directors and main actors: </p>";


	// the three movies that won the most number of Oscar awards, along with their directors and main actors
	//the view "most_oscar" is already created, no no need to do that again
	$query = "select videoname, string_agg(aname, ', ') as actor_list, dname, number_oscar_won from(
				select mo.videoname, (a.firstname || ' ' || a.lastname) as aname, mo.dname, number_oscar_won
				from project.most_oscar mo, project.actor a, project.videostar vs
				where vs.videoid=mo.videoid and vs.actorid=a.actorid) a
				group by videoname, dname, number_oscar_won;";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>Video</th>
	<th>Actors</th>
	<th>Director</th>
	<th>Number of Oscars won</th>

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
	?>

</body>
</html>
