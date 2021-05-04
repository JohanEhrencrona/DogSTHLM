import 'package:flutter/material.dart';
import 'package:hund_pvt/Pages/home.dart';
import 'package:hund_pvt/Pages/filter.dart';
import 'package:hund_pvt/Pages/settings.dart';
import 'package:hund_pvt/Pages/favorite.dart';
import 'package:hund_pvt/Pages/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/', //Create loadingscreen
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/filter': (context) => FilterScreen(),
      '/settings': (context) => Settings(),
      '/favorite': (context) => Favorite(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
