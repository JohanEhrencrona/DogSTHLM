import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:hund_pvt/Services/markersets.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void collectApi() async {
    await getTrashCan();
    createTrashMarkers();
    await getPark();
    createParkMarkers();
    await getCafes();
    addMarkers(cafeList, sets.cafe, 0);
    await getPetshops();
    addMarkers(petshopList, sets.petshop, 3);
    await getRestaurants();
    addMarkers(restaurantList, sets.restaurant, 2);
    await getVets();
    addMarkers(vetsList, sets.vets, 5);

    //Navigator.pushReplacementNamed(context, '/login');
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
