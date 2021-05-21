import 'package:flutter/material.dart';
import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';
import 'package:hund_pvt/Services/markersets.dart';
import 'package:geocode/geocode.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

class AddPlace extends StatefulWidget {
  @override
  AddPlaceState createState() => AddPlaceState();
}

class AddPlaceState extends State<AddPlace> {
  String key = 'restaurant';
  String name;
  String address;
  int group = 1;

  GeoCode geoCode = GeoCode(apiKey: 'AIzaSyCg6q-TOkJbrvDgrpv9Zz89ZWmgyCn2y18');

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
                  Radio(
                      value: 3,
                      groupValue: group,
                      onChanged: (T) {
                        key = 'petshop';
                        setState(() {
                          group = T;
                        });
                      }),
                  Text("Petshop"),
                ],
              ),
              Row(
                children: <Widget>[
                  new Flexible(
                    child: new TextField(
                      style: TextStyle(color: Colors.black),
                      onChanged: (T) {
                        name = T;
                      },
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
                        hintText: "Address, City",
                      ),
                    ),
                  ),
                ],
              ),
              FloatingActionButton(
                backgroundColor: Colors.pink,
                onPressed: () {
                  if (name == null || address == null) {
                    showErrorDialog(context, 'empty');
                  } else if (name.isEmpty || address.isEmpty) {
                    showErrorDialog(context, 'empty');
                  } else
                    setLocation(address, key);
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ));
  }

  void setLocation(String address, String key) async {
    try {
      Coordinates coordinates =
          await geoCode.forwardGeocoding(address: address);

      if (key == 'restaurant') {
        LocationsFromDatabase restaurant = LocationsFromDatabase(
          adress: address,
          name: name,
          latitude: coordinates.latitude,
          longitude: coordinates.longitude,
        );
        await postRestaurant(restaurant);
        print('restaurants innan ${restaurantMarkers.length}');
        await getRestaurants();
        restaurantMarkers = {};
        print('restaurants tömd ${restaurantMarkers.length}');
        addMarkers(restaurantList, sets.restaurant, 2);
        print('restaurants efter ${restaurantMarkers.length}');
        Navigator.of(context).pop();
      }
      if (key == 'cafe') {
        LocationsFromDatabase cafe = LocationsFromDatabase(
            adress: address,
            name: name,
            latitude: coordinates.latitude,
            longitude: coordinates.longitude);
        await postCafes(cafe);
        print('cafemarkers innan ${cafeMarkers.length}');
        await getCafes();
        cafeMarkers = {};
        print('cafemarkers tömd ${cafeMarkers.length}');
        addMarkers(cafeList, sets.cafe, 0);
        print('cafemarkers efter ${cafeMarkers.length}');
        Navigator.of(context).pop();
      }
      if (key == 'petshop') {
        LocationsFromDatabase petshop = LocationsFromDatabase(
            adress: address,
            name: name,
            latitude: coordinates.latitude,
            longitude: coordinates.longitude);
        await postPetShops(petshop);
        print('petshops innan ${petshopMarkers.length}');
        await getPetshops();
        petshopMarkers = {};
        print('petshops tömd ${petshopMarkers.length}');
        addMarkers(petshopList, sets.petshop, 3);
        print('petshops efter ${petshopMarkers.length}');
        Navigator.of(context).pop();
      }
    } catch (e) {
      showErrorDialog(context, 'notFound');
    }
  }
}

showErrorDialog(BuildContext context, String type) {
  String message;

  if (type == 'empty') {
    message = 'No fields can be empty';
  }
  if (type == 'notFound') {
    message = 'Address not found';
  }

  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog dialog = AlertDialog(
    title: Text("Error"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
