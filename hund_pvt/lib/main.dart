import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "settings.dart";

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(59.325898, 18.0539599);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
            ]),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.5,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
    );
  }

  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getFilters();

  void filterScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Filter'),
          ),
          body: ListView.builder(
            itemCount: checkBoxListTileModel.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                  child: new Container(
                padding: new EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    new CheckboxListTile(
                      activeColor: Colors.red,
                      dense: true,
                      title: Text(checkBoxListTileModel[index].filter),
                      value: checkBoxListTileModel[index].isChecked,
                      secondary: Container(
                        height: 50,
                        width: 50,
                      ),
                      onChanged: (bool val) {
                        //itemChange(val, index);
                      },
                    )
                  ],
                ),
              ));
            },
          ));
    }));
  }
}

class CheckBoxListTileModel {
  String filter;
  bool isChecked;

  CheckBoxListTileModel({this.filter, this.isChecked});

  static List<CheckBoxListTileModel> getFilters() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(filter: 'Skräpkorgar', isChecked: true),
      //CheckBoxListTileModel(filter: 'Hundparker', isChecked: false),
    ];
  }
}
