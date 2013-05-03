<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>query l</title>
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

	echo "<p style='margin:45px;'>The director and his video that have the highest number of Oscar nominations but has never actually won one: </p>";


	// number of video by each director
	$query = "select (d.firstname || ' ' || d.lastname) as dname, v3.videoname, count(*) as num_nominations
				from project.video v3, project.videoawards va3, project.director d
				where d.directorid=v3.directorid and v3.videoid=va3.videoid and va3.won='n' 
											and v3.videoid not in (
																select v4.videoid
																from project.video v4, project.videoawards va4
																where v4.videoid=va4.videoid and va4.won='y')
				group by v3.videoid, (d.firstname || ' ' || d.lastname)
				having count(*) >=ALL(select count(*)
									from project.video v2, project.videoawards va2
									where v2.videoid=va2.videoid and va2.won='n' 
																and v2.videoid not in (
																					select v.videoid
																					from project.video v, project.videoawards va
																					where v.videoid=va.videoid and va.won='y')
									group by v2.videoid);";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>Director</th>
	<th>Video name</th>
	<th>Number of nominations</th>

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
