import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hund_pvt/Pages/filter.dart';

List<BitmapDescriptor> _customIcons = <BitmapDescriptor>[];

int markCounter = 1;

Set<Marker> trashCanMarkers = {};
Set<Polygon> parkPolygonsSet = {};

void addTrashMarkers(double lat, double long) {
  Marker mark = Marker(
    markerId: MarkerId('$markCounter'),
    position: LatLng(lat, long),
    icon: _customIcons.elementAt(3),
  );
  markCounter++;
  trashCanMarkers.add(mark);
}

void addParkPolygons(List points) {
  parkPolygonsSet.add(Polygon(
    polygonId: PolygonId('$markCounter'),
    points: points,
    fillColor: Colors.green.withOpacity(0.8),
    strokeColor: Colors.yellow,
    strokeWidth: 1,
  ));
  markCounter++;
}

//Checkbox filter

Set<Marker> getSet() {
  Set<Marker> empty = {};
  if (checkBoxListTileModel[0].isChecked) {
    return trashCanMarkers;
  } else {
    return empty;
  }
}

Set<Polygon> getPolygon() {
  Set<Polygon> empty = {};
  if (checkBoxListTileModel[1].isChecked) {
    return parkPolygonsSet;
  } else {
    return empty;
  }
}

//Checkbox filter
void getIcons() async {
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
}
