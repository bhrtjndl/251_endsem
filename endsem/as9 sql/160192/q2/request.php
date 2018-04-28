<?php

// define variables and set to empty values
$name = $email = $address=$number=$backaccount=$Password="";
$db = new SQLite3('data');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["Name"]);
  $address=test_input($_POST["address"]);
  $email = test_input($_POST["email"]);
  $number = test_input($_POST["Number"]);
  $bankaccount = test_input($_POST["bankacc"]);
  $Password = test_input($_POST["Password"]);
  $qstr="SELECT * FROM records WHERE EMAIL='".$email."';";
  $insres=$db->query($qstr);
  if($insres->fetchArray(SQLITE3_ASSOC))
	echo "User already exists.";
  else{
	$query="SELECT BALANCE FROM accounts WHERE ACCOUNT=".$bankaccount." AND PASSWORD='".$Password."' AND BALANCE>=1000;";
	$result=$db->query($query);
	if($row=$result->fetchArray()){
	  $db->query("UPDATE accounts SET BALANCE=".$row[0]."-1000 WHERE ACCOUNT=".$bankaccount.";");
	  $qstr = "insert into records(NAME,ADDRESS,EMAIL,NUMBER,ACCOUNT,PASSWORD) values ('$name', '$address', '$email', '$number', '$bankaccount','$Password')";
	  $insres = $db->query($qstr);
	  echo "Registration successful for ".$name.".";
	}
	else{
	  echo "Insufficient Balance";
	}
  }
}
function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
echo "<br><button><a href='index.html'>ANOTHER REGISTRATION.</a></button>";
?>
