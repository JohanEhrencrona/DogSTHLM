class FeatureCollection {
  String type;
  List<Features> features;

  FeatureCollection({this.type, this.features});

  factory FeatureCollection.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['features'] as List;
    print(list.runtimeType);
    List<Features> featuresList =
        list.map((i) => Features.fromJson(i)).toList();

    return FeatureCollection(type: parsedJson['type'], features: featuresList);
  }
}

class Features {
  String type;
  String id;
  GeometryTrash geometry;

  Features({this.type, this.id, this.geometry});

  factory Features.fromJson(Map<String, dynamic> parsedJson) {
    return Features(
        type: parsedJson['type'],
        id: parsedJson['id'],
        geometry: GeometryTrash.fromJson(parsedJson['geometry']));
  }
}

class GeometryTrash {
  String type;
  num coordinateLat;
  num coordinateLong;
  //Contructor
  GeometryTrash({this.type, this.coordinateLat, this.coordinateLong});

  factory GeometryTrash.fromJson(Map<String, dynamic> parsedJson) {
    var coordinatesFromJson = parsedJson['coordinates'];

    List<num> coordinatesList = coordinatesFromJson.cast<num>();

    return new GeometryTrash(
        type: parsedJson['type'],
        coordinateLong: coordinatesList.first,
        coordinateLat: coordinatesList[1]);
  }
}
