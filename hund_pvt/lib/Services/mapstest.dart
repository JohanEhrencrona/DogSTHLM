import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Pages/home.dart';


Completer<GoogleMapController> _controller = Completer();

List<Marker> _testMarkers = <Marker>[
  Marker(
      markerId: MarkerId('id'),
      position: LatLng(59.3360198, 18.0297926),
      infoWindow: InfoWindow(title: 'Marker title'))
];

const LatLng _center = const LatLng(59.325898, 18.0539599);

void _onMapCreated(GoogleMapController controller) {
  _controller.complete(controller);
}

Widget mapsWidget = Container(
  child: GoogleMap(
    onMapCreated: _onMapCreated,
    markers: Set<Marker>.of(_testMarkers),
    initialCameraPosition: CameraPosition(
      target: _center,
      zoom: 12.5,
    ),
  ),
);
