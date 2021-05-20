import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Pages/filter.dart';
import 'package:hund_pvt/Services/markersets.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:hund_pvt/Services/getmarkersfromapi.dart';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';

String _mapStyle;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //BottomnavigationBar index
  int _currentIndex = 0;
  double zoom = 12.5;

  //Google/////////////////////////////////////////////////////////////
  GoogleMapController _controller;
  final FirebaseAuth auth = FirebaseAuth.instance;
  //Cluster////////////////////////////////////////////////////////////
  void updateCluster(double zoom) {
    trashCans = fluster
        .clusters([-180, -85, 180, 85], zoom.toInt())
        .map((e) => e.toMarker())
        .toList();
  }

  List<Marker> trashCans = fluster
      .clusters([-180, -85, 180, 85], 12)
      .map((e) => e.toMarker())
      .toList();

  Set<Marker> getMarkers() {
    Set<Marker> showMarkers = {};
    Set<Marker> trashMarkers = {};

    if (checkBoxListTileModel[0].isChecked) {
      trashMarkers = trashCans.toSet();
      showMarkers.addAll(trashMarkers);
    } else if (showMarkers.containsAll(trashMarkers)) {
      showMarkers.removeAll(trashMarkers);
    }
    if (checkBoxListTileModel[1].isChecked) {
      showMarkers.addAll(parkMarkers);
    } else if (showMarkers.containsAll(parkMarkers)) {
      showMarkers.removeAll(parkMarkers);
    }
    if (checkBoxListTileModel[3].isChecked) {
      showMarkers.addAll(cafeMarkers);
    } else if (showMarkers.containsAll(cafeMarkers)) {
      showMarkers.removeAll(cafeMarkers);
    }
    if (checkBoxListTileModel[4].isChecked) {
      showMarkers.addAll(restaurantMarkers);
    } else if (showMarkers.containsAll(restaurantMarkers)) {
      showMarkers.removeAll(restaurantMarkers);
    }
    if (checkBoxListTileModel[5].isChecked) {
      showMarkers.addAll(petshopMarkers);
    } else if (showMarkers.containsAll(petshopMarkers)) {
      showMarkers.removeAll(petshopMarkers);
    }
    if (checkBoxListTileModel[2].isChecked) {
      showMarkers.addAll(vetsMarkers);
    } else if (showMarkers.containsAll(vetsMarkers)) {
      showMarkers.removeAll(vetsMarkers);
    }
    return showMarkers;
  }

  Set<Polygon> getPolygon() {
    Set<Polygon> empty = {};
    if (checkBoxListTileModel[1].isChecked) {
      return parkPolygonsSet;
    } else {
      return empty;
    }
  }
  //Cluster////////////////////////////////////////////////////////////

  static const LatLng _center = const LatLng(59.325898, 18.0539599);

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    controller.setMapStyle(_mapStyle);
    infoWindowController.googleMapController = _controller;
  }

  //Google////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    requestPermission();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  FutureOr poppingBack(dynamic value) {
    setState(() {}); //Updates google map when returning from filterScreen.
  }

  void goToMarker(Locations loc) {
    if (loc != null) {
      setState(() {
        checkBoxListTileModel.elementAt(1).isChecked = true;
        checkBoxListTileModel.elementAt(2).isChecked = true;
        checkBoxListTileModel.elementAt(3).isChecked = true;
        checkBoxListTileModel.elementAt(4).isChecked = true;
        checkBoxListTileModel.elementAt(5).isChecked = true;
      });
      getMarkers().forEach((element) {
        if (element.markerId.value == loc.name) {
          element.onTap();
          _controller.moveCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: element.position, zoom: 16.0)));
        }
      });
    }
  }

  void searchMarker(String loc) {
    setState(() {
      checkBoxListTileModel.elementAt(1).isChecked = true;
      checkBoxListTileModel.elementAt(2).isChecked = true;
      checkBoxListTileModel.elementAt(3).isChecked = true;
      checkBoxListTileModel.elementAt(4).isChecked = true;
      checkBoxListTileModel.elementAt(5).isChecked = true;
    });
    getMarkers().forEach((element) {
      if (element.markerId.value == loc) {
        element.onTap();
        _controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: element.position, zoom: 16.0)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            //backgroundColor: Colors.pink,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(
              "Dog App",
              style: TextStyle(letterSpacing: 2.0),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.print),
                  onPressed: () {
                    print('trashlist ${trashCanList.length}');
                    print('parklist ${parksList.length}');
                    print('cafelist ${cafeList.length}');
                    print('restaurantlist ${restaurantList.length}');
                    print('petshoplist ${petshopList.length}');
                    //print(favoriteList.first.name);
                    print(cafeList.first.reviewsandpoints.keys);
                    print(cafeList.first.reviewsandpoints.values);
                    print(cafeList.first.type);
                    print(petshopList.first.type);
                  }),
              IconButton(
                  icon: Icon(Icons.print),
                  onPressed: () {
                    print(trashCanMarkers.toString());
                    print(parkPolygonsSet.first.toString());
                    print(markCounter);
                    print(trashCans.first.position);
                    print(trashCanList.first.wgs84);
                    print(cafeMarkers.first.position);
                    print(parksList.first.wgs84Points);
                    setState(() {});
                  }),
              IconButton(
                icon: const Icon(Icons.settings_applications),
                tooltip: 'Settings',
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ]),
        body: Stack(children: <Widget>[
          GoogleMap(
              onMapCreated: _onMapCreated,
              markers: getMarkers(),
              polygons: getPolygon(),
              myLocationEnabled: true,
              onTap: (position) {
                infoWindowController.hideInfoWindow();
              },
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: zoom,
              ),
              onCameraMove: (position) {
                infoWindowController.onCameraMove();
                zoom = position.zoom;
              },
              onCameraIdle: () {
                updateCluster(zoom);
                setState(() {});
              }),
          CustomInfoWindow(
            controller: infoWindowController,
            height: 260,
            width: 260,
            offset: 25,
          ),
          Positioned(
              top: 5,
              right: 340,
              child: IconButton(
                icon: Image.asset("assets/images/friends_symbol.png"),
                onPressed: () {},
              ))
        ]),
        bottomNavigationBar: _createBottomNavigationBar(),
      ),
    );
  }

  Widget _createBottomNavigationBar() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/favourites_symbol.png",
                    height: 25),
                label: ("Favorite"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_alt_rounded),
                label: ("Filter"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: ("Search"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: ("Add new place"),
              ),
            ],
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  Navigator.pushNamed(context, '/favorite')
                      .then((value) => goToMarker(value));
                }
                if (index == 1) {
                  Navigator.pushNamed(context, '/filter').then(poppingBack);
                }
                if (index == 2) {
                  _showSearchModal(context);
                }
                if (index == 3) {
                  Navigator.pushNamed(context, '/addplace').then(poppingBack);
                }
              });
            }));
  }
}

Future<void> requestPermission() async {
  await Permission.location.request();
}

void _showSearchModal(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
            ),
            automaticallyImplyLeading: false,
            title: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {},
                ),
                focusColor: Colors.white,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      });
}
