<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Seattle Crime Analysis</title>
<link rel="icon" type="image/png" href="resources/images/tab_icon.png" sizes="16x16">

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
</style>

<!-- ArcGIS API for JavaScript -->
<link rel="stylesheet" href="https://js.arcgis.com/4.0/esri/css/main.css">
<script src="https://js.arcgis.com/4.0/"></script>

<script>
	require([ "esri/Map", "esri/views/SceneView", "dojo/domReady!" ], function(
			Map, SceneView) {
		var map = new Map({
			basemap : "osm", /* satellite, hybrid, topo, gray, dark-gray, oceans, osm, national-geographic */
			ground : "world-elevation"
		});
		var view = new SceneView({
			container : "viewDiv", // Reference to the scene div created in step 5
			map : map, // Reference to the map object created before the scene
			scale : 50000000, // Sets the initial scale to 1:50,000,000
			zoom: 1,
			center : [ -122.3319525, 47.6061917 ] // Sets the center point of view with lon/lat

		});
	});
</script>

</head>
<body>
	<div id="viewDiv">
		<div id="sidebar">
			<div id="text">
				<h1>Liberty Island</h1>
				<p>Note that setting the view.padding makes the view.center,
					view.extent etc work off a subsection of the full view.</p>
				<p>Try to resize the window to get a better understanding.</p>
			</div>
		</div>
	</div>
</body>
</html>