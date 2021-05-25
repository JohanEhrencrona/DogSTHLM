import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  String _newPassword;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _newPasswordController = TextEditingController(text: '');
  final _confirmNewPasswordController = TextEditingController(text: '');
  InputBorder _inputBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(20)));

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
            title: Text("Change password", style: TextStyle(letterSpacing: 2)),
            centerTitle: true,
        ),
      body: SingleChildScrollView(
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
                            padding: EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 350,
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: validateEmail,
                                onSaved: (value) {
                                  _emailId = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailIdController,
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  labelText: "Email",
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
                            padding:
                                EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 350,
                              child: TextFormField(
                                validator: validatePassword,
                                style: TextStyle(color: Colors.white),
                                onSaved: (value) {
                                  _password = value;
                                },
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  labelText: "Password",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 350,
                              child: TextFormField(
                                validator: validatePassword,
                                style: TextStyle(color: Colors.white),
                                onSaved: (value) {
                                  _newPassword = value;
                                },
                                controller: _newPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  labelText: "New password",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 350,
                              child: TextFormField(
                                validator: validateConfirmPassword,
                                style: TextStyle(color: Colors.white),
                                controller: _confirmNewPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: _inputBorder,
                                  focusedErrorBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusedBorder: _inputBorder,
                                  labelText: "Confirm new password",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
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
                            width: 36,
                          ),
                          // ignore: deprecated_member_use
//-----------------------------------------SIGN IN BUTTON----------------------------------------------------------------
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0x22000000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Change password',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formStateKey.currentState.validate()) {
                                  _formStateKey.currentState.save();
                                  signIn(_emailId, _password).then((user) {
                                    user.updatePassword(_newPassword);
                                    if (user != null) {
                                      print('Password changed');
                                      setState(() {
                                        successMessage = 'Password changed';
                                      });

                                      PasswordChangedAlert();
                                    } else {
                                      setState(() {
                                        successMessage =
                                            'Incorrect email or password.';
                                      });
                                    }
                                  });
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
    ));
  }

  Future<User> signIn(String email, String password) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
              //_CastError HERE
              email: email,
              password: password))
          .user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      final User currentUser = await auth.currentUser;
      assert(user.uid == currentUser.uid);

      return user;
    } catch (FirebaseAuthException) {
      handleError(FirebaseAuthException);
      return null;
    }
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

  String validateConfirmPassword(String value) {
    if (value.trim() != _newPasswordController.text.trim()) {
      return 'The passwords are not matching';
    }
    return null;
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
    if (value.trim().isEmpty || value.length < 6) {
      return 'Enter a valid password';
    }
    return null;
  }

  Future<void> PasswordChangedAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Password has been changed'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
