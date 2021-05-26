import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hund_pvt/JSON/parsejson.dart';
import 'package:hund_pvt/JSON/parsejsonpark.dart';
import 'package:hund_pvt/Services/userswithdogs.dart';
import 'package:sweden_crs_transformations_4dart/sweden_crs_transformations_4dart.dart';
import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Services/markersets.dart';

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

List<LocationTrash> trashCanList = [];
List<LocationPark> parksList = [];
List<Locations> cafeList = [];
List<Locations> restaurantList = [];
List<Locations> petshopList = [];
List<Locations> vetsList = [];
List<Locations> favoriteList = [];

enum listType { cafe, petshop, restaurant, vets }

class Locations {
  var whitePaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    width: 18,
    height: 18,
    fit: BoxFit.cover,
    color: Colors.white,
  );
  var darkPaw = Image.asset(
    'assets/images/dark-paw_symbol.png',
    width: 18,
    height: 18,
    fit: BoxFit.cover,
  );
  var secondPaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    width: 18,
    height: 18,
    fit: BoxFit.cover,
    color: Colors.white,
  );
  var thirdPaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    width: 18,
    height: 18,
    fit: BoxFit.cover,
    color: Colors.white,
  );
  var fourthPaw = Image.asset(
    'assets/images/dark-paw_symbol.png',
    width: 18,
    height: 18,
    fit: BoxFit.cover,
  );
  var fifthPaw = Image.asset(
    'assets/images/dark-paw_symbol.png',
    width: 18,
    height: 18,
    fit: BoxFit.cover,
  );

  String adress;
  double latitude;
  double longitude;
  String name;
  String type;
  bool fav = false;
  Map<String, int> reviewsandpoints = {};

  Locations({
    this.adress,
    this.latitude,
    this.longitude,
    this.name,
    this.reviewsandpoints,
    this.type,
  });

  void setFavorite() {
    fav = true;
  }

  void unFavorite() {
    fav = false;
  }

  void addReviewAndPoints(String review, int point) {
    reviewsandpoints.putIfAbsent(review, () => point);
  }

  double getPoints() {
    int returnValue = 0;

    reviewsandpoints.forEach((key, value) {
      returnValue += value;
    });
    return returnValue / reviewsandpoints.length;
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

  Image getFirstPaw() {
    return whitePaw;
  }

  Image getSecondPaw() {
    return secondPaw;
  }

  Image getThirdPaw() {
    return thirdPaw;
  }

  Image getFourthPaw() {
    return fourthPaw;
  }

  Image getFifthPaw() {
    return fifthPaw;
  }

  void setInfoPaws(double points) {
    if (points <= 1.5) {
      secondPaw = darkPaw;
      thirdPaw = darkPaw;
      fourthPaw = darkPaw;
      fifthPaw = darkPaw;
    }
    if (points > 1.5 && points <= 2.5) {
      secondPaw = whitePaw;
      thirdPaw = darkPaw;
      fourthPaw = darkPaw;
      fifthPaw = darkPaw;
    }
    if (points > 2.5 && points <= 3.5) {
      secondPaw = whitePaw;
      thirdPaw = whitePaw;
      fourthPaw = darkPaw;
      fifthPaw = darkPaw;
    }
    if (points > 3.5 && points <= 4.5) {
      secondPaw = whitePaw;
      thirdPaw = whitePaw;
      fourthPaw = whitePaw;
      fifthPaw = darkPaw;
    }
    if (points > 4.5) {
      secondPaw = whitePaw;
      thirdPaw = whitePaw;
      fourthPaw = whitePaw;
      fifthPaw = whitePaw;
    }
  }
}

class LocationTrash {
  CrsCoordinate wgs84;

  LocationTrash({this.wgs84});

  CrsCoordinate getTrashCoordinate() {
    return wgs84;
  }
}

