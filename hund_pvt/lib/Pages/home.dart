import 'package:flutter/material.dart';
import 'package:hund_pvt/Pages/settings.dart';

import 'package:hund_pvt/Services/mapstest.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.pink,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Dog App"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings_applications),
                tooltip: 'Settings',
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ]),
        body: mapsWidget,
        //body: new MapsScreenState().build(context),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.pink,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text("Favorite"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_alt_rounded),
                title: Text("Filter"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
              ),
            ],
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  Navigator.pushNamed(context, '/favorite');
                }
                if (index == 1) {
                  Navigator.pushNamed(context, '/filter');
                }
                if (index == 2) {
                  _showSearchModal(context);
                }
              });
            }),
      ),
    );
  }
}

void _showSearchModal(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          color: Colors.pink,
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.pink,
            title: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {},
                ),
                focusColor: Colors.white,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      });
}
