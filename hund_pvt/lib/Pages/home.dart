import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> _testMarkers = <Marker>[];
List<BitmapDescriptor> _customIcons = <BitmapDescriptor>[];
String _mapStyle;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

const LatLng _center = const LatLng(59.325898, 18.0539599);

Completer<GoogleMapController> _controller = Completer();

void _onMapCreated(GoogleMapController controller) {
  _controller.complete(controller);
  controller.setMapStyle(_mapStyle);
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {
    getIcons();
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  getIcons() async {
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

    _testMarkers.add(Marker(
        markerId: MarkerId('ID'),
        position: LatLng(59.3360198, 18.0297926),
        icon: _customIcons.elementAt(0),
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
            markers: Set<Marker>.of(_testMarkers),
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.5,
            ),
          ),
        ),
        //body: new MapsScreenState().build(context),
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