class LocationPark {
  String name;
  double latitude;
  double longitude;
  List<CrsCoordinate> wgs84Points;
  String type;
  bool fav = false;

  List<Dog> dogsInPark = [];

  LocationPark({this.name, this.latitude, this.longitude, this.wgs84Points});

  List getParkCoordinate() {
    return wgs84Points;
  }

  void setFavorite() {
    fav = true;
  }

  void unFavorite() {
    fav = false;
  }

  void addList(List list) {
    dogsInPark = list;
  }

  String getDogs() {
    String names = '';
    if (dogsInPark.isEmpty) {
      return names;
    } else
      dogsInPark.forEach((element) {
        names += element.name + ', ';
      });

    return names;
  }
}

CheckInParkLocation createTempParkForRemovingOrAddingFireBase(
    LocationPark park) {
  return CheckInParkLocation(name: park.name, dogsCheckedIn: park.dogsInPark);
}

CrsCoordinate convertPoint(double lat, double long) {
  return CrsCoordinate.createCoordinate(
          CrsProjection.sweref_99_18_00, lat, long)
      .transform(CrsProjection.wgs84);
}

void createTrashMarkers() {
  trashCanList.forEach((element) {
    addTrashMarkersClusters(element.wgs84.yLatitude, element.wgs84.xLongitude);
  });
}

