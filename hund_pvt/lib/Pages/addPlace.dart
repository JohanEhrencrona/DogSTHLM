import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/markersets.dart';
import 'package:geocoding/geocoding.dart';

class AddPlace extends StatefulWidget {
  @override
  AddPlaceState createState() => AddPlaceState();
}

class AddPlaceState extends State<AddPlace> {
  String key = 'restaurant';
  String name;
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
                        hintText: "Address",
                      ),
                    ),
                  ),
                ],
              ),
              FloatingActionButton(
                backgroundColor: Colors.pink,
                onPressed: () {
                  if (name == null || address == null) {
                    showErrorDialog(context,'empty');
                  } else if (name.isEmpty || address.isEmpty) {
                    showErrorDialog(context,'empty');
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

    try{
      List<Location> location = await locationFromAddress(address);

      if (key == 'restaurant'){
        addRestaurantMarkers(location.first.latitude, location.first.longitude);
        Navigator.of(context).pop();
      }
      if (key == 'cafe'){
        addCafeMarkers(location.first.latitude, location.first.longitude);
        Navigator.of(context).pop();
      }
    }
    on NoResultFoundException catch(e) {
      showErrorDialog(context,'notFound');
    }
  }
}

showErrorDialog(BuildContext context,String type) {

  String message;

  if (type == 'empty'){
    message = 'No fields can be empty';
  }
  if (type == 'notFound'){
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