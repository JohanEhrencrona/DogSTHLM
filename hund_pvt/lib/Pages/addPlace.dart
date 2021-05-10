import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/markersets.dart';
import 'package:geocoding/geocoding.dart';


class AddPlace extends StatefulWidget {
  @override
  AddPlaceState createState() => AddPlaceState();
}

class AddPlaceState extends State<AddPlace> {
  String key = 'restaurant';
  String address;
  int group = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("Add a new place"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Radio(
                      value: 1,
                      autofocus: true,
                      groupValue: group,
                      onChanged: (T) {
                        key = 'restaurant';
                        setState(() {
                          group = T;
                        });
                      }),
                  Text("Restaurant"),
                  Radio(
                      value: 2,
                      groupValue: group,
                      onChanged: (T) {
                        key = 'cafe';
                        setState(() {
                          group = T;
                        });
                      }),
                  Text("Café"),
                ],
              ),
              Row(
                children: <Widget>[
                  new Flexible(
                    child: new TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  new Flexible(
                    child: new TextField(
                      style: TextStyle(color: Colors.black),
                      onChanged: (T) {
                        address = T;
                      },
                      decoration: InputDecoration(
                        hintText: "Address",
                      ),
                    ),
                  ),
                ],
              ),
              FloatingActionButton(
                backgroundColor: Colors.pink,
                onPressed: () {
                  setLocation(address, key);
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ));
  }
}

void setLocation(String address, String key) async {

  List<Location> locations = await locationFromAddress(address);

  if (key == 'restaurant') {
    addRestaurantMarkers(locations.first.latitude, locations.first.longitude);
  }
  if (key == 'cafe') {
    addCafeMarkers(locations.first.latitude, locations.first.longitude);
  }
}