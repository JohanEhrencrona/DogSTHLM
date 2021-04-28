import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Pages/settings.dart';

import 'package:hund_pvt/Services/mapstest.dart';
import 'package:hund_pvt/Services/gettrashcans.dart';
import 'package:hund_pvt/maps.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //BottomnavigationBar index
  int _currentIndex = 0;

  //Google/////////////////////////////////////////////////////////////
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(59.325898, 18.0539599);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void getMarkers(double lat, double long) {
    Marker mark = Marker(
      markerId: MarkerId('test'),
      position: LatLng(lat, long),
    );
    //print(mark.position);
    _testmarkers.add(mark);
    print(_testmarkers.first);
    print(_testmarkers.last);
  }

  Set<Marker> _testmarkers = <Marker>{
    Marker(
      markerId: MarkerId('min'),
      position: LatLng(59.325898, 18.0539599),
    )
  };
  //Google////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.pink,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Dog App"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.get_app),
                  onPressed: () {
                    getTrashCan();
                  }),
              IconButton(
                icon: const Icon(Icons.settings_applications),
                tooltip: 'Settings',
                onPressed: () {
                  //Navigator.pushNamed(context, '/settings');
                  //testar json
                  //getTrashCan();
                  //double pointLat = getCoordinatesLat();
                  //double pointLong = getCoordinatesLong();
                  //getMarkers(pointLat, pointLong);
                },
              ),
            ]),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _testmarkers,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.5,
          ),
        ),
        //body: MapsLocation(),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.pink,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text("Favorite"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_alt_rounded),
                title: Text("Filter"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
              ),
            ],
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  Navigator.pushNamed(context, '/favorite');
                }
                if (index == 1) {
                  Navigator.pushNamed(context, '/filter');
                }
                //JSON test
                if (index == 2) {}
                setState(() {});
              });
            }),
      ),
    );
  }
}
