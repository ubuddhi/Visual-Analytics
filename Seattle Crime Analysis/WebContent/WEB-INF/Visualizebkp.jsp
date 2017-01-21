<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Seattle Crime Analysis</title>
<link rel="icon" type="image/png" href="resources/images/tab_icon.png"
	sizes="16x16">
<!-- load D3js -->
<script src="http://www.d3plus.org/js/d3.js"></script>
<!-- load D3plus after D3js -->
<script src="http://www.d3plus.org/js/d3plus.js"></script>
</head>
<body>
	<div>
		<form name="gettrends" accept-charset="UTF-8"
			action="/SeattleCrimeAnalysis/submitForm" method="post">
			<font color="red"><h2>${displayContent}</h2></font> <br> <br>

			<div>
				<select name="crimeType" id="crimeType">
					<option name="please_select" value="please_select">Select</option>
					<option name="ALL CRIMES" value="ALL CRIMES">ALL CRIMES</option>
					<option name="ARMED ROBBERY" value="ARMED ROBBERY">ARMED ROBBERY</option>
					<option name="ASSAULTS, GANG RELATED" value="ASSAULTS, GANG RELATED">ASSAULTS, GANG RELATED</option>
					<option name="AUTO THEFT" value="AUTO THEFT">AUTO THEFT</option>
					<option name="BICYCLE THEFT" value="BICYCLE THEFT">BICYCLE THEFT</option>
					<option name="BURGLARY - RESIDENTIAL, OCCUPIED" value="BURGLARY - RESIDENTIAL, OCCUPIED">BURGLARY - RESIDENTIAL, OCCUPIED</option>
					<option name="BURGLARY - RESIDENTIAL, UNOCCUPIED" value="BURGLARY - RESIDENTIAL, UNOCCUPIED">BURGLARY - RESIDENTIAL, UNOCCUPIED</option>
					<option name="GAMBLING" value="GAMBLING">GAMBLING</option>
					<option name="LIQUOR VIOLATION - ADULT" value="LIQUOR VIOLATION - ADULT">LIQUOR VIOLATION - ADULT</option>
				</select>
			</div>

			<div>
				<select name="year" id="year">
					<option name="please_select" value="please_select">Select</option>
					<option name="All Years" value="All Years">All Years</option>
					<option name="2010" value="2010">2010</option>
					<option name="2011" value="2011">2011</option>
					<option name="2012" value="2012">2012</option>
					<option name="2013" value="2013">2013</option>
					<option name="2014" value="2014">2014</option>
					<option name="2015" value="2015">2015</option>
					<option name="2016" value="2016">2016</option>
				</select>
			</div>

			<div>
				<div>
					<button type="submit">
						<span>Visualize</span>
					</button>
				</div>
			</div>
		</form>
	</div>
	
	<font color="red"><h2>${trendTitle}</h2></font> <br> <br>
	
	<div id="viz"></div>
	
</body>

<script>
  var json_trend = ${jsonTrend}
  var visualization = d3plus.viz()
    .container("#viz")  
    .data(json_trend)  
    .type("line")       
    .id("crimetype")         
    .text("crimetype")       
    .y("numberofcrimes")         
    .x("timeline")          
    .draw()             
</script>

</html>