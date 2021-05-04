class FeatureCollectionPark {
  String type;
  List<Features> features;

  FeatureCollectionPark({this.type, this.features});

  factory FeatureCollectionPark.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['features'] as List;
    print(list.runtimeType);
    List<Features> featuresList =
        list.map((i) => Features.fromJson(i)).toList();

    return FeatureCollectionPark(
        type: parsedJson['type'], features: featuresList);
  }
}

class Features {
  String type;
  String id;
  GeometryPark geometry;

  Features({this.type, this.id, this.geometry});

  factory Features.fromJson(Map<String, dynamic> parsedJson) {
    return Features(
        type: parsedJson['type'],
        id: parsedJson['id'],
        geometry: GeometryPark.fromJson(parsedJson['geometry']));
  }
}

class GeometryPark {
  String type;
  //List<double> coordinates;
  List<List<List<double>>> coordinatesList;

  GeometryPark({this.type, this.coordinatesList});

  factory GeometryPark.fromJson(Map<String, dynamic> json) => GeometryPark(
        type: json["type"],
        coordinatesList: List<List<List<double>>>.from(json["coordinates"].map(
            (x) => List<List<double>>.from(
                x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
      );

  List<List<double>> getCoordinates() {
    return coordinatesList.expand((element) => element).toList();
  }

  /*factory GeometryPark.fromJson(Map<String, dynamic> parsedJson) {
    var coordinatesListOfLists = parsedJson['coordinates'] as List;

    List<double> list = coordinatesListOfLists
        .map((e) => e.map((e) => e.map((e) => e.toDouble())))
        .cast<double>();

    return new GeometryPark(type: parsedJson['type'], coordinates: list);
  }*/
}
