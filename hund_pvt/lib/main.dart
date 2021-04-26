import 'package:flutter/material.dart';
import 'package:hund_pvt/Pages/home.dart';
import 'package:hund_pvt/Pages/filter.dart';
import 'package:hund_pvt/Pages/settings.dart';
import 'package:hund_pvt/Pages/favorite.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home', //Create loadingscreen
    routes: {
      //'/': (context) => Loading(),
      '/home': (context) => Home(),
      '/filter': (context) => FilterScreen(),
      '/settings': (context) => Settings(),
      '/favorite': (context) => Favorite(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
