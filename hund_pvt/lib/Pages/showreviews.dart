import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hund_pvt/Pages/reviewpage.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

class ShowReviews extends StatefulWidget {
  final Locations location;

  ShowReviews(this.location);

  @override
  ShowReviewState createState() => ShowReviewState(location);
}

class ShowReviewState extends State<ShowReviews> {
  Locations location;

  ShowReviewState(Locations location) {
    this.location = location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(location.name),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
              itemCount: location.reviews.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {},
                    title: Text(location.reviews[index]),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => ReviewPage(location))).then((value) => setState((){}));
        },
        label: Text('Leave a review'),
        icon: Icon(Icons.rate_review),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
