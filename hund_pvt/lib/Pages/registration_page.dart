import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hund_pvt/Services/userdatabase.dart';

import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  String _dogName;
  String _dogRace;
  String _dogAge;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');
  final _dogNameController = TextEditingController(text: '');
  final _dogRaceController = TextEditingController(text: '');
  final _dogAgeController = TextEditingController(text: '');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/')
        ),
        title: Text(
          "Register new account",
          style: TextStyle(letterSpacing: 2.0),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      key: _formStateKey,
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validateEmail,
                              onSaved: (value) {
                                _emailId = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailIdController,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.pinkAccent,
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                // hintText: "Company Name",
                                labelText: "Email"
                                    "",
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.pinkAccent,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validateString,
                              onSaved: (value) {
                                _dogName = value;
                              },
                              controller: _dogNameController,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.pinkAccent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelText: "Dog name",
                                icon: Icon(
                                  Icons.pets,
                                  color: Colors.pinkAccent,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validateString,
                              onSaved: (value) {
                                _dogRace = value;
                              },
                              controller: _dogRaceController,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.pinkAccent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelText: "Dog race",
                                icon: Icon(
                                  Icons.pets,
                                  color: Colors.pinkAccent,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validateString,
                              onSaved: (value) {
                                _dogAge = value;
                              },
                              controller: _dogAgeController,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.pinkAccent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelText: "Dog age",
                                icon: Icon(
                                  Icons.pets,
                                  color: Colors.pinkAccent,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validatePassword,
                              onSaved: (value) {
                                _password = value;
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.green,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                // hintText: "Company Name",
                                labelText: "Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.pinkAccent,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validateConfirmPassword,
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.pinkAccent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                // hintText: "Company Name",
                                labelText: "Confirm Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.pinkAccent,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ),
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
                      // make buttons use the appropriate styles for cards
                      data: ButtonBarThemeData(buttonTextTheme: ButtonTextTheme.accent),
                      child: ButtonBar(
                        children: <Widget>[
                          // ignore: deprecated_member_use
                          FlatButton(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.pinkAccent,
                              ),
                            ),
                            onPressed: () {
                              if (_formStateKey.currentState.validate()) {
                                _formStateKey.currentState.save();
                                signUp(_emailId, _password).then((user) {
                                  if (user != null) { //Successfully registered
                                    setState(() {
                                      successMessage =
                                      'Registered Successfully.';
                                    });
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (successMessage != 'Successfully registered account'
                ? Text(
              successMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.green),
            )
                : Container()),
          ],
        ),
      );
  }

  Future<User> signUp(email, password) async {
    try {
      User user = (await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email, password: password))
          .user;
      assert(user != null);

      assert(await user.getIdToken() != null);

      await UserDatabaseService(uid: user.uid).pushUserData(_dogName, _dogRace, _dogAge);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(FirebaseAuthException error) {
    setState(() {
      errorMessage = 'The email is already associated with an account';
    });
    }


  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 6 || value.length > 14) {
      return 'Please enter a valid password (6-14 characters)';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return 'The passwords are not matching';
    }
    return null;
  }

  String validateString(String value) {
    if (value.trim().isEmpty) {
      return 'Cant be empty';
    }
    return null;
  }
}
