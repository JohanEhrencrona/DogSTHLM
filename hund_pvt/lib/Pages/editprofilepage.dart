import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hund_pvt/Services/userdatabase.dart';
import 'package:hund_pvt/Services/userswithdogs.dart';


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
    for (LoggedInUser i in userList){
      _dogName = i.dog.getName;
      _dogAge = i.dog.getAge.toString();
      _dogRace = i.dog.getRace;
    }
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
                                keyboardType: TextInputType.text,
                                initialValue: _dogName,
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
                                    Icons.pets,
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
                                keyboardType: TextInputType.text,
                                initialValue: _dogRace,
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
                                  labelText:"Race",
                                  icon: Icon(
                                    Icons.pets,
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
                                validator: validateInt,
                                onSaved: (value) {
                                  _dogAge = value;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: _dogAge,
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
                                    Icons.pets,
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
                                  pushChanges();
                                  for (LoggedInUser i in userList){
                                    _dogName = i.dog.setName(_dogName);
                                    _dogAge = i.dog.setAge(int.parse(_dogAge));
                                    _dogRace = i.dog.setRace(_dogRace);
                                  }
                                    setState(() {
                                      successMessage = 'Saved';
                                    });
                                    SavedChangedAlert();
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
    if (value.trim().length>50) {
      return 'Too long';
    }
    return null;
  }

  String validateInt(String value) {
    if (value.trim().isEmpty) {
      return 'Cant be empty';
    }
    if (int.tryParse(value)==null) {
      return 'Only enter numbers';
    }
    if (int.parse(value)>99) {
      return 'Number too large';
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


  pushChanges () async {
    await UserDatabaseService(uid: auth.currentUser.uid).pushUserData(_dogName, _dogRace, _dogAge);
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
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
          ],
        );
      },
    );
  }
}
