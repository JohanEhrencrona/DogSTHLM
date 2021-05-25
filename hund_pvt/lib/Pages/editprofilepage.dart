import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _dogName;
  String _dogRace;
  String _dogAge;

  final _dogNameController = TextEditingController(text: '');
  final _dogRaceController = TextEditingController(text: '');
  final _dogAgeController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    getDogData("name");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formStateKey,
                      child: Column(
                        children: <Widget>[
//--------------------------------------------FIRST-----------------------------------------------------------
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Container(
                              width: 320,
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: validateString,
                                onSaved: (value) {
                                  _dogName = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _dogNameController,
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  labelText: "Name",
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  //fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
//--------------------------------------------------SECOND-------------------------------------------------------------
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Container(
                              width: 320,
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: validateString,
                                onSaved: (value) {
                                  _dogRace = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _dogRaceController,
                                initialValue: initDogName,
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  labelText: "Race",
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  //fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Container(
                              width: 320,
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: validateString,
                                onSaved: (value) {
                                  _dogAge = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _dogAgeController,
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  labelText: "Age",
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  //fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
//-------------------------------------------------------ENDS OF FIELDS---------------------------------------------------------
                        ],
                      ),
                    ),
                    (errorMessage != ''
                        ? Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          )
                        : Container()),
                    ButtonBarTheme(
                      data: ButtonBarThemeData(
                          buttonTextTheme: ButtonTextTheme.accent),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: <Widget>[
//---------------------------------------------CREATING SOME ROOM------------------------------------------------------
                          Container(
                            width: 50,
                          ),
                          // ignore: deprecated_member_use
//-----------------------------------------SIGN IN BUTTON----------------------------------------------------------------
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0x22000000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Save changes',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formStateKey.currentState.validate()) {
                                  _formStateKey.currentState.save();
                                  //Lägg in push till server
                                  if (true) {
                                    //Om den pushar till server
                                    setState(() {
                                      successMessage = 'Saved';
                                    });

                                    SavedChangedAlert();
                                  } else {
                                    setState(() {
                                      successMessage =
                                          'Incorrect email or password.';
                                    });
                                  }
                                }
                              },
                            ),
                          ),
//---------------------------------------CREATING SOME ROOM------------------------------------------------------------
                          Container(
                            width: 65,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (successMessage != ''
                ? Text(
                    successMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
                : Container()),
            Container(
              height: 94,
            ),
          ],
        )),
      ),
    );
  }

  String validateString(String value) {
    if (value.trim().isEmpty) {
      return 'Cant be empty';
    }
    return null;
  }

  handleError(FirebaseAuthException error) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Unable to sign in'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('The email or password is incorrect'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> loadDogData(String reference) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    var document = await users.doc(auth.currentUser.uid).get();
    return document.get(reference).toString();
  }

  String initDogName;
  getDogData(String reference) {
    print("2");
    FutureBuilder<String>(
      future: loadDogData(reference), // async work
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        print("1");
        String loadedName = loadDogData('name') as String;
        print("kom hit");

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            initDogName = "Loading";
            return null;
          default:
            if (snapshot.hasError) {
              initDogName = "Error";
              return null;
            } else {
              initDogName = loadedName;
              print("1");
              return null;
            }
        }
      },
    );
  }

  Future<void> SavedChangedAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Changes have been saved'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/settings'));
              },
            ),
          ],
        );
      },
    );
  }
}
