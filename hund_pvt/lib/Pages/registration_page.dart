import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hund_pvt/Services/userdatabase.dart';
import 'package:image_picker/image_picker.dart';

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
  InputBorder _inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(20)));
  //BorderSide _borderSide = BorderSide(color: Colors.transparent);
  //BorderRadius _borderRadius = BorderRadius.all(Radius.circular(20));
  TextStyle _style = TextStyle(color: Colors.white);
  Color _fillColor = Color(0x22000000);

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 30, top: 40),
                      child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, '/loginpage')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 80, bottom: 30, top: 40),
                      child: Text(" Register ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              letterSpacing: 5)),
                    ),
                  ],
                ),
              ),
              Container(
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
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: TextFormField(
                                style: _style,
                                validator: validateEmail,
                                onSaved: (value) {
                                  _emailId = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailIdController,
                                decoration: InputDecoration(
                                  errorStyle: _style,
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  // hintText: "Company Name",
                                  labelText: "Email"
                                      "",
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  fillColor: _fillColor,
                                  filled: true,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: TextFormField(
                                style: _style,
                                validator: validateString,
                                onSaved: (value) {
                                  _dogName = value;
                                },
                                controller: _dogNameController,
                                decoration: InputDecoration(
                                  errorStyle: _style,
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  labelText: "Dog name",
                                  icon: Icon(
                                    Icons.pets,
                                    color: Colors.white,
                                  ),
                                  fillColor: _fillColor,
                                  filled: true,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: TextFormField(
                                style: _style,
                                validator: validateString,
                                onSaved: (value) {
                                  _dogRace = value;
                                },
                                controller: _dogRaceController,
                                decoration: InputDecoration(
                                  errorStyle: _style,
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  labelText: "Dog race",
                                  icon: Icon(
                                    Icons.pets,
                                    color: Colors.white,
                                  ),
                                  fillColor: _fillColor,
                                  filled: true,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: TextFormField(
                                style: _style,
                                validator: validateInt,
                                onSaved: (value) {
                                  _dogAge = value;
                                },
                                keyboardType: TextInputType.number,
                                controller: _dogAgeController,
                                decoration: InputDecoration(
                                  errorStyle: _style,
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  labelText: "Dog age",
                                  icon: Icon(
                                    Icons.pets,
                                    color: Colors.white,
                                  ),
                                  fillColor: _fillColor,
                                  filled: true,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: TextFormField(
                                style: _style,
                                validator: validatePassword,
                                onSaved: (value) {
                                  _password = value;
                                },
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  errorStyle: _style,
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  // hintText: "Company Name",
                                  labelText: "Password",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  fillColor: _fillColor,
                                  filled: true,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: TextFormField(
                                style: _style,
                                validator: validateConfirmPassword,
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  errorStyle: _style,
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  // hintText: "Company Name",
                                  labelText: "Confirm Password",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  fillColor: _fillColor,
                                  filled: true,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
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
                        data: ButtonBarThemeData(
                            buttonTextTheme: ButtonTextTheme.accent),
                        child: ButtonBar(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: TextButton(
                                key: ValueKey("RegisterButton"),
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0x22000000),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text("Register",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    )),
                                onPressed: () {
                                  if (_formStateKey.currentState.validate()) {
                                    _formStateKey.currentState.save();
                                    signUp(_emailId, _password).then((user) {
                                      if (user != null) {
                                        //Successfully registered
                                        setState(() {
                                          successMessage =
                                              'Registered Successfully.';
                                        });
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                            // ignore: deprecated_member_use
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
                      key: ValueKey("successMessage"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.green),
                    )
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }

  Future<User> signUp(email, password) async {
    try {
      User user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      assert(user != null);

      assert(await user.getIdToken() != null);

      await UserDatabaseService(uid: user.uid)
          .pushUserData(_dogName, _dogRace, _dogAge);
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
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    } else
      return null;
  }

  String validatePassword(String value) {
    Pattern passwordPattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])';
    RegExp passwordRegex = new RegExp(passwordPattern);
    if ((value.length < 8 || value.length > 16) ||
        !passwordRegex.hasMatch(value)) {
      return '(8-16 characters), 1 capitalized letter, 1 number';
    } else {
      return null;
    }
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
    if (value.trim().length > 50) {
      return 'Too long';
    }
    return null;
  }

  String validateInt(String value) {
    if (value.trim().isEmpty) {
      return 'Cant be empty';
    }
    if (int.tryParse(value) == null) {
      return 'Only enter numbers';
    }
    if (int.parse(value) > 99) {
      return 'Number too large';
    }
    return null;
  }
}
