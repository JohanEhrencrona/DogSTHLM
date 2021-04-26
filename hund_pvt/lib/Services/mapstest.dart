import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Completer<GoogleMapController> _controller = Completer();

const LatLng _center = const LatLng(59.325898, 18.0539599);

void _onMapCreated(GoogleMapController controller) {
  _controller.complete(controller);
}

Widget mapsWidget = Container(
  child: GoogleMap(
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
      target: _center,
      zoom: 12.5,
    ),
  ),
);
