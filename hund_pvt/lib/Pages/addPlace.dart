import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  @override
  AddPlaceState createState() => AddPlaceState();
}

class AddPlaceState extends State<AddPlace> {
  int group = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("Add a new place"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Radio(
                      value: 1,
                      autofocus: true,
                      groupValue: group,
                      onChanged: (T) {
                        print(T);
                        setState(() {
                          group = T;
                        });
                      }),
                  Text("Restaurant"),
                  Radio(
                      value: 2,
                      groupValue: group,
                      onChanged: (T) {
                        print(T);
                        setState(() {
                          group = T;
                        });
                      }),
                  Text("Café"),
                ],
              ),
              Row(
                children: <Widget>[
                  new Flexible(
                    child: new TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  new Flexible(
                    child: new TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Address",
                      ),
                    ),
                  ),
                ],
              ),
              FloatingActionButton(
                backgroundColor: Colors.pink,
                onPressed: () {
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ));
  }
}
