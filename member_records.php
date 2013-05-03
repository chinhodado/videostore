<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
	<title>Member Information</title>
	<link href="css/table_style.css" rel="stylesheet" />
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" media="all" href="css/form_style.css">
	<link rel="stylesheet" type="text/css" media="all" href="fancybox/jquery.fancybox.css">
	<script src="js/jquery-1.9.1.js"></script> 
	<script src="js/jquery.tablesorter.js"></script>
	<script src="js/bootstrap-dropdown.js"></script>
	<script src="fancybox/jquery.fancybox.js"></script>
	<script src="js/delete.js"></script> 
	<style>
		h3 { margin: 45px; }
		#button { 
			width: 150px;
			height: 30px;
			background-color: blue;
			border-radius: 10px;
			border: 1px solid black;
			text-align: center;
			font-size: 14px;
			margin: 45px;
		}

		#button ul {
			height: auto;
			padding: 6px 0px;
			margin: 0px;
			list-style-type: none;
		}
		#button a {
			text-decoration: none;
			color: white;
		}

		#button hover {
			opacity: 8;
		}
	</style>
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
	<h3>Member Info</h3>
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

	$sql = "select * from project.member m where m.email=$1";

	$stmt = pg_prepare($dbh,"ps",$sql);
	$result = pg_execute($dbh,"ps",array($email));

	if (!$result) {
		die("Error in SQL query: ".pg_last_error());
	} 
	
	if (! isset($_SESSION['membernumber'])) {
		$_SESSION['membernumber'] = pg_fetch_result($result, 0, 0);
	}
	
	echo "<table id='hor-minimalist-b'><thead>
	<tr>
	<th>Member Number</th>
	<th>Last Name</th>
	<th>First Name</th>
	<th>Email</th>
	<th>Password</th>
	
	</tr></thead>\n<tbody>";
	while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
		echo "\t<tr>\n";
		foreach ($line as $col_value) {
			echo "\t\t<td>$col_value</td>\n";
		}
		echo "\t</tr>\n";
	}
	echo "</tbody></table>\n";

		//get the billing information
		echo "<h3>Billing Information</h3>";
		$sql_billingaddress = "select b.membernumber, b.cardnumber, b.type
								from project.member m, project.billinginformation b 
								where m.membernumber=b.membernumber and m.email='".$email."';";
		$result = pg_query($sql_billingaddress) or die('Query failed: ' . pg_last_error());

		if (!$result) {
			die("Error in SQL query: ".pg_last_error());
		}

		echo "<table id='hor-minimalist-b'><thead>
		<tr>
		<th>Card Number</th>
		<th>Type</th>
		<th>Remove</th>

		</tr></thead>\n<tbody>";
		while ($line = pg_fetch_array($result)) {
			echo "<tr>";
			echo "<td>".$line[1]."</td>";
			echo "<td>".$line[2]."</td>";
			echo "<td><a onclick='if(!delete_billinginfo(".$_SESSION['membernumber'].",".$line[1].")){setTimeout(function(){location.reload(true)},1000);}'>delete</a></td>";
			echo "</tr>";
		}
		echo "</tbody></table>\n";

		//get the shipping address
		echo "<h3>Shipping Address</h3>";
		$sql_billingaddress = "select s.membernumber, s.address1, s.address2, s.city, s.phone, s.postalcode, s.saddresid
								from project.member m, project.shippingaddress s 
								where m.membernumber=s.membernumber and m.email='".$email."';";
		$result = pg_query($sql_billingaddress) or die('Query failed: ' . pg_last_error());

		if (!$result) {
			die("Error in SQL query: ".pg_last_error());
		}

		echo "<table id='hor-minimalist-b'><thead>
		<tr>
		<th>Address 1</th>
		<th>Address 2</th>
		<th>City</th>
		<th>Phone</th>
		<th>Postal Code</th>
		<th>Remove</th>
		

		</tr></thead>\n<tbody>";
		while ($line = pg_fetch_array($result)) {
			echo "<tr>";
			echo "<td>".$line[1]."</td>";
			echo "<td>".$line[2]."</td>";
			echo "<td>".$line[3]."</td>";
			echo "<td>".$line[4]."</td>";
			echo "<td>".$line[5]."</td>";
			echo "<td><a onclick='if(!delete_shippingaddress(".$line[6].")){setTimeout(function(){location.reload(true)},1000);}'>delete</a></td>";
			echo "</tr>";
		}
		echo "</tbody></table>\n";
		
		//get the billing address
		echo "<h3>Billing Address</h3>";
		$sql_billingaddress = "select b.membernumber, b.address1, b.address2, b.city, b.phone, b.postalcode, b.baddresid
								from project.member m, project.billingaddress b 
								where m.membernumber=b.membernumber and m.email='".$email."';";
		$result = pg_query($sql_billingaddress) or die('Query failed: ' . pg_last_error());

		if (!$result) {
			die("Error in SQL query: ".pg_last_error());
		}

		$membernumber = 0;//save for later use

		echo "<table id='hor-minimalist-b'><thead>
		<tr>
		<th>Address 1</th>
		<th>Address 2</th>
		<th>City</th>
		<th>Phone</th>
		<th>Postal Code</th>
		<th>Remove</th>

		</tr></thead>\n<tbody>";
		while ($line = pg_fetch_array($result)) {
			echo "<tr>";
			echo "<td>".$line[1]."</td>";
			echo "<td>".$line[2]."</td>";
			echo "<td>".$line[3]."</td>";
			echo "<td>".$line[4]."</td>";
			echo "<td>".$line[5]."</td>";
			echo "<td><a onclick='if(!delete_billingaddress(".$line[6].")){setTimeout(function(){location.reload(true)},1000);}'>delete</a></td>";
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
	
	<div id="button"><ul>
			<li><a class="modalbox2" href="#inlineBillInfo">Add Billing Info</a></li>
		</ul></div>
	
	<!-- hidden inline form -->
	<div class="inline" id="inlineBillInfo">
			<h2>New Billing Information</h2>
			<form id="billingInfoForm" name="billingInfoForm" action="#" method="post">
				<label for="cardnumber">Card Number</label>
				<input type="text" id="cardnumber" name="cardnumber">
				<label for="type">Type</label>
				<select id="type" name="type" class="txt">
					<option value="None">None</option>
					<option value="Visa">Visa</option>
					<option value="Paypal">Paypal</option>
					<option value="Subscription">Subscription</option>
				</select>
				<button class="button" id="sendBillInfo">Add</button>
		</form>
	</div>
	
	<div id="button"><ul>
			<li><a class="modalbox3" href="#inlineShip">Add Shipping Address</a></li>
		</ul></div>
		
	<!-- hidden inline form -->
	<div class="inline" id="inlineShip">
			<h2>New Shipping Address</h2>
			<form id="shippingForm" name="shippingForm" action="#" method="post">
				<label for="saddress1">Address 1</label>
				<input type="text" id="saddress1" name="saddress1" class="txt">
				<br>
				<label for="saddress2">Address 2</label>
				<input type="text" id="saddress2" name="saddress2" class="txt">
				<br>
				<label for="scity">City</label>
				<input type="text" id="scity" name="scity" class="txt">
				<br>
				<label for="sphone">Phone</label>
				<input type="text" id="sphone" name="sphone" class="txt">
				<br>
				<label for="spostalcode">Postal Code</label>
			<input type="text" id="spostalcode" name="spostalcode" class="txt">
				<button class="button" id="sendShip">Add</button>
		</form>
	</div>
		
	<div id="button"><ul>
	<li><a class="modalbox4" href="#inlineBill">Add Billing Address</a></li>
	</ul></div>
	
	<!-- hidden inline form -->
	<div class="inline" id="inlineBill">
		<h2>New Billing Address</h2>

		<form id="billingForm" name="billingForm" action="#" method="post">
			<label for="baddress1">Address 1</label>
			<input type="text" id="baddress1" name="baddress1" class="txt">
			<br>
			<label for="baddress2">Address 2</label>
			<input type="text" id="baddress2" name="baddress2" class="txt">
			<br>
			<label for="bcity">City</label>
			<input type="text" id="bcity" name="bcity" class="txt">
			<br>
			<label for="bphone">Phone</label>
			<input type="text" id="bphone" name="bphone" class="txt">
			<br>
			<label for="bpostalcode">Postal Code</label>
			<input type="text" id="bpostalcode" name="bpostalcode" class="txt">

			<button class="button" id="sendBill">Add</button>
		</form>
	</div>

	<!-- basic fancybox setup -->
	<script type="text/javascript">

	$(document).ready(function() {
		$(".modalbox1, .modalbox2, .modalbox3, .modalbox4").fancybox({
			'afterClose': function(){
				parent.location.reload(true);
			}
		});
		$("#billingForm, #shippingForm, #billingInfoForm").submit(function() { return false; });

		$("#sendBill").on("click", function(){
			var baddress1  = $("#baddress1").val();
			var baddress2  = $("#baddress2").val();
			var bcity  = $("#bcity").val();
			var bphone  = $("#bphone").val();
			var bpostalcode  = $("#bpostalcode").val();

			//hide the submit btn so the user doesnt click twice
		$("#sendBill").replaceWith("<br/><em>adding...</em>");
			
		$.ajax({
			type: 'POST',
			url: 'add_billingaddress.php',
			data: {membernumber: <?php echo $_SESSION['membernumber']; ?>,address1:baddress1, address2:baddress2, city:bcity, phone:bphone, postalcode:bpostalcode},
			success: function(data) {
				if(data === "true") {
					$("#billingForm").fadeOut("fast", function(){
						$(this).before("<p><strong>Success! Your new billing address has been added!</strong></p>");
						setTimeout("$.fancybox.close()", 1000);
					});
				} else {
					$("#billingForm").fadeOut("fast", function(){
						$(this).before("<p><strong>Unable to update system, Please try again Later.</strong></p>" + data);
					});
				}
			}
		});
	});

	$("#sendShip").on("click", function(){
		var saddress1  = $("#saddress1").val();
		var saddress2  = $("#saddress2").val();
		var scity  = $("#scity").val();
		var sphone  = $("#sphone").val();
		var spostalcode  = $("#spostalcode").val();

		//hide the submit btn so the user doesnt click twice
		$("#sendShip").replaceWith("<br/><em>adding...</em>");
		
		$.ajax({
			type: 'POST',
			url: 'add_shippingaddress.php',
			data: {membernumber: <?php echo $_SESSION['membernumber']; ?>,address1:saddress1, address2:saddress2, city:scity, phone:sphone, postalcode:spostalcode},
			success: function(data) {
				if(data === "true") {
					$("#shippingForm").fadeOut("fast", function(){
						$(this).before("<p><strong>Success! Your new shipping address has been added!</strong></p>");
						setTimeout("$.fancybox.close()", 1000);
					});
				} else {
					$("#shippingForm").fadeOut("fast", function(){
						$(this).before("<p><strong>Unable to update system, Please try again Later.</strong></p>" + data);
					});
				}
			}
		});

	});

	$("#sendBillInfo").on("click", function(){
		var cardnumber  = $("#cardnumber").val();
		var type  = $("#type").val();

		//hide the submit btn so the user doesnt click twice
		$("#sendBillInfo").replaceWith("<br/><em>adding...</em>");
		
		$.ajax({
			type: 'POST',
			url: 'add_billinginfo.php',
			data: {membernumber: <?php echo $_SESSION['membernumber']; ?>,cardnumber:cardnumber, type:type},
			success: function(data) {
				if(data === "true") {
					$("#billingInfoForm").fadeOut("fast", function(){
						$(this).before("<p><strong>Success! Your new billing information has been added!</strong></p>");
						setTimeout("$.fancybox.close()", 1000);
					});
				} else {
					$("#billingInfoForm").fadeOut("fast", function(){
						$(this).before("<p><strong>Unable to update system, Please try again Later.</strong></p>" + data);
					});
				}
			}
		});

	});
});
</script>

</body>

</html>	
