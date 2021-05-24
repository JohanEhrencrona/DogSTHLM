import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

TextStyle _style = TextStyle(color: Colors.white);
OutlineInputBorder _outlineInputBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(25.0),borderSide: BorderSide(color: Colors.transparent,));
double _height = 50.0;
double _width = 50.0;

class ReviewPage extends StatefulWidget {
  final Locations location;

  ReviewPage(this.location);

  @override
  ReviewState createState() => ReviewState(location);
}

class ReviewState extends State<ReviewPage> {
  String reviewText;
  int points = 1;
  Locations location;

  ReviewState(Locations location) {
    this.location = location;
  }

  var blackPaw = Image.asset(
    'assets/images/dark-paw_symbol.png',
    //height: 50.0,
    //fit: BoxFit.cover,
  );
  var pinkPaw = Image.asset(
    'assets/images/white-paw_symbol.png',
    //height: 50.0,
    //fit: BoxFit.cover,
    color: Color(0xffCB4D56),
  );

  var secondPaw = Image.asset(
    'assets/images/dark-paw_symbol.png',
    //height: 30.0,
    //fit: BoxFit.cover,
  );
  var thirdPaw = Image.asset(
    'assets/images/dark-paw_symbol.png',
    //height: 30.0,
    //fit: BoxFit.cover,
  );
  var fourthPaw = Image.asset(
    'assets/images/dark-paw_symbol.png',
   // height: 30.0,
    //fit: BoxFit.cover,
  );
  var fifthPaw = Image.asset(
    'assets/images/dark-paw_symbol.png',
    //height: 30.0,
    //fit: BoxFit.cover,
  );

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
          title: Text(location.name, style: TextStyle(letterSpacing: 2)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                  "Lämna en recension till " + location.name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                  style: _style,
                  minLines: 8,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: Color(0xaaffffff)),
                    labelText: "Lämna en kommentar...",
                    fillColor: Color(0x22000000),
                    filled: true,
                    focusedBorder: _outlineInputBorder,
                    enabledBorder: _outlineInputBorder,
                  ),
                  onChanged: (T) {
                    reviewText = T;
                    print(reviewText);
                    setState(() {});
                  },
                ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Välj ditt betyg: ",
                        style: _style,
                      ),
                      SizedBox(
                        height: _height,
                        width: _width,
                        child: TextButton(
                          onPressed: () {
                            points = 1;
                            print(points);
                            setPaws(points);
                            setState(() {});
                          },
                          child: pinkPaw,
                        ),
                      ),
                      
                      SizedBox(
                        height: _height,
                        width: _width,
                        child: TextButton(
                          onPressed: () {
                            points = 2;
                            print(points);
                            setPaws(points);
                            setState(() {});
                          },
                          child: secondPaw,
                        ),
                      ),
                      SizedBox(
                        height: _height,
                        width: _width,
                        child: TextButton(
                          onPressed: () {
                            points = 3;
                            print(points);
                            setPaws(points);
                            setState(() {});
                          },
                          child: thirdPaw,
                        ),
                      ),
                      SizedBox(
                        height: _height,
                        width: _width,
                        child: TextButton(
                          onPressed: () {
                            points = 4;
                            print(points);
                            setPaws(points);
                            setState(() {});
                          },
                          child: fourthPaw,
                        ),
                      ),
                      SizedBox(
                        height: _height,
                        width: _width,
                        child: TextButton(
                          onPressed: () {
                            points = 5;
                            print(points);
                            setPaws(points);
                            setState(() {});
                          },
                          child: fifthPaw,
                        ),
                      ),
                    ]),
                    Container(height: 10,),
                    SizedBox(
                        height: 50,
                        child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0x22000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        child: Text("Skicka", style: _style),
                        onPressed: () async {
                          if (reviewText == null) {
                            showErrorDialog(context);
                          } else if (reviewText.isEmpty) {
                            showErrorDialog(context);
                          } else if (reviewText.isNotEmpty &&
                              reviewText != null) {
                            location.addReviewAndPoints(reviewText, points);
                            await postReview(location);

                            location.setInfoPaws(location.getPoints());

                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      ),
              ]),
          ),
        ))
    ); 
  }

  void setPaws(int points) {
    switch (points) {
      case 1:
        {
          secondPaw = blackPaw;
          thirdPaw = blackPaw;
          fourthPaw = blackPaw;
          fifthPaw = blackPaw;
          break;
        }
      case 2:
        {
          secondPaw = pinkPaw;
          thirdPaw = blackPaw;
          fourthPaw = blackPaw;
          fifthPaw = blackPaw;
          break;
        }
      case 3:
        {
          secondPaw = pinkPaw;
          thirdPaw = pinkPaw;
          fourthPaw = blackPaw;
          fifthPaw = blackPaw;
          break;
        }
      case 4:
        {
          secondPaw = pinkPaw;
          thirdPaw = pinkPaw;
          fourthPaw = pinkPaw;
          fifthPaw = blackPaw;
          break;
        }
      case 5:
        {
          secondPaw = pinkPaw;
          thirdPaw = pinkPaw;
          fourthPaw = pinkPaw;
          fifthPaw = pinkPaw;
          break;
        }
    }
  }
}

showErrorDialog(BuildContext context) {
  // set up the AlertDialog
  AlertDialog dialog = AlertDialog(
    title: Text("Error"),
    content: Text("A review can not be empty"),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
