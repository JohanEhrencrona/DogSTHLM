import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  ReviewState createState() => ReviewState();
}

class ReviewState extends State<ReviewPage> {
  String reviewText;
  int points;

  var blackPaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    height: 50.0,
    fit: BoxFit.cover,
  );
  var pinkPaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    height: 50.0,
    fit: BoxFit.cover,
    color: Colors.pink,
  );

  var secondPaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    height: 50.0,
    fit: BoxFit.cover,
  );
  var thirdPaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    height: 50.0,
    fit: BoxFit.cover,
  );
  var fourthPaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    height: 50.0,
    fit: BoxFit.cover,
  );
  var fifthPaw = Image.asset(
    'assets/images/fa-solid_paw.png',
    height: 50.0,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("Leave a review"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.pink),
                    labelText: "Enter text",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.pink,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (T) {
                    reviewText = T;
                    print(reviewText);
                    setState(() {
                    });
                  },
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: TextButton(
                          onPressed: () {
                            points = 1;
                            print(points);
                            secondPaw = blackPaw;
                            thirdPaw = blackPaw;
                            fourthPaw = blackPaw;
                            fifthPaw = blackPaw;
                            setState(() {
                            });
                          },
                          child: pinkPaw,
                        ),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            points = 2;
                            print(points);
                            secondPaw = pinkPaw;
                            thirdPaw = blackPaw;
                            fourthPaw = blackPaw;
                            fifthPaw = blackPaw;
                            setState(() {
                            });
                          },
                          child: secondPaw,
                        ),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            points = 3;
                            print(points);
                            secondPaw = pinkPaw;
                            thirdPaw = pinkPaw;
                            fourthPaw = blackPaw;
                            fifthPaw = blackPaw;
                            setState(() {
                            });
                          },
                          child: thirdPaw,
                        ),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            points = 4;
                            print(points);
                            secondPaw = pinkPaw;
                            thirdPaw = pinkPaw;
                            fourthPaw = pinkPaw;
                            fifthPaw = blackPaw;
                            setState(() {
                            });
                          },
                          child: fourthPaw,
                        ),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            points = 5;
                            print(points);
                            secondPaw = pinkPaw;
                            thirdPaw = pinkPaw;
                            fourthPaw = pinkPaw;
                            fifthPaw = pinkPaw;
                            setState(() {
                            });
                          },
                          child: fifthPaw,
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        child: Text('Submit'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.pink,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ])
              ]),
        ));
  }
}
