import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/getmarkersapi.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<BitmapDescriptor> _customIcons = <BitmapDescriptor>[];
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

  int markCounter = 1;

  void getMarkers(double lat, double long) {
    Marker mark = Marker(
      markerId: MarkerId('$markCounter'),
      position: LatLng(lat, long),
      icon: _customIcons.elementAt(3),
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
  void initState() {
    super.initState();
    getIcons();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  void getIcons() async {
    final cafeIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Cafe.png');
    _customIcons.add(cafeIcon);
    final parkIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Dog_Park.png');
    _customIcons.add(parkIcon);
    final restaurantIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Restaurants.png');
    _customIcons.add(restaurantIcon);
    final trashIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Trash_Cans.png');
    _customIcons.add(trashIcon);
    final vetIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)), 'assets/images/Vet.png');
    _customIcons.add(vetIcon);
    _addMarker();
  }

  void _addMarker() {
    _testmarkers.add(Marker(
        markerId: MarkerId('ID'),
        position: LatLng(59.3360198, 18.0297926),
        icon: _customIcons.elementAt(1),
        infoWindow: InfoWindow(title: 'Marker title')));
    setState(() {});
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
        body: Container(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _testmarkers,
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
