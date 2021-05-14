class LocationsFromDatabase {
  String adress;
  double latitude;
  double longitude;
  String name;

  LocationsFromDatabase(
      {this.adress, this.latitude, this.longitude, this.name});

  factory LocationsFromDatabase.fromJson(Map<String, dynamic> parsedJson) {
    return LocationsFromDatabase(
        adress: parsedJson['Adress'],
        latitude: parsedJson['latitude'],
        longitude: parsedJson['longitude'],
        name: parsedJson['Namn']);
  }

  Map<String, dynamic> toJson() => {
        "Adress": adress,
        "latitude": latitude,
        "longitude": longitude,
        "Namn": name,
      };
}
