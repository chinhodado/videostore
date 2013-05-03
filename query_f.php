<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>query d</title>
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

	// Performing SQL query: display genre-choosing box

	$query = "select v.genre from project.video v group by v.genre;";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<div id='content'>";
	echo "<form id='login-form' method='POST'>";

	echo "Genre: <select name='genre'>";
	while ($line = pg_fetch_array($result)) {
		echo "<option value=".$line[0].">".$line[0]."</option>";
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

		//get the member who downloads
		$query = "select v2.videoname, v2.salesprice, count(*) as numreturned
					from project.video v2, project.videosreturned d2
					where d2.videoid=v2.videoid and v2.genre='".$_POST['genre']."'
					group by v2.videoid
					having count(*)>=ALL(select count(*)
											from project.video v, project.videosreturned d
											where d.videoid=v.videoid and v.genre='".$_POST['genre']."' 
											group by v.videoid);";


		$result = pg_query($query) or die('Query failed: ' . pg_last_error());

		// Printing results in HTML
		echo "<p style='margin:45px;'>The video(s) returned the most of this genre:</p>";
		echo "<table id='hor-minimalist-b'><thead>
		<tr>
		<th>Video name</th>
		<th>Sales price</th>
		<th>Number of returned</th>

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
