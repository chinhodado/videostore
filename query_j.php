<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>query j</title>
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

	echo "<p style='margin:45px;'>The actor(s) that star in the video(s) that are downloaded most frequently.: </p>";


	// actor in bestsellers videos
	$query = "select distinct a2.firstname, a2.lastname, a2.date_of_birth
				from project.actor a2, project.video v2, project.videostar vs2
				where vs2.actorid=a2.actorid and vs2.videoid=v2.videoid and v2.videoid in(
					select v.videoid
					from project.video v, project.download d
					where v.videoid=d.videoid
					group by v.videoid
					order by count(*) DESC
					limit 5);";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>First name</th>
	<th>Last name</th>
	<th>Date of birth</th>
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
