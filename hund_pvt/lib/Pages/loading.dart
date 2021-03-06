import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:hund_pvt/Services/markersets.dart';

//http import for testing, to be able to send
// client as parameter.
import 'package:http/http.dart' as http;

List<BitmapDescriptor> customIcons = <BitmapDescriptor>[];

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void collectApi() async {
    return Future.wait([
      getTrashCan(),
      getPark(),
      getPlacesFromFireBase(http.Client(), 'cafes', listType.cafe),
      getPlacesFromFireBase(http.Client(), 'petshops', listType.petshop),
      getPlacesFromFireBase(http.Client(), 'restaurants', listType.restaurant),
      getPlacesFromFireBase(http.Client(), 'vets', listType.vets),
      getFavorites(http.Client()),
    ]).then((List _) => {
          createTrashMarkers(),
          createParkMarkers(),
          addMarkers(parksList, sets.parks, 1),
          addMarkers(cafeList, sets.cafe, 0),
          addMarkers(petshopList, sets.petshop, 3),
          addMarkers(restaurantList, sets.restaurant, 2),
          addMarkers(vetsList, sets.vets, 5),
          markFavoritesInListsWhenCollecting(favoriteList),
          Navigator.pushReplacementNamed(context, '/home'),
        });
  }

  @override
  void initState() {
    super.initState();
    getIcons();
    collectApi();
  }

  void getIcons() async {
    final cafeIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Cafe.png');
    customIcons.add(cafeIcon);
    final parkIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Dog_Park.png');
    customIcons.add(parkIcon);
    final restaurantIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Restaurants.png');
    customIcons.add(restaurantIcon);
    final shopIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Shop.png');
    customIcons.add(shopIcon);
    final trashIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Trash_Cans.png');
    customIcons.add(trashIcon);
    final vetIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Vet.png');
    customIcons.add(vetIcon);
    final favoriteIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)),
        'assets/images/favourites_symbol.png');
    customIcons.add(favoriteIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: SpinKitChasingDots(
              color: Colors.white,
              size: 50.0,
            ))));
  }
}
