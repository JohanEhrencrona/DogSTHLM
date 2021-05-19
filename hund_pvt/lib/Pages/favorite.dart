import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

class Favorite extends StatefulWidget {
  @override
  FavoriteState createState() => FavoriteState();
}

//List<String> places = ["Park", "Cafe"];

class FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: favoriteList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      favoriteList.removeAt(index);
                      setState(() {});
                    }),
                onTap: () {
                  Navigator.pop(context);
                },
                title: Text(favoriteList[index].name),
                subtitle: Text(favoriteList[index].adress),
              ),
            );
          }),
    );
  }
}
