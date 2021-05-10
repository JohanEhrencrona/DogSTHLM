import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Services/markersets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

String _mapStyle;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //BottomnavigationBar index
  int _currentIndex = 0;

  //Google/////////////////////////////////////////////////////////////
  GoogleMapController _controller;
  Location _location = Location();

  static const LatLng _center = const LatLng(59.325898, 18.0539599);

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    controller.setMapStyle(_mapStyle);
  }

  //Google////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    getIcons();
    requestPermission();
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
            //backgroundColor: Colors.pink,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Dog App", style: TextStyle(letterSpacing: 2.0),),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: 
              LinearGradient(begin:
              Alignment.topCenter, end: Alignment.bottomCenter, colors: 
              <Color>[
                Color(0xffDD5151), Color(0xff583177)
              ])),
            ),
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
                icon: const Icon(Icons.settings_applications),
                tooltip: 'Settings',
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ]),
        body: Stack(
          children: <Widget> [
            GoogleMap(
            onMapCreated: _onMapCreated,
            markers: getSet(),
            polygons: getPolygon(),
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.5,
            ),
          ),
          Positioned(
            top: 5,
            right: 340,
            child: IconButton(
              icon: Image.asset("assets/images/friends_symbol.png"),
              onPressed: () {},
            )
          )
          ]
          
        ),
        bottomNavigationBar: _createBottomNavigationBar(),
        
      ),
    );
  }


  Widget _createBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(gradient: 
                LinearGradient(begin:
                Alignment.topCenter, end: Alignment.bottomCenter, colors: 
                <Color>[
                  Color(0xffDD5151), Color(0xff583177)
                ])),
                child: BottomNavigationBar(
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
                  }
                )
    );
  }
}

Future<void> requestPermission() async { await Permission.location.request(); }

/*void _showSearchModal(context) {
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
*/
void _showSearchModal(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: 
              LinearGradient(begin:
              Alignment.topCenter, end: Alignment.bottomCenter, colors: 
              <Color>[
                Color(0xffDD5151), Color(0xff583177)
              ])),),
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