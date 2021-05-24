import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hund_pvt/Pages/reviewpage.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

TextStyle _style = TextStyle(color: Colors.white);

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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(location.name, style: TextStyle(letterSpacing: 2),),
        ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
//----------------------------------------------SOME ROOM AT TOP--------------------------------
            //Container(height: 10,), 
//----------------------------------------------------THE TILES------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                  "Nuvarande rating: ",
                  style: TextStyle(color: Colors.white, fontSize: 16)
                  ),
                ),
                  Wrap(
                      spacing: 5,
                      children: [
                        location.getFirstPaw(),
                        location.getSecondPaw(),
                        location.getThirdPaw(),
                        location.getFourthPaw(),
                        location.getFifthPaw(),
                      ],
                    ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
              height: 500,
              width: 340,
              child: ListView.builder(
              itemCount: location.reviewsandpoints.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Color(0x22000000),
                  shadowColor: Colors.transparent,
                  child: ListTile(
                    tileColor: Colors.transparent,
                    onTap: () {},
                    // TODO: Kolla över
                    title:
                        Text(location.reviewsandpoints.keys.elementAt(index), style: _style),
                    subtitle: Text(location.reviewsandpoints.values
                        .elementAt(index)
                        .toString(), 
                        style: _style),
                    trailing: Wrap(
                      spacing: 5,
                      children: [
                        location.getFirstPaw(),
                        location.getSecondPaw(),
                        location.getThirdPaw(),
                        location.getFourthPaw(),
                        location.getFifthPaw(),
                      ],
                    ),
                  ),
                );
              }
              ),
            ),
            ),
//---------------------------------------------------SOME SPACE-----------------------------------------
            Container(
              height: 20,
            ),
//--------------------------------------------------LÄMNA EN REVIEW KNAPP--------------------------------------------
          SizedBox(
            height: 50,
            child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Color(0x22000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            child: Text("Lämna en review", style: _style),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReviewPage(location)))
              .then((value) => setState(() {}));
            },
          ),
          ),
//------------------------------------------LÄMNA REVIEW END-----------------------------------
          ],
        )
      ),
    ));  
  }
}
