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
  $.post("page", { latitude: arr[0], longitude: arr[1] } );
}

