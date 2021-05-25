import 'package:flutter/material.dart';
import 'package:hund_pvt/Pages/dogsinpark.dart';
import 'package:hund_pvt/Pages/showreviews.dart';
import 'package:hund_pvt/Services/userswithdogs.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:hund_pvt/Services/markersets.dart';

import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';

import 'package:hund_pvt/Pages/home.dart';

class InfoWindowWidget extends StatefulWidget {
  final Locations currentLocation;
  final LocationPark currentParkLocation;

  InfoWindowWidget({Key key, this.currentLocation, this.currentParkLocation})
      : super(key: key);

  @override
  _InfoWindowWidgetState createState() => _InfoWindowWidgetState();
}

class _InfoWindowWidgetState extends State<InfoWindowWidget> {
  String checkInText;
  String maybeCheckOutFirst = 'Hundrastgård';

  @override
  Widget build(BuildContext context) {
    if (widget.currentLocation != null) {
      return Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              top: 0,
              child: Container(
                  margin: EdgeInsets.only(left: 30, top: 30),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                                colors: <Color>[
                                  Color(0xffDD5151),
                                  Color(0xff583177)
                                ]),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  blurRadius: 20,
                                  offset: Offset.zero,
                                  color: Colors.grey.withOpacity(0.5))
                            ]),
                        height: 210,
                        width: 200,
                        padding: EdgeInsets.all(5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(children: <Widget>[
                                //vänstra iconen/bilden
                                Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                          icon: Image.asset(
                                            widget.currentLocation.fav
                                                ? "assets/images/full_heart_symbol.png"
                                                : "assets/images/heart_symbol.png",
                                            width: 20,
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                          onPressed: () async {
                                            if (widget.currentLocation.fav) {
                                              widget.currentLocation
                                                  .unFavorite();
                                              LocationsFromDatabase favorite =
                                                  LocationsFromDatabase(
                                                      adress: widget
                                                          .currentLocation
                                                          .adress,
                                                      name: widget
                                                          .currentLocation.name,
                                                      latitude: widget
                                                          .currentLocation
                                                          .latitude,
                                                      longitude: widget
                                                          .currentLocation
                                                          .longitude);
                                              await removeFavorite(favorite);
                                              favoriteList.remove(
                                                  widget.currentLocation);
                                            } else {
                                              widget.currentLocation
                                                  .setFavorite();
                                              LocationsFromDatabase favorite =
                                                  LocationsFromDatabase(
                                                      adress: widget
                                                          .currentLocation
                                                          .adress,
                                                      name: widget
                                                          .currentLocation.name,
                                                      latitude: widget
                                                          .currentLocation
                                                          .latitude,
                                                      longitude: widget
                                                          .currentLocation
                                                          .longitude);
                                              await postFavorite(favorite);
                                              await getFavorites();
                                            }
                                            setState(() {});
                                          },
                                        ))),
                                //vänstra iconen/bilden

                                // creating some room between the symbols
                                Container(
                                  width: 94,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                          icon: Image.asset(
                                            "assets/images/cancel_symbol.png",
                                            width: 17,
                                            height: 17,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            infoWindowController
                                                .hideInfoWindow();
                                          },
                                        ))),
                              ]),
                              Expanded(
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                          ),
                                          Padding(
                                            //platsens namn
                                            padding: EdgeInsets.only(
                                                left: 2, bottom: 5),
                                            child: Text(
                                                widget.currentLocation.name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white)),
                                          ),
                                          Padding(
                                            //lämna en reccension text
                                            padding: EdgeInsets.all(2),
                                            child: InkWell(
                                              child: Text(
                                                widget.currentLocation.adress,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            //rapportera plats text
                                            padding: EdgeInsets.all(2),
                                            child: InkWell(
                                              child: Text(
                                                  "Reviews (${widget.currentLocation.reviewsandpoints.length})",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.white)),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ShowReviews(widget
                                                                .currentLocation)));
                                              },
                                            ),
                                          ),
                                          Row(
                                            //some paws
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(2),
                                                child: widget.currentLocation
                                                    .getFirstPaw(),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(2),
                                                child: widget.currentLocation
                                                    .getSecondPaw(),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(2),
                                                  child: widget.currentLocation
                                                      .getThirdPaw()),
                                              Padding(
                                                  padding: EdgeInsets.all(2),
                                                  child: widget.currentLocation
                                                      .getFourthPaw()),
                                              Padding(
                                                padding: EdgeInsets.all(2),
                                                child: widget.currentLocation
                                                    .getFifthPaw(),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            //rapportera plats text
                                            padding: EdgeInsets.only(
                                                bottom: 5, left: 2),
                                            child: InkWell(
                                              child: Text("Report place",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.white)),
                                              onTap: () {},
                                            ),
                                          ),
                                        ],
                                      ))),
                            ]),
                      ),
                      Triangle.isosceles(
                        edge: Edge.BOTTOM,
                        child: Container(
                          color: Color(0xffDD5151),
                          width: 20.0,
                          height: 15.0,
                        ),
                      ),
                    ],
                  )))
        ],
      );
    }
    if (widget.currentParkLocation.dogsInPark.contains(userList.first.dog)) {
      checkInText = 'Checka ut';
    } else {
      checkInText = 'Checka in';
    }
    return Stack(
      children: <Widget>[
        Positioned(
            left: 0,
            top: 0,
            child: Container(
                margin: EdgeInsets.only(left: 30, top: 30),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: <Color>[
                                Color(0xffDD5151),
                                Color(0xff583177)
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                blurRadius: 20,
                                offset: Offset.zero,
                                color: Colors.grey.withOpacity(0.5))
                          ]),
                      height: 210,
                      width: 200,
                      padding: EdgeInsets.all(5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(children: <Widget>[
                              // creating some room between the symbols
                              Container(
                                width: 94,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                        icon: Image.asset(
                                          "assets/images/cancel_symbol.png",
                                          width: 17,
                                          height: 17,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          infoWindowController.hideInfoWindow();
                                        },
                                      ))),
                              Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                  )),
                            ]),
                            Expanded(
                                child: Container(
                                    margin:
                                        EdgeInsets.only(left: 10, bottom: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                        ),
                                        Padding(
                                          //platsens namn
                                          padding: EdgeInsets.only(
                                              left: 2, bottom: 5),
                                          child: Text(maybeCheckOutFirst,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white)),
                                        ),
                                        Padding(
                                            //platsens namn
                                            padding: EdgeInsets.only(
                                                left: 2, bottom: 5),
                                            child: InkWell(
                                              child: Text('Dogs in park :',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.white)),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                            new DogsInPark(
                                                                currentLoc: widget
                                                                    .currentParkLocation)));
                                              },
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, bottom: 5),
                                          child: Text(
                                              widget.currentParkLocation
                                                  .getDogs(),
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 5, left: 2),
                                          child: InkWell(
                                            child: Text("Show all",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white)),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          new DogsInPark(
                                                              currentLoc: widget
                                                                  .currentParkLocation)));
                                            },
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 2, bottom: 2),
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  var ancestralState = context
                                                      .findRootAncestorStateOfType();
                                                  if (widget.currentParkLocation
                                                      .dogsInPark
                                                      .contains(
                                                          userList.first.dog)) {
                                                    await checkOutFromPark(
                                                        parkForRemovingOrAddingFireBase(
                                                            widget
                                                                .currentParkLocation));
                                                    userList.first
                                                        .setCheckedIn(false);
                                                    setState(() {});
                                                    ancestralState
                                                        .setState(() {});
                                                  } else if (userList
                                                          .first.checkedIn !=
                                                      true) {
                                                    await checkInToPark(
                                                        parkForRemovingOrAddingFireBase(
                                                            widget
                                                                .currentParkLocation));
                                                    userList.first
                                                        .setCheckedIn(true);
                                                    setState(() {});
                                                    ancestralState
                                                        .setState(() {});
                                                  } else {
                                                    maybeCheckOutFirst =
                                                        'Checka ut först';
                                                    setState(() {});
                                                  }
                                                },
                                                child: Text(
                                                  checkInText,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),
                                                ))),
                                      ],
                                    ))),
                          ]),
                    ),
                    Triangle.isosceles(
                      edge: Edge.BOTTOM,
                      child: Container(
                        color: Color(0xffDD5151),
                        width: 20.0,
                        height: 15.0,
                      ),
                    ),
                  ],
                )))
      ],
    );
  }

  Future<void> checkInToPark(CheckInParkLocation park) async {
    widget.currentParkLocation.dogsInPark.add(userList.first.dog);
    setParkForCheckInWidget(widget.currentParkLocation, true);
    await postCheckInPark(park);
    await getCheckInPark(widget.currentParkLocation);
  }

  Future<void> checkOutFromPark(CheckInParkLocation park) async {
    widget.currentParkLocation.dogsInPark.remove(userList.first.dog);
    setParkForCheckInWidget(widget.currentParkLocation, false);
    await removeCheckInPark(park);
    await getCheckInPark(widget.currentParkLocation);
  }
}
