import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluster/fluster.dart';

import 'package:hund_pvt/Pages/infowindowwidget.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:hund_pvt/Pages/loading.dart';

int markCounter = 1;

enum sets { cafe, petshop, restaurant, vets, parks }

List<TrashMarkerCluster> trashCanMarkers = [];
Set<Polygon> parkPolygonsSet = {};
Set<Marker> restaurantMarkers = {};
Set<Marker> cafeMarkers = {};
Set<Marker> petshopMarkers = {};
Set<Marker> vetsMarkers = {};
Set<Marker> parkMarkers = {};

CustomInfoWindowController infoWindowController = CustomInfoWindowController();


void addMarkers(List list, sets type, int iconNumber) {
  list.forEach((element) {
    Marker mark = Marker(
        markerId: MarkerId(element.name),
        position: LatLng(element.latitude, element.longitude),
        icon: customIcons.elementAt(iconNumber),
        onTap: () {
          infoWindowController.addInfoWindow(
              InfoWindowWidget(
                currentLocation: element,
              ),
              LatLng(element.latitude, element.longitude));
        });
    markCounter++;
    if (type == sets.cafe) {
      cafeMarkers.add(mark);
    } else if (type == sets.petshop) {
      petshopMarkers.add(mark);
    } else if (type == sets.parks) {
      parkMarkers.add(mark);
    } else if (type == sets.vets) {
      vetsMarkers.add(mark);
    } else {
      restaurantMarkers.add(mark);
    }
  });
}

//ClusterTrash/////////////////////////////////////

void addTrashMarkersClusters(double lat, double long) {
  TrashMarkerCluster mark = TrashMarkerCluster(
    id: MarkerId('$markCounter'),
    position: LatLng(lat, long),
    icon: customIcons.elementAt(4),
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

class TrashMarkerCluster extends Clusterable {
  MarkerId id;
  LatLng position;
  BitmapDescriptor icon;

  TrashMarkerCluster({
    @required this.id,
    @required this.position,
    @required this.icon,
    isCluster = false,
  }) : super(
            markerId: id.toString(),
            latitude: position.latitude,
            longitude: position.longitude,
            isCluster: isCluster);

  Marker toMarker() => Marker(markerId: id, position: position, icon: icon);
}

Fluster<TrashMarkerCluster> fluster = Fluster<TrashMarkerCluster>(
    minZoom: 0,
    maxZoom: 18,
    radius: 200,
    extent: 2048,
    nodeSize: 2048,
    points: trashCanMarkers,
    createCluster: (BaseCluster cluster, double long, double lat) =>
        TrashMarkerCluster(
            id: MarkerId(cluster.id.toString()),
            position: LatLng(lat, long),
            icon: customIcons.elementAt(4),
            isCluster: cluster.isCluster));

//ClusterTrash/////////////////////////////////////


