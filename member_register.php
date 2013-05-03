<!DOCTYPE html>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Member registration</title>
	
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
				
				<h1>Member registration</h1>
				<h5>Please enter your information below</h5>
				
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
					<label for="email">Email:</label>
					<input type="text" id="email" name="email" class="round full-width-input" required/>
				</p>

				<p>
					<label for="pass">Password:</label>
					<input type="password" id="pass" name="pass" class="round full-width-input" required/>
				</p>
				
				<input class="button round blue image-right ic-right-arrow" type="submit" name="register" value="Register"/>

			</fieldset>

			<br/><div class="information-box round">Please ensure that you have correctly entered all information, then click Register</div>

		</form>

		<?php
		if (array_key_exists('register', $_POST))
		{
			include 'dbConnection.php';

			// Establish the connection
			$dbconn = pg_connect(pg_connection_string_from_database_url()) or die('Could not connect: ' . pg_last_error());

			// Performing SQL query
			$query = "INSERT INTO project.member(lastname, firstname, email, password) VALUES('";
				$query .= $_POST['lastname'];
				$query .= "', '";
				$query .= $_POST['firstname'];
				$query .= "', '";
				$query .= $_POST['email'];
				$query .= "', '";
				$query .= $_POST['pass'];
				$query .= "');";

			$result = pg_query($query) or die('Query failed: ' . pg_last_error());

			echo "<p>Member ".$_POST['firstname']." ".$_POST['lastname']." successfully registered!</p>";

						// Free resultset
			pg_free_result($result);

						// Closing connection
			pg_close($dbconn);
			}
		?>

</div> <!-- end content -->
</body>
</html>