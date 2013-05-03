<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Video info</title>
	<link href="css/table_style.css" rel="stylesheet" />
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.css" rel="stylesheet">
	<link href="css/box.css" rel="stylesheet">
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
						<li><a href="#contact">Contact</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Member <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="member_records.php">Member record</a></li>
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

	<?php
	include 'dbConnection.php';

	// Establish the connection
	$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

	//get the image
	$query = "select v.imagelink
			from project.video v
			where v.videoid='".$_GET['id']."';";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());
	$line = pg_fetch_array($result);
	echo "<img class='raised' style='float:left; margin-left:45px; margin-right:145px; margin-top:20px;' src='".$line[0]."'>";

	// get the video info
	$query = "select v.videoid, v.videoname, v.yearreleased, v.salesprice, v.genre, v.rating, v.duration, v.instock, (d.firstname || ' ' || d.lastname) as dname
	from project.video v, project.director d
	where v.directorid=d.directorid and v.videoid='".$_GET['id']."';";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML

	$line = pg_fetch_array($result);

	echo "<div class='wrap'>
	   <h1 style='color:rgb(153, 153, 153);'>Video info</h1>
		<ul>
			<li>
				Video name: ".$line[1]." 
			</li>
			<li>
				Year released: ".$line[2]." 
			</li>
			<li>
				Genre: ".$line[4]." 
			</li>
			<li>
				Rating: ".$line[5]." 
			</li>
			<li>
				Duration: ".$line[6]." minutes
			</li>
			<li>
				Director: ".$line[8]." 
			</li>
		</ul>
		</div>";
	$price = $line[3];
	$instock = $line[7];

	
	$query = "select (a.firstname || ' ' || a.lastname) as aname, vs.rolename
	from project.video v, project.actor a, project.videostar vs
	where vs.videoid=v.videoid and vs.actorid=a.actorid and v.videoid='".$_GET['id']."';";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	echo "<div class='wrap'>
   			<h1 style='color:rgb(192, 152, 83);'>Main actors</h1>
   			<ul>";

   	while ($line = pg_fetch_array($result)) {
	    echo "<li>";
	    echo $line[0];
	    echo "</li>";
	}
	
	echo "</ul></div>";
	
	// Get Award Info
	$query = "select v.videoid, a.awardid, va.yearawarded, va.won, a.description
	from project.videoawards VA, project.award A, project.video V
	where VA.awardid = A.awardid and VA.videoid = V.videoid and V.videoid='".$_GET['id']."'
	order by va.won desc;";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());
	
	if ( pg_num_rows($result) > 0){
		echo "<div class='wrap' style='height:auto;'>
			<h1 style='color:rgb(58, 135, 173);'>Awards</h1>
	   		<ul>";
	   	while ($line = pg_fetch_array($result)){
	   		echo "<li>".$line[4];
	   		if ($line[3] == 'y'){
	   			echo " [Won]";
	   		}else{
	   			echo " [Nominated]";
	   		}
	   		echo "</li>";
	   	}
	   	echo "</ul></div>";
	}
	
	echo "<div class='wrap'>
	   <h1 style='color:rgb(58, 135, 173);'>Store info</h1>
	   <ul>
		<li>
			Price: $".$price." 
		</li>
		<li>
			In stock: ".$instock." 
		</li>
		</ul>
		</div>";
	
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
