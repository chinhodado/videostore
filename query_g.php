<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>query g</title>
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

	echo "<p style='margin:45px;'>Member(s) that have a total purchase that is higher than the average purchase: </p>";


	// number of video by each director
	$query = "select m2.firstname, m2.lastname, m2.email, count(*)
				from project.member m2, project.purchase p2
				where m2.membernumber=p2.membernumber
				group by m2.membernumber
				having count(*)>= (select avg(numpurchase) from(
												select count(*) as numpurchase
												from project.member m, project.purchase p
												where m.membernumber=p.membernumber
												group by m.membernumber) a);";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>First name</th>
	<th>Last name</th>
	<th>Email</th>
	<th>Number purchased</th>
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
