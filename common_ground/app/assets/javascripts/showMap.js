window.addEventListener("load", initialize);

function initialize() {
  var canvas = document.getElementById("map_canvas");
  if (!canvas)
    return;

  var p = new google.maps.LatLng(37.399541, -122.0723354);
  var myOptions = {
    center: p,
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(canvas, myOptions);
  var marker = new google.maps.Marker({position: p, map: map});
/*  // latlng: an array of instances of GLatLng
  var latlngbounds = new GLatLngBounds();
  for (var i = 0; i < latlng.length; i++)
  {
    var marker = new google.maps.Marker({position: latlng[i], map: map});
    latlngbounds.extend(latlng[i]);
  }
  map.setCenter(latlngbounds.getCenter(), map.getBoundsZoomLevel(latlngbounds));
*/}
