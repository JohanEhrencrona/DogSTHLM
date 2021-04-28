import 'package:http/http.dart';
import 'dart:convert';
import 'package:hund_pvt/JSON/trashmarkers.dart';
import 'package:hund_pvt/Services/mapstest.dart';
import 'package:hund_pvt/maps.dart';
import 'package:sweden_crs_transformations_4dart/sweden_crs_transformations_4dart.dart';

//List<LocationTrash> trashList;
List<LocationTrash> getTrashCanList = [];

Future getTrashCan() async {
  Response response = await get(Uri.parse(
      'https://openstreetgs.stockholm.se/geoservice/api/9f0bd873-30d2-40ad-99f3-7a32f115717f/wfs?request=GetFeature&typeName=od_gis:Skrapkorg_Punkt&outputFormat=JSON'));
  final jsonResponse = jsonDecode(response.body);

  FeatureCollection pin = new FeatureCollection.fromJson(jsonResponse);
  //Iterate through
  print(pin.features.length);
  pin.features.forEach((element) {
    getTrashCanList.add(LocationTrash(
        lats: element.geometry.coordinateLat,
        long: element.geometry.coordinateLong));
  });

  double ogLat = pin.features[0].geometry.coordinateLat;
  double ogLong = pin.features[0].geometry.coordinateLong;

  /*Response convert = await get(Uri.parse(
      "https://openstreetws.stockholm.se/LvWS-3.0/Lv.svc/json/TransformGeometry?apikey=9f0bd873-30d2-40ad-99f3-7a32f115717f&wkt=POINT($ogLat+$ogLong)&fromSrid=3011&toSrid=900913"));

  String points = convert.body.toString();
  String longs = points.substring(8, 18);
  String lats = points.substring(19, 29);
  double longsDouble = double.parse(longs);
  double latsDouble = double.parse(lats);*/
}

class LocationTrash {
  num lats;
  num long;

  LocationTrash({this.lats, this.long});

  double getTrashLats() {
    return lats;
  }

  double getTrashLong() {
    return long;
  }
}
