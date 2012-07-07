function getPosition(shouldSpoof) {
  if (!shouldSpoof && !"geolocation" in navigator) {
    sendPosition([0, 0]);
  }
  if (shouldSpoof == "oakwood") {
    sendPosition([37.399541, -122.0723354]);
  } else if (shouldSpoof == "mvoffice") {
    sendPosition([37.3880897, -122.0828467]);
  } else if (shouldSpoof == "sfoffice") {
    sendPosition([37.7950783, -122.2651654]);
  } else if (shouldSpoof == "goldenbridge") {
    sendPosition([37.8072669, -122.4753915]);
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
