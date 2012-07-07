function getPosition(shouldSpoof) {
  if (shouldSpoof || !"geolocation" in navigator) {
    sendPosition([100, 100]);
  }

  navigator.geolocation.getCurrentPosition(updatePosition);
  navigator.geolocation.watchPosition(updatePosition);
}

function updatePosition(aPosition) {
  sendPosition([aPosition.coords.latitude, aPosition.coords.longitude]);
}

function sendPosition(aPosition) {
  var user_id = localStorage.getItem("user_id");
  $.post("http://localhost:3000/users/"+user_id, { location: { latitude: aPosition[0], longitude: aPosition[1] } } );
}

$(document).ready(function() {
  getPosition(false);
});
