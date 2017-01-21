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
			scale : 60000,				/* 50000000 */
			zoom : 10,
			center : [ -122.3319525, 47.6061917 ]

		});
		
		var graphicsLayer = new GraphicsLayer();
		map.add(graphicsLayer);
		  
		var point = new Point({
		    latitude: 47.6061917,
		    longitude: -122.3319525
		  });
		
		var markerSymbol = new SimpleMarkerSymbol({
		    color: [226, 119, 40],
		    width: 2,
		    size: "auto",
		    style: "STYLE_DIAMOND",
		    type: "cartographiclinesymbol ",
		  });
		
		var pointAttribute = {
			    Name: "Keystone Pipeline",
			    Owner: "TransCanada",
			    Length: "3,456 km"
			  };
		
		 var pointGraphic = new Graphic({
			    geometry: point,
			    symbol: markerSymbol,
			    attributes: pointAttribute,
			    popupTemplate: new PopupTemplate({
			      title: "{Name}",
			      content: "{*}"		/* table format */
			    })
			  });
		 
		 graphicsLayer.add(pointGraphic);
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