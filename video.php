<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Video list</title>
	<link href="css/table_style.css" rel="stylesheet" />
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery-1.9.1.js"></script> 
	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
	<script src="js/bootstrap-dropdown.js"></script>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="brand" href="index.html">Video store</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="active"><a href="video.php">Video list</a></li>
						<li><a href="actor.php">Actor</a></li>
						<li><a href="query.php">Queries</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Member <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="member_records.php">Member record</a></li>
								<li><a href="transaction.php">Member's transaction record</a></li>
								<li><a href="destroy_session.php">Log out</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<br/><br/><br/><br/>
	<p style='margin:45px;'><em>Retrieving all records from the video table. Click on the column name to sort.</em></p>

	<?php

	include 'dbConnection.php';

	// Establish the connection
	$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	// Performing SQL query
	$query = "select v.videoid, v.videoname, v.yearreleased, v.salesprice, v.genre, v.rating, v.duration, v.instock, (d.firstname || ' ' || d.lastname) as dname
	from project.video v, project.director d
	where v.directorid=d.directorid";
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
	while ($line = pg_fetch_array($result)) {
		echo "<tr>";
		
		echo "<td><a href=videoinfo.php?id=".$line[0].">".$line[1]."</a></td>";
		echo "<td>".$line[2]."</td>";
		echo "<td>".$line[3]."</td>";
		echo "<td>".$line[4]."</td>";
		echo "<td>".$line[5]."</td>";
		echo "<td>".$line[6]."</td>";
		echo "<td>".$line[7]."</td>";
		echo "<td>".$line[8]."</td>";    
		echo "</tr>";
	}
	echo "</tbody></table>\n";

	// Free resultset
	pg_free_result($result);

	// Closing connection
	pg_close($dbconn);
	?>

	<script>
	$(document).ready(function(){ 
		$("#hor-minimalist-b").tablesorter();        
	});
	</script>

</body>
</html>
