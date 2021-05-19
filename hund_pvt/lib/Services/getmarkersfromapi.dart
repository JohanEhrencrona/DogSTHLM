import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hund_pvt/JSON/parsejson.dart';
import 'package:hund_pvt/JSON/parsejsonpark.dart';
import 'package:sweden_crs_transformations_4dart/sweden_crs_transformations_4dart.dart';
import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Services/markersets.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

List<LocationTrash> trashCanList = [];
List<LocationPark> parksList = [];
List<Locations> cafeList = [];
List<Locations> restaurantList = [];
List<Locations> petshopList = [];
List<Locations> vetsList = [];
List<Locations> favoriteList = [];

CrsCoordinate convertPoint(double lat, double long) {
  return CrsCoordinate.createCoordinate(
          CrsProjection.sweref_99_18_00, lat, long)
      .transform(CrsProjection.wgs84);
}

class Locations {
  String adress;
  double latitude;
  double longitude;
  String name;
  bool fav = false;

  Locations({this.adress, this.latitude, this.longitude, this.name});

  void setFavorite() {
    fav = true;
  }

  void unFavorite() {
    fav = false;
  }

  @override
  bool operator ==(other) {
    return (other is Locations) &&
        other.name == name &&
        other.adress == adress &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

//TRASHCAN///////////////////////////////////////////////////////////////////////////////
Future getTrashCan() async {
  http.Response response = await http.get(Uri.parse(
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

void createTrashMarkers() {
  trashCanList.forEach((element) {
    addTrashMarkersClusters(element.wgs84.yLatitude, element.wgs84.xLongitude);
  });
}

class LocationTrash {
  CrsCoordinate wgs84;

  LocationTrash({this.wgs84});

  CrsCoordinate getTrashCoordinate() {
    return wgs84;
  }
}

void markFavoritesInLists(List list) {
  print('inne i markfavoritesinlists');
  Locations loc;
  list.forEach((fav) {
    if (cafeList.contains(fav)) {
      loc = (cafeList.singleWhere((element) => element.name == fav.name));
      loc.setFavorite();
    } else if (restaurantList.contains(fav)) {
      print('inne i rest');
      loc = (restaurantList.singleWhere((element) => element.name == fav.name));
      loc.setFavorite();
    } else if (petshopList.contains(fav)) {
      print('inne i petshop');
      loc = (petshopList.singleWhere((element) => element.name == fav.name));
      loc.setFavorite();
    } else if (vetsList.contains(fav)) {
      loc = (vetsList.singleWhere((element) => element.name == fav.name));
      loc.setFavorite();
    }
  });
}

Future getFavorites() async {
  http.Response response = await http.get(Uri.parse(
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/favorites/${auth.currentUser.uid}/.json'));
  if (response.body != 'null') {
    print('inne i if');
    return favoriteList =
        locationListGenerator(Map.from(jsonDecode(response.body)));
  } else {
    print('inne i else');
    return;
  }
}

Future<http.Response> postFavorite(LocationsFromDatabase favorite) {
  String url =
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/favorites/${auth.currentUser.uid}/.json';
  final Map<String, dynamic> data = {favorite.name: favorite.toJson()};
  String json = jsonEncode(data);

  return http.patch(Uri.parse(url), body: json);
}

Future<http.Response> removeFavorite(LocationsFromDatabase favorite) {
  String url =
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/favorites/${auth.currentUser.uid}/${favorite.name}.json';
  final Map<String, dynamic> data = {favorite.name: favorite.toJson()};
  String json = jsonEncode(data);

  return http.delete(Uri.parse(url), body: json);
}
//TRASHCAN///////////////////////////////////////////////////////////////////////////////

//DOGPARKS///////////////////////////////////////////////////////////////////////////////
Future getPark() async {
  http.Response response = await http.get(Uri.parse(
      'https://openstreetgs.stockholm.se/geoservice/api/9f0bd873-30d2-40ad-99f3-7a32f115717f/wfs/?version=1.0.0&request=GetFeature&typeName=od_gis:Hundrastgard_Yta&outputFormat=JSON'));
  final jsonResponse = jsonDecode(response.body);
  FeatureCollectionPark pin = new FeatureCollectionPark.fromJson(jsonResponse);
  //Iterate through and convert coordinates
  pin.features.forEach((element) {
    List<CrsCoordinate> lista = [];
    element.geometry.getCoordinates().forEach((cord) {
      lista.add(convertPoint(cord.elementAt(1), cord.elementAt(0)));
      parksList.add(LocationPark(wgs84Points: lista));
    });
  });
}

void createParkMarkers() {
  parksList.forEach((element) {
    List<LatLng> coord = [];
    element.wgs84Points.forEach((element) {
      coord.add(LatLng(element.yLatitude, element.xLongitude));
    });
    addParkPolygons(coord);
  });
}

class LocationPark {
  List<CrsCoordinate> wgs84Points;

  LocationPark({this.wgs84Points});

  List getParkCoordinate() {
    return wgs84Points;
  }
}
//DOGPARKS///////////////////////////////////////////////////////////////////////////////

List<Locations> locationListGenerator(Map data) {
  List<Locations> list = [];
  data.forEach((key, value) {
    LocationsFromDatabase locationObject =
        LocationsFromDatabase.fromJson(value);
    list.add(Locations(
        adress: locationObject.adress,
        latitude: locationObject.latitude,
        longitude: locationObject.longitude,
        name: locationObject.name));
  });
  return list;
}

//CAFES///////////////////////////////////////////////////////////////////////////////
Future getCafes() async {
  return await http
      .get(Uri.parse(
          'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/cafes/.json'))
      .then((response) => Map.from(jsonDecode(response.body)))
      .then((data) => cafeList = locationListGenerator(data));

  /* return await http
      .get(Uri.parse(
          'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/cafes/.json'))
      .then((response) => cafeList =
          locationListGenerator(Map.from(jsonDecode(response.body)))); */
}

Future<http.Response> postCafes(LocationsFromDatabase cafe) {
  String url =
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/cafes/.json';
  final Map<String, dynamic> data = {cafe.name: cafe.toJson()};
  var body = data;
  print(body);
  String json = jsonEncode(data);
  print(json);

  return http.patch(Uri.parse(url), body: json);
}
//CAFES///////////////////////////////////////////////////////////////////////////////

//PETSHOPS///////////////////////////////////////////////////////////////////////////////

Future getPetshops() async {
  return await http
      .get(Uri.parse(
          'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/petshops/.json'))
      .then((response) => Map.from(jsonDecode(response.body)))
      .then((data) => petshopList = locationListGenerator(data));
}

Future<http.Response> postPetShops(LocationsFromDatabase petshop) {
  String url =
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/petshops/.json';
  final Map<String, dynamic> data = {petshop.name: petshop.toJson()};
  var body = data;
  print(body);
  String json = jsonEncode(data);
  print(json);

  return http.patch(Uri.parse(url), body: json);
}

//PETSHOPS///////////////////////////////////////////////////////////////////////////////

/*
! -------------------------------------RESTAURANTS-----------------------------------------
*/
Future getRestaurants() async {
  return await http
      .get(Uri.parse(
          'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/restaurants/.json'))
      .then((response) => Map.from(jsonDecode(response.body)))
      .then((data) => restaurantList = locationListGenerator(data));
}

Future<http.Response> postRestaurant(LocationsFromDatabase restaurant) {
  String url =
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/restaurants/.json';
  final Map<String, dynamic> data = {restaurant.name: restaurant.toJson()};
  var body = data;
  print(body);
  String json = jsonEncode(data);
  print(json);

  return http.patch(Uri.parse(url), body: json);
}
/*
! -------------------------------------RESTAURANTS-----------------------------------------
*/

/*
! -------------------------------------VETS-----------------------------------------
*/
Future getVets() async {
  return await http
      .get(Uri.parse(
          'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/vets/.json'))
      .then((response) => Map.from(jsonDecode(response.body)))
      .then((data) => vetsList = locationListGenerator(data));
}


/*
! -------------------------------------VETS-----------------------------------------
*/