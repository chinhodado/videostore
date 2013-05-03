<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>query e</title>
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

	//total number of video
	$query = "select count(*) as numberofvideo
			from project.video v;";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	$line = pg_fetch_array($result);

	echo "<p style='margin:45px;'>Total number of video: ".$line[0]."</p>";


	// number of video by each director
	$query = "select (d.firstname || ' ' || d.lastname) as dname, count(*) as numberofvideo
				from project.video v, project.director d
				where v.directorid=d.directorid
				group by d.directorid
				order by numberofvideo DESC;";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>Director</th>
	<th>Number of video</th>
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