void markFavoritesInListsWhenCollecting(List list) {
  Locations loc;
  list.forEach((fav) {
    if (cafeList.contains(fav)) {
      loc = (cafeList.singleWhere((element) => element.name == fav.name));
      loc.setFavorite();
    } else if (restaurantList.contains(fav)) {
      loc = (restaurantList.singleWhere((element) => element.name == fav.name));
      loc.setFavorite();
    } else if (petshopList.contains(fav)) {
      loc = (petshopList.singleWhere((element) => element.name == fav.name));
      loc.setFavorite();
    } else if (vetsList.contains(fav)) {
      loc = (vetsList.singleWhere((element) => element.name == fav.name));
      loc.setFavorite();
    }
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

Future getTrashCan() async {
  http.Response response = await http.get(Uri.parse(
      'https://openstreetgs.stockholm.se/geoservice/api/9f0bd873-30d2-40ad-99f3-7a32f115717f/wfs?request=GetFeature&typeName=od_gis:Skrapkorg_Punkt&outputFormat=JSON'));
  final jsonResponse = jsonDecode(response.body);
  FeatureCollection pin = new FeatureCollection.fromJson(jsonResponse);
  //Iterate through and convert coordinates
  pin.features.forEach((element) {
    trashCanList.add(LocationTrash(
        wgs84: convertPoint(element.geometry.coordinateLat.toDouble(),
            element.geometry.coordinateLong.toDouble())));
  });
}

Future getFavorites() async {
  http.Response response = await http.get(Uri.parse(
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/favorites/${auth.currentUser.uid}/.json'));
  if (response.body != 'null') {
    return favoriteList =
        locationListGenerator(Map.from(jsonDecode(response.body)), '');
  } else {
    return;
  }
}

Future<http.Response> postOrDeleteFavorite(
    LocationsFromDatabase favorite, String method) {
  final Map<String, dynamic> data = {favorite.name: favorite.toJson()};
  if (method == 'post') {
    print('inne i post');
    String url =
        'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/favorites/${auth.currentUser.uid}/.json';
    return http.patch(Uri.parse(url), body: jsonEncode(data));
  } else {
    print('inne i delete');
    String url =
        'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/favorites/${auth.currentUser.uid}/${favorite.name}.json';
    return http.delete(Uri.parse(url), body: jsonEncode(data));
  }
}

Future getPark() async {
  http.Response response = await http.get(Uri.parse(
      'https://openstreetgs.stockholm.se/geoservice/api/9f0bd873-30d2-40ad-99f3-7a32f115717f/wfs/?version=1.0.0&request=GetFeature&typeName=od_gis:Hundrastgard_Yta&outputFormat=JSON'));
  final jsonResponse = jsonDecode(response.body);
  FeatureCollectionPark pin = new FeatureCollectionPark.fromJson(jsonResponse);
  //Iterate through and convert coordinates
  pin.features.forEach((element) {
    double centerY;
    double centerX;
    List<CrsCoordinate> lista = [];
    element.geometry.getCoordinates().forEach((cord) {
      lista.add(convertPoint(cord.elementAt(1), cord.elementAt(0)));

      //GETTING THE MIDDLE COORDINATE
      List<double> testx = [];
      List<double> testy = [];
      for (int i = 0; i < lista.length; i++) {
        testx.add(lista[i].xLongitude);
      }
      for (int i = 0; i < lista.length; i++) {
        testy.add(lista[i].yLatitude);
      }

      double xMax = testx.reduce(max);
      double xMin = testx.reduce(min);
      double yMax = testy.reduce(max);
      double yMin = testy.reduce(min);

      centerX = xMin + ((xMax - xMin) / 2);
      centerY = yMin + ((yMax - yMin) / 2);
      //GETTING THE MIDDLE COORDINATE
    });
    parksList.add(LocationPark(
        latitude: centerY,
        longitude: centerX,
        name: element.id,
        wgs84Points: lista));
  });
}

Future getCheckInPark(LocationPark park) async {
  http.Response response = await http.get(Uri.parse(
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/parks/${park.name.substring(17)}.json'));
  Map<String, dynamic> data = jsonDecode(response.body);
  if (data != null && data.containsKey('dogscheckedin')) {
    CheckInParkLocation tempPark = CheckInParkLocation.fromJson(data);
    if (tempPark.dogsCheckedIn.isNotEmpty) {
      park.addList(tempPark.dogsCheckedIn);
    }
  } else if (data == null || !data.containsKey('dogscheckedin')) {
    List<Dog> empty = [];
    park.addList(empty);
  }
}

Future<http.Response> postOrDeleteCheckInPark(CheckInParkLocation park) async {
  String url =
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/parks/.json';
  final Map<String, dynamic> data = {park.name.substring(17): park.toJson()};
  String json = jsonEncode(data);
  return http.patch(Uri.parse(url), body: json);
}

Future postReview(Locations loc) async {
  String url =
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/${loc.type}/${loc.name}/Reviews/.json';
  String json = jsonEncode(loc.reviewsandpoints);
  return http.patch(Uri.parse(url), body: json);
}

List<Locations> locationListGenerator(Map data, String type) {
  List<Locations> list = [];
  data.forEach((key, value) {
    LocationsFromDatabase locationObject =
        LocationsFromDatabase.fromJson(value);
    list.add(Locations(
        adress: locationObject.adress,
        latitude: locationObject.latitude,
        longitude: locationObject.longitude,
        name: locationObject.name,
        type: type,
        reviewsandpoints: locationObject.reviews));
  });
  return list;
}

Future getPlacesFromFireBase(String type, listType enumType) async {
  http.Response response = await http.get(Uri.parse(
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/$type/.json'));
  Map<String, dynamic> data = Map.from(jsonDecode(response.body));
  var list = locationListGenerator(data, type);

  if (enumType == listType.cafe) {
    return cafeList = list;
  } else if (enumType == listType.petshop) {
    return petshopList = list;
  } else if (enumType == listType.restaurant) {
    return restaurantList = list;
  } else {
    return vetsList = list;
  }
}

Future postPlaceToFireBase(LocationsFromDatabase postLoc, String type) async {
  String url =
      'https://dogsthlm-default-rtdb.europe-west1.firebasedatabase.app/locations/$type/.json';
  final Map<String, dynamic> data = {postLoc.name: postLoc.toJson()};
  String json = jsonEncode(data);

  return http.patch(Uri.parse(url), body: json);
}
