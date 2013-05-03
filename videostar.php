<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Video star</title>
	<link href="css/table_style.css" rel="stylesheet" />
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery-1.9.1.js"></script> 
	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
	<script type="text/javascript" src="js/delete.js"></script>
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
	 <!--              <li><a href="#">Another action</a></li>
				  <li class="divider"></li>
				  <li class="nav-header">Nav header</li>
				  <li><a href="#">Separated link</a></li>
				  <li><a href="#">One more separated link</a></li> -->
				</ul>
			</li>
		</ul>
<!--             <form class="navbar-form pull-right">
			  <input class="span2" type="text" placeholder="Email">
			  <input class="span2" type="password" placeholder="Password">
			  <button type="submit" class="btn">Sign in</button>
			</form> -->
				</div><!--/.nav-collapse -->
			</div>
		</div>
	</div>
	<br/><br/><br/><br/>
	<p style='margin:45px;'><em>Retrieving all records from the videostar table. Click on the column name to sort. </em>
		<a href="add_role.php">Add a new role</a>
	</p>

	<?php
	include 'dbConnection.php';

	// Establish the connection
	$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	// Performing SQL query
	$query = "select (a.firstname || ' ' || a.lastname) as aname, v.videoname, v.yearreleased, vs.rolename, a.actorid, v.videoid
				from project.video v, project.actor a, project.videostar vs
				where v.videoid=vs.videoid and a.actorid=vs.actorid";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>Actor name</th>
	<th>Video name</th>
	<th>Year released</th>
	<th>Role name</th>
	</tr></thead>\n<tbody>";
	while ($line = pg_fetch_array($result)) {
		echo "<tr>";
		echo "<td>".$line[0]."</td>";
		echo "<td>".$line[1]."</td>";
		echo "<td>".$line[2]."</td>";
		echo "<td>".$line[3]."</td>";
		echo "<td><a onclick=\"if(!delete_actorrole('".$line[5]."', ".$line[4].")){setTimeout(function(){location.reload(true)},1000);}\">delete</a></td>";
		echo "</tr>";
		echo "\n";
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
