import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  @override
  FavoriteState createState() => FavoriteState();
}

List<String> places = ["Park", "Cafe"];

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
          itemCount: places.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                trailing: IconButton(
                    icon: const Icon(Icons.delete), onPressed: () {
                      places.removeAt(index);
                      setState(() {
                      });
                }),
                onTap: () {},
                title: Text(places[index]),
              ),
            );
          }),
    );
  }
}
