import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

class DogsInPark extends StatefulWidget {
  final LocationPark currentLoc;

  DogsInPark({this.currentLoc});

  @override
  DogsInParkState createState() => DogsInParkState();
}

class DogsInParkState extends State<DogsInPark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Dogs in the park right now"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: widget.currentLoc.dogsInPark.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {},
                title: Text(widget.currentLoc.dogsInPark[index].name),
                subtitle: Text(widget.currentLoc.dogsInPark[index].race),
                trailing:
                    Text(widget.currentLoc.dogsInPark[index].age.toString()),
              ),
            );
          }),
    );
  }
}
