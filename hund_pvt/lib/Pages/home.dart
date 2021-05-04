import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/getmarkersapi.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Services/markersets.dart';

String _mapStyle;

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
    controller.setMapStyle(_mapStyle);
  }

  //Google////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    getIcons();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

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
                    print(trashCanMarkers.toString());
                    print(parkPolygonsSet.first.toString());
                    print(markCounter);
                    setState(() {});
                  }),
              IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () async {
                    await getPark();
                    getParksList.forEach((element) {
                      List<LatLng> coord = [];
                      element.wgs84Points.forEach((element) {
                        coord
                            .add(LatLng(element.yLatitude, element.xLongitude));
                      });
                      addParkPolygons(coord);
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.get_app),
                  onPressed: () async {
                    await getTrashCan();
                    getTrashMarkers(
                        getTrashCanList.elementAt(0).wgs84.yLatitude,
                        getTrashCanList.elementAt(0).wgs84.xLongitude);
                    getTrashMarkers(
                        getTrashCanList.elementAt(1).wgs84.yLatitude,
                        getTrashCanList.elementAt(1).wgs84.xLongitude);
                    getTrashMarkers(
                        getTrashCanList.elementAt(2).wgs84.yLatitude,
                        getTrashCanList.elementAt(2).wgs84.xLongitude);
                    getTrashMarkers(
                        getTrashCanList.elementAt(3).wgs84.yLatitude,
                        getTrashCanList.elementAt(3).wgs84.xLongitude);
                    getTrashMarkers(
                        getTrashCanList.elementAt(4).wgs84.yLatitude,
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
        body: Container(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: getSet(),
            polygons: getPolygon(),
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.5,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.pink,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
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
            ],
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  Navigator.pushNamed(context, '/favorite');
                }
                if (index == 1) {
                  Navigator.pushNamed(context, '/filter');
                }
                if (index == 2) {
                  _showSearchModal(context);
                }
              });
            }),
      ),
    );
  }
}

void _showSearchModal(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          color: Colors.pink,
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.pink,
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