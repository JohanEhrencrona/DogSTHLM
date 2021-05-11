import 'package:http/http.dart';
import 'dart:convert';
import 'package:hund_pvt/JSON/parsejson.dart';
import 'package:hund_pvt/JSON/parsejsonpark.dart';
import 'package:sweden_crs_transformations_4dart/sweden_crs_transformations_4dart.dart';
//import 'package:hund_pvt/Pages/home.dart';
import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';

List<LocationTrash> trashCanList = [];
List<ParkLocation> parksList = [];
List<CafeLocation> cafesList = [];
List<PetshopLocation> petshopsList = [];
List<RestaurantLocation> restaurantsList = [];

CrsCoordinate convertPoint(double lat, double long) {
  CrsCoordinate sweref99 =
      CrsCoordinate.createCoordinate(CrsProjection.sweref_99_18_00, lat, long);

  CrsCoordinate wgs84 = sweref99.transform(CrsProjection.wgs84);

  return wgs84;
}

//TRASHCAN///////////////////////////////////////////////////////////////////////////////
Future getTrashCan() async {
  Response response = await get(Uri.parse(
      'https://openstreetgs.stockholm.se/geoservice/api/9f0bd873-30d2-40ad-99f3-7a32f115717f/wfs?request=GetFeature&typeName=od_gis:Skrapkorg_Punkt&outputFormat=JSON'));
  final jsonResponse = jsonDecode(response.body);

  FeatureCollection pin = new FeatureCollection.fromJson(jsonResponse);
  //Iterate through and convert coordinates
  print(pin.features.length);
  pin.features.forEach((element) {
    trashCanList.add(LocationTrash(
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
//TRASHCAN///////////////////////////////////////////////////////////////////////////////

//DOGPARKS///////////////////////////////////////////////////////////////////////////////
Future getPark() async {
  Response response = await get(Uri.parse(
      'https://openstreetgs.stockholm.se/geoservice/api/9f0bd873-30d2-40ad-99f3-7a32f115717f/wfs/?version=1.0.0&request=GetFeature&typeName=od_gis:Hundrastgard_Yta&outputFormat=JSON'));
  final jsonResponse = jsonDecode(response.body);
  FeatureCollectionPark pin = new FeatureCollectionPark.fromJson(jsonResponse);

  pin.features.forEach((element) {
    List<CrsCoordinate> lista = [];
    element.geometry.getCoordinates().forEach((cord) {
      lista.add(convertPoint(cord.elementAt(1), cord.elementAt(0)));
      parksList.add(ParkLocation(wgs84Points: lista));
    });
  });
  //print(getParksList.first.wgs84Points);
}

class ParkLocation {
  List<CrsCoordinate> wgs84Points;

  ParkLocation({this.wgs84Points});

  List getParkCoordinate() {
    return wgs84Points;
  }
}
//DOGPARKS///////////////////////////////////////////////////////////////////////////////

//CAFES///////////////////////////////////////////////////////////////////////////////
Future getCafes() async {
  Response response = await get(Uri.parse(
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/cafes/.json'));
  final jsonResponse = jsonDecode(response.body);
  final Map<String, dynamic> data = jsonResponse;
  data.forEach((key, value) {
    Cafe cafe = Cafe.fromJson(value);
    cafesList.add(CafeLocation(
        adress: cafe.adress,
        latitude: cafe.latitude,
        longitude: cafe.longitude,
        name: cafe.name));
  });
}

class CafeLocation {
  String adress;
  double latitude;
  double longitude;
  String name;

  CafeLocation({this.adress, this.latitude, this.longitude, this.name});
}
//CAFES///////////////////////////////////////////////////////////////////////////////

//PETSHOPS///////////////////////////////////////////////////////////////////////////////

Future getPetshops() async {
  Response response = await get(Uri.parse(
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/petshops/.json'));
  final jsonResponse = jsonDecode(response.body);
  final Map<String, dynamic> data = jsonResponse;
  data.forEach((key, value) {
    Petshop petshop = Petshop.fromJson(value);
    petshopsList.add(PetshopLocation(
        adress: petshop.adress,
        latitude: petshop.latitude,
        longitude: petshop.longitude,
        name: petshop.name));
  });
}

class PetshopLocation {
  String adress;
  double latitude;
  double longitude;
  String name;

  PetshopLocation({this.adress, this.latitude, this.longitude, this.name});
}

//PETSHOPS///////////////////////////////////////////////////////////////////////////////

/*
! -------------------------------------RESTAURANTS-----------------------------------------
*/
Future getRestaurants() async {
  Response response = await get(Uri.parse(
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/restaurants/.json'));
  final jsonResponse = jsonDecode(response.body);
  final Map<String, dynamic> data = jsonResponse;
  data.forEach((key, value) {
    Restaurant restaurant = Restaurant.fromJson(value);
    restaurantsList.add(RestaurantLocation(
        adress: restaurant.adress,
        latitude: restaurant.latitude,
        longitude: restaurant.longitude,
        name: restaurant.name));
  });
}

class RestaurantLocation {
  String adress;
  double latitude;
  double longitude;
  String name;

  RestaurantLocation({this.adress, this.latitude, this.longitude, this.name});
}

/*
! -------------------------------------RESTAURANTS-----------------------------------------
*/