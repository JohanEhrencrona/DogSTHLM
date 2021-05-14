class Cafe {
  String adress;
  double latitude;
  double longitude;
  String name;

  Cafe({this.adress, this.latitude, this.longitude, this.name});

  factory Cafe.fromJson(Map<String, dynamic> parsedJson) {
    return Cafe(
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

class Petshop {
  String adress;
  double latitude;
  double longitude;
  String name;

  Petshop({this.adress, this.latitude, this.longitude, this.name});

  factory Petshop.fromJson(Map<String, dynamic> parsedJson) {
    return Petshop(
        adress: parsedJson['Adress'],
        latitude: parsedJson['latitude'],
        longitude: parsedJson['longitude'],
        name: parsedJson['Namn']);
  }
}

class Restaurant {
  String adress;
  double latitude;
  double longitude;
  String name;

  Restaurant({this.adress, this.latitude, this.longitude, this.name});

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) {
    return Restaurant(
        adress: parsedJson['Adress'],
        latitude: parsedJson['latitude'],
        longitude: parsedJson['longitude'],
        name: parsedJson['Namn']);
  }
}
