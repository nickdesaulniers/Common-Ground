function findBestLocation(users, locations) {
  for (var i = 0; i < locations.length; i++) {
    var loc = locations[i];
    var totalSquareDistance = 0;
    for (var j = 0; j < users.length; j++) {
      totalSquareDistance += Math.pow((users[j].latitude - loc.latitude), 2)
                          +  Math.pow((user[j].longitutde - loc.longitude), 2);
    }
    loc.distance = totalSquareDistance;
  }

  locations.sort(function(a, b) {return a.distance - b.distance});
}
