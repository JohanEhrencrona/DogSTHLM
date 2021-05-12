import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hund_pvt/Services/getmarkersapi.dart';
import 'package:hund_pvt/Services/markersets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void collectApi() async {
    await getTrashCan();
    trashCanList.forEach((element) {
      addTrashMarkers(element.wgs84.yLatitude, element.wgs84.xLongitude);
    });
    await getPark();
    parksList.forEach((element) {
      List<LatLng> coord = [];
      element.wgs84Points.forEach((element) {
        coord.add(LatLng(element.yLatitude, element.xLongitude));
      });
      addParkPolygons(coord);
    });
    await getCafes();
    cafesList.forEach((element) {
      addCafeMarkers(element.latitude, element.longitude);
    });
    await getPetshops();
    petshopsList.forEach((element) {
      addPetshopMarkers(element.latitude, element.longitude);
    });
    await getRestaurants();
    restaurantsList.forEach((element) {
      addRestaurantMarkers(element.latitude, element.longitude);
    });
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    getIcons();
    collectApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
            child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        )));
  }
}
