import 'package:flutter/material.dart';
import 'package:hund_pvt/Pages/showreviews.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:hund_pvt/Services/markersets.dart';

import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';

class InfoWindowWidget extends StatefulWidget {
  final Locations currentLocation;

  InfoWindowWidget({Key key, this.currentLocation}) : super(key: key);

  @override
  _InfoWindowWidgetState createState() => _InfoWindowWidgetState();
}

class _InfoWindowWidgetState extends State<InfoWindowWidget> {
  @override
  Widget build(BuildContext context) {
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
                                          "assets/images/cancel_symbol.png",
                                          width: 17,
                                          height: 17,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          infoWindowController.hideInfoWindow();
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
                                          widget.currentLocation.fav
                                              ? "assets/images/full_heart_symbol.png"
                                              : "assets/images/heart_symbol.png",
                                          width: 20,
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          if (widget.currentLocation.fav) {
                                            widget.currentLocation.unFavorite();
                                            LocationsFromDatabase favorite =
                                                LocationsFromDatabase(
                                                    adress: widget
                                                        .currentLocation.adress,
                                                    name: widget
                                                        .currentLocation.name,
                                                    latitude: widget
                                                        .currentLocation
                                                        .latitude,
                                                    longitude: widget
                                                        .currentLocation
                                                        .longitude);
                                            await removeFavorite(favorite);
                                            favoriteList
                                                .remove(widget.currentLocation);
                                          } else {
                                            widget.currentLocation
                                                .setFavorite();
                                            LocationsFromDatabase favorite =
                                                LocationsFromDatabase(
                                                    adress: widget
                                                        .currentLocation.adress,
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
                            ]),
                            Expanded(
                                child: Container(
                                    margin:
                                        EdgeInsets.only(left: 10, bottom: 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                        ),
                                        Padding(
                                          //platsens namn
                                          padding: EdgeInsets.only(
                                              left: 3, bottom: 3,top: 0),
                                          child: Text(
                                              widget.currentLocation.name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ),
                                        Padding(
                                          //lämna en reccension text
                                          padding: EdgeInsets.all(3),
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
                                          padding: EdgeInsets.all(3),
                                          child: InkWell(
                                            child: Text("Reviews",
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
                                              padding: EdgeInsets.all(3),
                                              child: widget.currentLocation
                                                  .getFirstPaw(),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: widget.currentLocation
                                                  .getSecondPaw(),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(3),
                                                child: widget.currentLocation
                                                    .getThirdPaw()),
                                            Padding(
                                                padding: EdgeInsets.all(3),
                                                child: widget.currentLocation
                                                    .getFourthPaw()),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: widget.currentLocation
                                                  .getFifthPaw(),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          //rapportera plats text
                                          padding: EdgeInsets.all(5),
                                          child: InkWell(
                                            child: Text("Report place",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white)),
                                            onTap: () {
                                              print('report');
                                            },
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
}
