import 'package:flutter/material.dart';
import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

class Favorite extends StatefulWidget {
  @override
  FavoriteState createState() => FavoriteState();
}

class FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: Text("Favourites", style: TextStyle(letterSpacing: 2)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 25),
            child: Container(
              width: 340,
              height: 600,
              child: ListView.builder(
                  itemCount: favoriteList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0x22000000),
                      shadowColor: Colors.transparent,
                      child: ListTile(
                        tileColor: Colors.transparent,
                        trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              Locations loc = favoriteList.elementAt(index);
                              loc.unFavorite();
                              LocationsFromDatabase favorite =
                                  LocationsFromDatabase(
                                      adress: loc.adress,
                                      name: loc.name,
                                      latitude: loc.latitude,
                                      longitude: loc.longitude);
                              await postOrDeleteFavorite(favorite, 'delete');
                              favoriteList.removeAt(index);
                              setState(() {});
                            }),
                        onTap: () {
                          Navigator.pop(context, favoriteList.elementAt(index));
                        },
                        title: Text(favoriteList[index].name,
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(favoriteList[index].adress,
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }),
            ),
          ),
        ));
  }
}
