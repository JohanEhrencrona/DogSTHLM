import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:hund_pvt/Services/markersets.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  /*void collectApi() async {
    Stopwatch tid = Stopwatch();
    tid.start();
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
    print(tid.elapsed);
    //Navigator.pushReplacementNamed(context, '/login');
    Navigator.pushReplacementNamed(context, '/home');
  } */

  void collectApi() async {
    return Future.wait([
      getTrashCan(),
      getPark(),
      getCafes(),
      //getData('cafes'),
      getPetshops(),
      getRestaurants(),
      getVets(),
    ]).then((List _) => {
          createTrashMarkers(),
          createParkMarkers(),
          addMarkers(cafeList, sets.cafe, 0),
          addMarkers(petshopList, sets.petshop, 3),
          addMarkers(restaurantList, sets.restaurant, 2),
          addMarkers(vetsList, sets.vets, 5),
          Navigator.pushReplacementNamed(context, '/home'),
        });

    //Navigator.pushReplacementNamed(context, '/login');
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
