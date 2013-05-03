<!DOCTYPE html>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add new actor</title>
	
	<!-- Stylesheets -->
	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet'>
	<link rel="stylesheet" href="css/form.css">

	<!-- Optimize for mobile devices -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>  
</head>
<body>

	<!-- HEADER -->
	<div id="header">
		
		<div class="page-full-width cf">
	
			<div id="login-intro" class="fl">
			
				<h1>Add new actor</h1>
				<h5>Enter the actor's information below</h5>
			
			</div> <!-- login-intro -->
			
		</div> <!-- end full-width -->	

	</div> <!-- end header -->
	
	
	
	<!-- MAIN CONTENT -->
	<div id="content">
	
		<form action="" method="POST" id="login-form">
		
			<fieldset>

				<p>
					<label for="firstname">First name:</label>
					<input type="text" id="firstname" name="firstname" class="round full-width-input" autofocus required/>
				</p>

				<p>
					<label for="lastname">Last name:</label>
					<input type="text" id="lastname" name="lastname" class="round full-width-input" required />
				</p>

				<p>
					<label for="dob">Date of birth:</label>
					<input type="text" id="dob" name="dob" class="round full-width-input" required/>
				</p>

				<p>
					<label for="imdb">IMDB link:</label>
					<input type="text" id="imdb" name="imdb" class="round full-width-input" />
				</p>
				
				<input class="button round blue image-right ic-right-arrow" type="submit" name="bAdd" value="Add"/>

			</fieldset>

			<br/><div class="information-box round">Click on the ADD button to add the actor to the database</div>

		</form>

		<?php
		if (array_key_exists('firstname', $_POST) && array_key_exists('lastname', $_POST) && array_key_exists('dob', $_POST))
		{
			include 'dbConnection.php';

			// Establish the connection
			$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

			// Performing SQL query
			$query = "INSERT INTO project.actor(lastname, firstname, date_of_birth, imdb_link) VALUES('";
			$query .= $_POST['lastname'];
			$query .= "', '";
			$query .= $_POST['firstname'];
			$query .= "', '";
			$query .= $_POST['dob'];
			$query .= "', '";
			$query .= $_POST['imdb'];
			$query .= "');";

			$result = pg_query($query) or die('Query failed: ' . pg_last_error());

			echo "<p>Inserted ".$_POST['firstname']." ".$_POST['lastname']." into the database</p>";

			// Free resultset
			pg_free_result($result);

			// Closing connection
			pg_close($dbconn);
		}
		?>
		
	</div> <!-- end content -->
</body>
</html>