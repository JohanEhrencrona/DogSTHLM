import 'package:flutter/material.dart';
import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';
import 'package:hund_pvt/Services/markersets.dart';
import 'package:geocode/geocode.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

//http import for testing, to be able to send
// client as parameter.
import 'package:http/http.dart' as http;

class AddPlace extends StatefulWidget {
  @override
  AddPlaceState createState() => AddPlaceState();
}

List<CheckBoxListTileModel> checkBoxListTileModel =
    CheckBoxListTileModel.getFilters();

class AddPlaceState extends State<AddPlace> {
  String key = 'Restaurant';
  String name;
  String address;
  int group = 1;
  InputBorder _inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(20)));
  Color _fillColor = Color(0x22000000);
  TextStyle _style = TextStyle(color: Colors.white);

  GeoCode geoCode = GeoCode(apiKey: 'AIzaSyCg6q-TOkJbrvDgrpv9Zz89ZWmgyCn2y18');

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              title: Text("Add a new place"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
//---------------------------------------NAME FIELD---------------------------------------------
                  Text(
                    "Have you found a new dog friendly location? Add it and it will be shared with your fellow dog owners!",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                      child: Row(
                        children: <Widget>[
                          new Flexible(
                            child: new TextField(
                              style: TextStyle(color: Colors.white),
                              onChanged: (T) {
                                name = T;
                              },
                              decoration: InputDecoration(
                                errorBorder: _inputBorder,
                                focusedErrorBorder: _inputBorder,
                                enabledBorder: _inputBorder,
                                focusedBorder: _inputBorder,
                                labelStyle: _style,
                                hintStyle: _style,
                                hintText: "Name",
                                fillColor: _fillColor,
                                filled: true,
                              ),
                            ),
                          ),
                        ],
                      )),
//-------------------------------------------ADDRESS FIELD------------------------------------------
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: <Widget>[
                          new Flexible(
                            child: new TextField(
                              style: TextStyle(color: Colors.black),
                              onChanged: (T) {
                                address = T;
                              },
                              decoration: InputDecoration(
                                errorBorder: _inputBorder,
                                focusedErrorBorder: _inputBorder,
                                enabledBorder: _inputBorder,
                                focusedBorder: _inputBorder,
                                labelStyle: _style,
                                hintStyle: _style,
                                hintText: "Address, City",
                                fillColor: _fillColor,
                                filled: true,
                              ),
                            ),
                          ),
                        ],
                      )),
//------------------------------------------END ADDRESS FIELD----------------------------------------------
                  Text(
                    "Choose a location type: ",
                    style: _style,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                      height: 300,
                      width: 400,
                      child: ListView.builder(
                        itemCount: checkBoxListTileModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Card(
                              color: Colors.transparent,
                              shadowColor: Colors.transparent,
                              child: new Container(
                                padding: new EdgeInsets.all(0),
                                child: Column(
                                  children: <Widget>[
                                    Theme(
                                        //Gör så att man får vita borders på checkboxarna
                                        data: ThemeData(
                                            unselectedWidgetColor: Colors
                                                .white), //vita färgen väljs
                                        child: new CheckboxListTile(
                                          activeColor: Colors.transparent,
                                          checkColor: Colors.white,
                                          dense: false,
                                          title: Text(
                                            checkBoxListTileModel[index]
                                                .filtername,
                                            style: _style,
                                          ),
                                          value: checkBoxListTileModel[index]
                                              .isChecked,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          secondary: ImageIcon(
                                            checkBoxListTileModel[index]
                                                .imageTest,
                                            color: Colors.white,
                                          ),
                                          onChanged: (bool val) {
                                            itemChange(val, index);
                                            key = checkBoxListTileModel[index]
                                                .filtername
                                                .toString();
                                          },
                                        ))
                                  ],
                                ),
                              ));
                        },
                      )),

//-------------------------------------------OLD RADIO BUTTONS------------------------------------------
                  /*Row(
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
              ),*/
//-------------------------------------------------------CHECKBOXES--------------------------------------------------
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0x22000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("Add place +",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            )),
                        onPressed: () {
                          print(key);
                          if (name == null || address == null) {
                            showErrorDialog(context, 'empty');
                          } else if (name.isEmpty || address.isEmpty) {
                            showErrorDialog(context, 'empty');
                          } else
                            setLocation(address, key);
                        }),
                  ),
                ],
              ),
            )));
  }
//--------------------------------------------------------END CHECKBOXES----------------------------------------

  void itemChange(bool val, int index) {
    setState(() {
      if (val) {
        checkBoxListTileModel[0].isChecked = !val;
        checkBoxListTileModel[1].isChecked = !val;
        checkBoxListTileModel[2].isChecked = !val;
        checkBoxListTileModel[index].isChecked = val;
      } else {
        checkBoxListTileModel[0].isChecked = val;
        checkBoxListTileModel[1].isChecked = val;
        checkBoxListTileModel[2].isChecked = val;
        checkBoxListTileModel[index].isChecked = !val;
      }
    });
  }

  void setLocation(String address, String key) async {
    try {
      Coordinates coordinates =
          await geoCode.forwardGeocoding(address: address);
      LocationsFromDatabase placeToAdd = LocationsFromDatabase(
        adress: address,
        name: name,
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
      );

      if (key == 'Restaurant') {
        await postOrDeletePlaceToFireBase(
            http.Client(), placeToAdd, 'restaurants', 'post');
        await getPlacesFromFireBase(
            http.Client(), 'restaurants', listType.restaurant);
        restaurantMarkers = {};
        addMarkers(restaurantList, sets.restaurant, 2);
        Navigator.of(context).pop();
      }
      if (key == 'Café') {
        await postOrDeletePlaceToFireBase(
            http.Client(), placeToAdd, 'cafes', 'post');
        await getPlacesFromFireBase(http.Client(), 'cafes', listType.cafe);
        cafeMarkers = {};
        addMarkers(cafeList, sets.cafe, 0);
        Navigator.of(context).pop();
      }
      if (key == 'Petshop') {
        await postOrDeletePlaceToFireBase(
            http.Client(), placeToAdd, 'petshops', 'post');
        await getPlacesFromFireBase(
            http.Client(), 'petshops', listType.petshop);
        petshopMarkers = {};
        addMarkers(petshopList, sets.petshop, 3);
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

class CheckBoxListTileModel {
  String filtername;
  bool isChecked;
  AssetImage imageTest;

  CheckBoxListTileModel({this.filtername, this.isChecked, this.imageTest});

  static List<CheckBoxListTileModel> getFilters() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          filtername: 'Restaurant',
          isChecked: true,
          imageTest: AssetImage("assets/images/restaurant_symbol.png")),
      CheckBoxListTileModel(
          filtername: 'Café',
          isChecked: false,
          imageTest: AssetImage("assets/images/cafe_symbol.png")),
      CheckBoxListTileModel(
          filtername: 'Petshop',
          isChecked: false,
          imageTest: AssetImage("assets/images/bone_symbol.png")),
    ];
  }
}
