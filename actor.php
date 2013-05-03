<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Actor list</title>
	<link href="css/table_style.css" rel="stylesheet" />
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery-1.9.1.js"></script> 
	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
	<script src="js/bootstrap-dropdown.js"></script>
	<script type="text/javascript" src="js/delete.js"></script>
	<script>
	function createLinks(){
	  $('p, td').filter(function() {
		return this.innerHTML.match(/(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?/);
	}).each(function(){
		var link = $('<a>', { href: this.innerHTML,
		  text: this.innerHTML });

		if(this.tagName == "P")
		  this.parentNode.replaceChild(link[0], this);
	  else{
		  this.removeChild(this.childNodes[0])
		  this.appendChild(link[0]);
	  }
  });
}
</script>


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
						<li><a href="video.php">Video list</a></li>
						<li class="active"><a href="actor.php">Actor</a></li>
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

	<p style='margin:45px;'><em>Retrieving all records from the actor table. Click on the column name to sort. </em>
		<a href='add_actor.php' >Add actor. </a>
		<a href='videostar.php' >View the movies they starred in</a>
	</p>

	<?php

	include 'dbConnection.php';

	// Establish the connection
	$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	// Performing SQL query
	$query = "select a.actorid, (a.firstname || ' ' || a.lastname) as name, a.date_of_birth, a.imdb_link from project.actor a";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>Actor name</th>
	<th>Date of birth</th>
	<th>IMDB link</th>
	</tr></thead>\n<tbody>";
	while ($line = pg_fetch_array($result)) {
		echo "<tr>";
		echo "<td>".$line[1]."</td>";
		echo "<td>".$line[2]."</td>";
		echo "<td>".$line[3]."</td>";
		echo "<td><a onclick='if(!delete_actor(".$line[0].")){setTimeout(function(){location.reload(true)},1000);}'>delete</a></td>";
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
		createLinks();
	});
	</script>

</body>
</html>
