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
    addTrashMarkers(getTrashCanList.elementAt(0).wgs84.yLatitude,
        getTrashCanList.elementAt(0).wgs84.xLongitude);
    addTrashMarkers(getTrashCanList.elementAt(1).wgs84.yLatitude,
        getTrashCanList.elementAt(1).wgs84.xLongitude);
    addTrashMarkers(getTrashCanList.elementAt(2).wgs84.yLatitude,
        getTrashCanList.elementAt(2).wgs84.xLongitude);
    addTrashMarkers(getTrashCanList.elementAt(3).wgs84.yLatitude,
        getTrashCanList.elementAt(3).wgs84.xLongitude);
    addTrashMarkers(getTrashCanList.elementAt(4).wgs84.yLatitude,
        getTrashCanList.elementAt(4).wgs84.xLongitude);
    await getPark();
    getParksList.forEach((element) {
      List<LatLng> coord = [];
      element.wgs84Points.forEach((element) {
        coord.add(LatLng(element.yLatitude, element.xLongitude));
      });
      addParkPolygons(coord);
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
