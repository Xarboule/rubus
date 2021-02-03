<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>IIUN RaspberryPi cluster</title>
  </head>
  <body>
	<h1>IIUN Raspberry Pi Cluster</h1>

	<?php
	  // Update the state  
	  `/home/iiun/list-pi.sh > /var/www/html/pi-controller/cluster-state.txt`;

	  // Print the state line by line
	  $lines = file( "cluster-state.txt" );
	  foreach($lines as $line_num => $line){
	      echo htmlspecialchars($line) . "<br>\n";
	  }
	?>
  </body>
</html>
