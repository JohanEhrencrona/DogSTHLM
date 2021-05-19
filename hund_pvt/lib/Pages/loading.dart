import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:hund_pvt/Services/markersets.dart';

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
      getCafes(),
      getPetshops(),
      getRestaurants(),
      getVets(),
      getFavorites(),
    ]).then((List _) => {
          createTrashMarkers(),
          createParkMarkers(),
          addMarkers(cafeList, sets.cafe, 0),
          addMarkers(petshopList, sets.petshop, 3),
          addMarkers(restaurantList, sets.restaurant, 2),
          addMarkers(vetsList, sets.vets, 5),
          markFavoritesInLists(favoriteList),
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
    return Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
            child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        )));
  }
}
