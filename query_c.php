<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>query c</title>
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

	// Performing SQL query

	$query = "select m.membernumber, (m.firstname || ' ' || m.lastname) as mname from project.member m";
	$result = pg_query($query) or die('Query failed: ' . pg_last_error());

	// Printing results in HTML
	echo "<div id='content'>";
	echo "<form id='login-form' method='POST'>";

	echo "Member: <select name='memberid'>";
	while ($line = pg_fetch_array($result)) {
		echo "<option value=".$line[0].">".$line[1]."</option>";
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

		$sql = "select * from project.member m where m.membernumber=$1";

		$stmt = pg_prepare($dbconn,"ps",$sql);
		$result = pg_execute($dbconn,"ps",array($membernumber));

		if (!$result) {
			die("Error in SQL query: ".pg_last_error());
		}

		echo "<table id='hor-minimalist-b'><thead>
		<tr>
		<th>Member number</th>
		<th>Last name</th>
		<th>First name</th>
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
			echo "<p style='margin:45px;'><em>Billing information</em></p>";
			$sql_billingaddress = "select b.membernumber, b.cardnumber, b.type
									from project.member m, project.billinginformation b 
									where m.membernumber=b.membernumber and m.membernumber='".$membernumber."';";
			$result = pg_query($sql_billingaddress) or die('Query failed: ' . pg_last_error());

			if (!$result) {
				die("Error in SQL query: ".pg_last_error());
			}

			echo "<table id='hor-minimalist-b'><thead>
			<tr>
			<th>Card number</th>
			<th>Type</th>

			</tr></thead>\n<tbody>";
			while ($line = pg_fetch_array($result)) {
				echo "<tr>";
				echo "<td>".$line[1]."</td>";
				echo "<td>".$line[2]."</td>";
				echo "</tr>";
			}
			echo "</tbody></table>\n";

		//get the shipping address
			echo "<p style='margin:45px;'><em>Shipping address</em></p>";
			$sql_billingaddress = "select s.membernumber, s.address1, s.address2, s.city, s.phone, s.postalcode
									from project.member m, project.shippingaddress s 
									where m.membernumber=s.membernumber and m.membernumber='".$membernumber."';";
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
			<th>Postalcode</th>

			</tr></thead>\n<tbody>";
			while ($line = pg_fetch_array($result)) {
				echo "<tr>";
				echo "<td>".$line[1]."</td>";
				echo "<td>".$line[2]."</td>";
				echo "<td>".$line[3]."</td>";
				echo "<td>".$line[4]."</td>";
				echo "<td>".$line[5]."</td>";
				echo "</tr>";
			}
			echo "</tbody></table>\n";

		//get the billing address
			echo "<p style='margin:45px;'><em>Billing address</em></p>";
			$sql_billingaddress = "select b.membernumber, b.address1, b.address2, b.city, b.phone, b.postalcode, b.baddresid
									from project.member m, project.billingaddress b 
									where m.membernumber=b.membernumber and m.membernumber='".$membernumber."';";
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
			<th>Postalcode</th>

			</tr></thead>\n<tbody>";
			while ($line = pg_fetch_array($result)) {
				$membernumber = $line[0];
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
			echo "<script>membernumber=".$membernumber.";</script>";


		pg_free_result($result);
		pg_close($dbconn);
	}
	?>

</body>
</html>
