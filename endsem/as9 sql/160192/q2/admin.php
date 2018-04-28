<!DOCTYPE html>
<html>
<head>
<title>
Admin Login</title>
<style>
td{
 border:solid 1px black;
 padding:5px;
}
</style>
</head>
<body>
<form href="#" method="POST">
<input type="text" name="name" placeholder="Enter your id.">
<input type="password" name="password" >
<input type="submit" value="Log In">
</form>
<?php
$db = new SQLite3('data');
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["name"]);
  $password = test_input($_POST["password"]);
  $result=$db->query("SELECT * FROM admin WHERE LOGIN='".$name."' AND PASSWORD='".$password."';");
  if($row=$result->fetchArray()){
	echo "<h2>Records:</h2>";
	$results = $db->query('SELECT * FROM records');
	echo "<table><thead><tr><td>Name</td><td>Address</td><td>Email</td><td>Mobile Number</td><td>Account No</td></tr></thead>";
	while ($row = $results->fetchArray()) {
		    echo "<tr><td>$row[1]</td><td>$row[2]</td><td>$row[3]</td><td>$row[4]</td><td>$row[5]</td></tr>";
	}
	echo "</table>";
  }
  else
	echo "Invalid admin.";
}
function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
echo "<button><a href='index.html'>ANOTHER REGISTRATION.</a></button>";
?>
