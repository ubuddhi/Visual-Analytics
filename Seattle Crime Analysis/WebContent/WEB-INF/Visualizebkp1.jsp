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

<!-- ArcGIS API for JavaScript -->
<link rel="stylesheet" href="https://js.arcgis.com/4.0/esri/css/main.css">
<script src="https://js.arcgis.com/4.0/"></script>
</head>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
<body style="width: 100%">
	<div style="width: 30%; margin-left: auto; margin-right: auto">
	
		<p style="text-align: center; font-size: 250%; font-weight: bold; margin-top: 20px" >SEATTLE CRIME ANALYSIS </p>
		<form name="gettrends" accept-charset="UTF-8"
			action="/SeattleCrimeAnalysis/submitForm" method="post">
			 

			<div style="text-align: center;" class="padding-top">
				<font color="red"><h2>${displayContent}</h2></font>
			</div>
			
			<div style="text-align: center;" class="padding-top">
				<p style="display: inline-block;width: 25%">Crime Type</p>
				<select name="crimeType" id="crimeType" style="text-align: center;width: 200px">
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
			
			<div style="text-align: center;" class="padding-top"> 
				<p  style="display: inline-block; width: 25%">Year</p>
				<select name="year" id="year" style="text-align: center;width: 200px">
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
			
			

			
				<div class="padding-top" style="text-align: center;">
					<button class= "btn" type="submit">
						<span>Visualize</span>
					</button>
				</div>
			
		</form>
	</div>
	
	<div style="text-align: center;" class="padding-top">
		<font color="red"><h2>${trendTitle}</h2></font>
	</div>
	
	<div id="viz">
	</div>

 	<div id="viewDiv">
<!--  		<div id="sidebar">
			<div id="text">
				<h1>Liberty Island</h1>
				<p>Note that setting the view.padding makes the view.center,
					view.extent etc work off a subsection of the full view.</p>
				<p>Try to resize the window to get a better understanding.</p>
			</div>
		</div> -->
	</div>  

</body>

<script>
  var json_trend = ${jsonTrend};

  var visualization = d3plus.viz()
    .container("#viz")  
    .data(json_trend)  
    .type("line")       
    .id("crimetype")         
    .text("crimetype")       
    .y("numberofcrimes")         
    .x("timeline")          
    .draw();
</script>


<script>
	require([ "esri/Map", "esri/views/SceneView", "esri/layers/GraphicsLayer",
			"esri/geometry/Point", "esri/symbols/SimpleMarkerSymbol",
			"esri/Graphic", "esri/PopupTemplate", "dojo/domReady!" ], function(
			Map, SceneView, GraphicsLayer, Point, SimpleMarkerSymbol, Graphic,
			PopupTemplate) {
		var map = new Map({
			basemap : "osm", /* satellite, hybrid, topo, gray, dark-gray, oceans, osm, national-geographic */
			ground : "world-elevation"
		});
		var view = new SceneView({
			container : "viewDiv",
			map : map,
			scale : 50000000, /* 50000000 */
			zoom : 10,
			center : [ -122.3319525, 47.6061917 ]

		});

		var graphicsLayer = new GraphicsLayer();
		map.add(graphicsLayer);
		
		var map_list = ${mapList};

		
		
		var point = new Point({
			latitude : 47.6061917,
			longitude : -122.3319525
		});

		var markerSymbol = new SimpleMarkerSymbol({
			color : [ 226, 119, 40 ],
			width : 2,
			size : "auto",
			style : "STYLE_DIAMOND",
			type : "cartographiclinesymbol ",
		});

		var pointAttribute = {
			Name : "Keystone Pipeline",
			Owner : "TransCanada",
			Length : "3,456 km"
		};

		var pointGraphic = new Graphic({
			geometry : point,
			symbol : markerSymbol,
			attributes : pointAttribute,
			popupTemplate : new PopupTemplate({
				title : "{Name}",
				content : "{*}" /* table format */
			})
		});

		graphicsLayer.add(pointGraphic);
	});
</script>

<style>
html, body, #viewDiv {
	padding: 0;
	margin: 0;
	height: 100%;
	width: 100%;
}

#sidebar {
	z-index: 99;
	position: absolute;
	top: 0;
	right: 0;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	width: 320px;
}

#text {
	color: white;
	padding: 3%;
}

select {
    padding:3px;
    margin: 0;
    -webkit-border-radius:4px;
    -moz-border-radius:4px;
    border-radius:4px;
    -webkit-box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
    -moz-box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
    box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
    background: #f8f8f8;
    color:#888;
    border:none;
    outline:none;
    display: inline-block;
    -webkit-appearance:none;
    -moz-appearance:none;
    appearance:none;
    cursor:pointer;
}

.padding-top
{
	padding-top: 10px;
}

select option
{
	text-align: center;
}

.btn {
  background: #34c0d9;
  background-image: -webkit-linear-gradient(top, #34c0d9, #4a5b66);
  background-image: -moz-linear-gradient(top, #34c0d9, #4a5b66);
  background-image: -ms-linear-gradient(top, #34c0d9, #4a5b66);
  background-image: -o-linear-gradient(top, #34c0d9, #4a5b66);
  background-image: linear-gradient(to bottom, #34c0d9, #4a5b66);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  -webkit-box-shadow: 3px 2px 3px #a3a1a3;
  -moz-box-shadow: 3px 2px 3px #a3a1a3;
  box-shadow: 3px 2px 3px #a3a1a3;
  font-family: Arial;
  color: #ffffff;
  font-size: 15px;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  text-decoration: none;
}
</style>

</html>