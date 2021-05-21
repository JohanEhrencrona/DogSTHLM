class LocationsFromDatabase {
  String adress;
  double latitude;
  double longitude;
  String name;
  /* List<int> points;
  List<String> reviews; */
  Map<String, int> reviews = {};

  LocationsFromDatabase({
    this.adress,
    this.latitude,
    this.longitude,
    this.name,
    this.reviews,
  });

  factory LocationsFromDatabase.fromJson(Map<String, dynamic> parsedJson) {
    String parsed = parsedJson.toString();
    if (parsed.contains('Reviews')) {
      print('true');
      return LocationsFromDatabase(
        adress: parsedJson['Adress'],
        latitude: parsedJson['latitude'],
        longitude: parsedJson['longitude'],
        name: parsedJson['Namn'],
        reviews: Map<String, int>.from(parsedJson['Reviews']),
      );
    } else {
      print('not found');
      return LocationsFromDatabase(
        adress: parsedJson['Adress'],
        latitude: parsedJson['latitude'],
        longitude: parsedJson['longitude'],
        name: parsedJson['Namn'],
        reviews: Map<String, int>(),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "Adress": adress,
        "latitude": latitude,
        "longitude": longitude,
        "Namn": name,
        "Review": reviews,
      };
}
