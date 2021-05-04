import 'package:http/http.dart';
import 'dart:convert';
import 'package:hund_pvt/JSON/parsejson.dart';
import 'package:hund_pvt/JSON/parsejsonpark.dart';
import 'package:sweden_crs_transformations_4dart/sweden_crs_transformations_4dart.dart';
//import 'package:hund_pvt/Pages/home.dart';

List<LocationTrash> getTrashCanList = [];
List<ParkLocation> getParksList = [];

Future getTrashCan() async {
  Response response = await get(Uri.parse(
      'https://openstreetgs.stockholm.se/geoservice/api/9f0bd873-30d2-40ad-99f3-7a32f115717f/wfs?request=GetFeature&typeName=od_gis:Skrapkorg_Punkt&outputFormat=JSON'));
  final jsonResponse = jsonDecode(response.body);

  FeatureCollection pin = new FeatureCollection.fromJson(jsonResponse);
  //Iterate through and convert coordinates
  print(pin.features.length);
  pin.features.forEach((element) {
    getTrashCanList.add(LocationTrash(
        wgs84: convertPoint(element.geometry.coordinateLat.toDouble(),
            element.geometry.coordinateLong.toDouble())));
  });
}

class LocationTrash {
  CrsCoordinate wgs84;

  LocationTrash({this.wgs84});

  CrsCoordinate getTrashCoordinate() {
    return wgs84;
  }
}

Future getPark() async {
  Response response = await get(Uri.parse(
      'https://openstreetgs.stockholm.se/geoservice/api/9f0bd873-30d2-40ad-99f3-7a32f115717f/wfs/?version=1.0.0&request=GetFeature&typeName=od_gis:Hundrastgard_Yta&outputFormat=JSON'));
  final jsonResponse = jsonDecode(response.body);
  FeatureCollectionPark pin = new FeatureCollectionPark.fromJson(jsonResponse);

  pin.features.forEach((element) {
    List<CrsCoordinate> lista = [];
    element.geometry.getCoordinates().forEach((cord) {
      lista.add(convertPoint(cord.elementAt(1), cord.elementAt(0)));
      getParksList.add(ParkLocation(wgs84Points: lista));
    });
  });
  //print(getParksList.first.wgs84Points);
}

//Iterate through and convert coordinates

CrsCoordinate convertPoint(double lat, double long) {
  CrsCoordinate sweref99 =
      CrsCoordinate.createCoordinate(CrsProjection.sweref_99_18_00, lat, long);

  CrsCoordinate wgs84 = sweref99.transform(CrsProjection.wgs84);

  return wgs84;
}

class ParkLocation {
  List<CrsCoordinate> wgs84Points;

  ParkLocation({this.wgs84Points});

  List getParkCoordinate() {
    return wgs84Points;
  }
}
