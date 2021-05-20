import 'package:flutter/material.dart';
import 'package:hund_pvt/Pages/addPlace.dart';
import 'package:hund_pvt/Pages/home.dart';
import 'package:hund_pvt/Pages/filter.dart';
import 'package:hund_pvt/Pages/login_page.dart';
import 'package:hund_pvt/Pages/settings.dart';
import 'package:hund_pvt/Pages/favorite.dart';
import 'package:hund_pvt/Pages/loading.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/', //Create loadingscreen
    routes: {
      '/': (context) => LoginPage(),
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
      '/filter': (context) => FilterScreen(),
      '/settings': (context) => Settings(),
      '/favorite': (context) => Favorite(),
      '/addplace': (context) => AddPlace(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
