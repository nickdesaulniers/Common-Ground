$(document).ready(function() {
  console.log("got here");
  setInterval(updateRoom, 5000);
});

function updateRoom() {

  var room = $('#room_id').val();
  console.log(room);
  $.ajax({
    type: "GET",
    url: "http://localhost:3000/rooms/"+room,
    dataType: "json",
    success: function(data) {
      var response = jQuery.parseJSON(data);
      
      for (var i=0; i<response.length; i++) {
        $(response.user.email).html("<div>"+response.user.email+"<div class='latitude'>"+response.user.location.latitude+"</div><div class='longitude'>"+response.user.location.longitude+"</div></div>");
      }
    }
  });

};
