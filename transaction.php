<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
	<title>Member transaction history</title>
	<link href="css/table_style.css" rel="stylesheet" />
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" media="all" href="css/form_style.css">
	<script src="js/jquery-1.9.1.js"></script> 
	<script src="js/jquery.tablesorter.js"></script>
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
			  <li><a href="video.php">Video list</a></li>
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
		  </div><!--/.nav-collapse -->
		</div>
	  </div>
	</div>

	<br/><br/><br/><br/>
	<?php
	session_set_cookie_params(0);
	session_start();
	if(!isset($_SESSION['email'])){
		echo "Please "."<a href='member_login.php'>login</a>";
		exit;
	}

	include 'dbConnection.php';

	// Establish the connection
	$dbh = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	$email = $_SESSION['email'];

	$sql = "select v.videoname, d.datedownload, d.timedownload, d.fee 
			from project.member m, project.video v, project.download d
			where v.videoid=d.videoid and d.membernumber=m.membernumber and m.email=$1";

	$stmt = pg_prepare($dbh,"ps",$sql);
	$result = pg_execute($dbh,"ps",array($email));

	if (!$result) {
		die("Error in SQL query: ".pg_last_error());
	}
	echo "<p style='margin:45px;'><em>Member's download information</em></p>";
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>Video name</th>
	<th>Date downloaded</th>
	<th>Time downloaded</th>
	<th>Fee</th>
	</tr></thead>\n<tbody>";
	while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
		echo "\t<tr>\n";
		foreach ($line as $col_value) {
			echo "\t\t<td>$col_value</td>\n";
		}
		echo "\t</tr>\n";
	}
	echo "</tbody></table>\n";

	//get the purchase information
	echo "<p style='margin:45px;'><em>Member's purchase information</em></p>";
	$sql_billingaddress = "select v.videoname, p.date_ordered, p.date_shipped, p.shipping_cost, p.speed, p.carrier
						from project.member m, project.video v, project.purchase p
						where v.videoid=p.videoid and p.membernumber=m.membernumber and m.email='".$email."';";
	$result = pg_query($sql_billingaddress) or die('Query failed: ' . pg_last_error());
	// $stmt2 = pg_prepare($dbh,"ps",$sql_billingaddress);
	// $result2 = pg_execute($dbh,"ps",array($email));

	if (!$result) {
		die("Error in SQL query: ".pg_last_error());
	}

	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>Video name</th>
	<th>Date ordered</th>
	<th>Date shipped</th>
	<th>Shipping cost</th>
	<th>Speed</th>
	<th>Carrier</th>

	</tr></thead>\n<tbody>";
	while ($line = pg_fetch_array($result)) {
		echo "<tr>";
		echo "<td>".$line[0]."</td>";
		echo "<td>".$line[1]."</td>";
		echo "<td>".$line[2]."</td>";
		echo "<td>".$line[3]."</td>";
		echo "<td>".$line[4]."</td>";
		echo "<td>".$line[5]."</td>";
		echo "</tr>";
	}
	echo "</tbody></table>\n";

	pg_free_result($result);
	pg_close($dbh);
	?>

	<script>
	$(document).ready(function(){ 
		$("#hor-minimalist-b").tablesorter();        
	});
	</script>

</body>

</html>	