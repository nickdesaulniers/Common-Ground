window.addEventListener("load", initialize);

function initialize() {
  var canvas = document.getElementById("map_canvas");
  if (!canvas)
    return;

  var p = new google.maps.LatLng(document.getElementById("center_latitude").textContent,
                                 document.getElementById("center_longitude").textContent);
                                 var myOptions = {
    center: p,
    zoom: 1,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(canvas, myOptions);
  var marker = new google.maps.Marker({position: p, map: map});

  var latitudes = document.getElementsByClassName("latitude");
  var longitudes = document.getElementsByClassName("longitude");

  var latlng = [];
  for(var i = 0; i < latitudes.length; i++) {
    latlng.push(new google.maps.LatLng(latitudes[i].textContent, longitudes[i].textContent));
  }
  var latlngbounds = new google.maps.LatLngBounds();
  for (var i = 0; i < latlng.length; i++)
  {
    var marker = new google.maps.Marker({position: latlng[i], map: map});
    latlngbounds.extend(latlng[i]);
  }
  map.fitBounds(latlngbounds);
}
