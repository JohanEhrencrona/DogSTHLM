import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Pages/settings.dart';
import 'package:hund_pvt/Services/getmarkersapi.dart';
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

  int markCounter = 1;

  void getMarkers(double lat, double long) {
    Marker mark = Marker(
      markerId: MarkerId('$markCounter'),
      position: LatLng(lat, long),
    );
    markCounter++;
    _testmarkers.add(mark);
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
                  icon: Icon(Icons.update),
                  onPressed: () {
                    setState(() {});
                  }),
              IconButton(
                  icon: Icon(Icons.print),
                  onPressed: () {
                    print(_testmarkers.toString());
                    print(markCounter);
                    setState(() {});
                  }),
              IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () {
                    getPark();
                  }),
              IconButton(
                  icon: Icon(Icons.get_app),
                  onPressed: () async {
                    await getTrashCan();
                    getMarkers(getTrashCanList.elementAt(0).wgs84.yLatitude,
                        getTrashCanList.elementAt(0).wgs84.xLongitude);
                    getMarkers(getTrashCanList.elementAt(1).wgs84.yLatitude,
                        getTrashCanList.elementAt(1).wgs84.xLongitude);
                    getMarkers(getTrashCanList.elementAt(2).wgs84.yLatitude,
                        getTrashCanList.elementAt(2).wgs84.xLongitude);
                    getMarkers(getTrashCanList.elementAt(3).wgs84.yLatitude,
                        getTrashCanList.elementAt(3).wgs84.xLongitude);
                    getMarkers(getTrashCanList.elementAt(4).wgs84.yLatitude,
                        getTrashCanList.elementAt(4).wgs84.xLongitude);
                  }),
              IconButton(
                icon: const Icon(Icons.settings_applications),
                tooltip: 'Settings',
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
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
              });
            }),
      ),
    );
  }
}
