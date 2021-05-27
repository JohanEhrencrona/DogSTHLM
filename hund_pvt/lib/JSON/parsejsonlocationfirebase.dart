import 'package:hund_pvt/Services/userswithdogs.dart';

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
      return LocationsFromDatabase(
        adress: parsedJson['Adress'],
        latitude: parsedJson['latitude'],
        longitude: parsedJson['longitude'],
        name: parsedJson['Namn'],
        reviews: Map<String, int>.from(parsedJson['Reviews']),
      );
    } else {
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

class CheckInParkLocation {
  String name;
  List<Dog> dogsCheckedIn = [];

  CheckInParkLocation({this.name, this.dogsCheckedIn});

  factory CheckInParkLocation.fromJson(Map<String, dynamic> parsedJson) {
    var dogs = parsedJson['dogscheckedin'] as List;
    List<Dog> dogsinpark = dogs.map((e) => Dog.fromJson(e)).toList();

    return CheckInParkLocation(
      name: parsedJson['name'],
      dogsCheckedIn: dogsinpark,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "dogscheckedin":
            List<dynamic>.from(dogsCheckedIn.map((e) => e.toJson())),
      };
}

/* class DogsInPark {
  String name;
  String race;
  int age;

  DogsInPark({this.name, this.race, this.age});

  factory DogsInPark.fromJson(Map<String, dynamic> parsedJson) {
    return DogsInPark(
      name: parsedJson['name'],
      race: parsedJson['race'],
      age: int.parse(parsedJson['age']),
    );
  }
} */
