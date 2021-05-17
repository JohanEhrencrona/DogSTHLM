import 'package:firebase_auth/firebase_auth.dart';
import 'package:hund_pvt/Pages/registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text(
              'New Account',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                  builder: (context) => RegistrationPage(),
                ),
              );
            },
          ),
        ],
        title: Text(
          "Dog App",
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
      body:  Column(
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
                        autovalidateMode: AutovalidateMode.always, key: _formStateKey,
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
                                  labelText: "Email",
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
                                validator: validatePassword,
                                onSaved: (value) {
                                  _password = value;
                                },
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.pinkAccent,
                                          width: 2,
                                          style: BorderStyle.solid)),
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
                        data: ButtonBarThemeData(buttonTextTheme: ButtonTextTheme.accent),
                        child: ButtonBar(
                          children: <Widget>[
                            // ignore: deprecated_member_use
                            FlatButton(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              onPressed: () {
                                if (_formStateKey.currentState.validate()) {
                                  _formStateKey.currentState.save();
                                  signIn(_emailId, _password).then((user) {
                                    if (user != null) {
                                      print('Logged in successfully.');
                                      setState(() {
                                        successMessage =
                                        'Logged in successfully.';
                                      });
                                      Navigator.pushReplacementNamed(context, '/home');
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
                            // ignore: deprecated_member_use
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
                style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
              )
                  : Container()),
              (!isGoogleSignIn
                  // ignore: deprecated_member_use
                  ? RaisedButton(
                child: Text('Sign in with Google'),
                onPressed: () {
                  googleSignin(context).then((user) {
                    if (user != null) {
                      print('Logged in successfully.');
                      setState(() {
                        isGoogleSignIn = true;
                        successMessage =
                        'Logged in successfully.\nEmail : ${user.email}';
                      });
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      print('Error');
                    }
                  });
                },
              )
                  // ignore: deprecated_member_use
                  : RaisedButton(
                child: Text('Sign out'),
                onPressed: () {
                  googleSignout().then((response) {
                    if (response) {
                      setState(() {
                        isGoogleSignIn = false;
                        successMessage = '';
                      });
                    }
                  });
                },
              )),
            ],
          ));
  }

  Future<User> signIn(String email, String password) async {
    try {
      User user = (await auth.signInWithEmailAndPassword( //_CastError HERE
          email: email, password: password)).user;
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

  Future<User> googleSignin(BuildContext context) async {
    User currentUser;
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,);

      final User user = (await auth.signInWithCredential(credential)).user; // _CastError here
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      currentUser = await auth.currentUser;
      assert(user.uid == currentUser.uid);
      print(currentUser);
      print("User Name  : ${currentUser.displayName}");
    } catch (FirebaseAuthException) {
      handleError(FirebaseAuthException);
    }
    return currentUser;
  }

  Future<bool> googleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    return true;
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
    }  }

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
    if (value.trim().isEmpty || value.length<6) {
      return 'Enter a valid password';
    }
    return null;
  }
}
